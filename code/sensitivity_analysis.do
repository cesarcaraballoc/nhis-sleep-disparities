
u sleep,clear
set seed 10000
g random=runiform()
egen deciles_hr=xtile( random ), by( hrsleep ) nq(10)

tab deciles_hr hrsleep 

gen new_sleep=hrsleep+((deciles_hr/10)) // creates fractions of an hour (1/10)
tab  new_sleep hrsleep // all hours are distributed in 10 bins with the same number of participants

gen unbiased_sleep=.
replace unbiased_sleep=(new_sleep+1.22) if white==1 // white individuals overestimate sleep by 73 minutes (1.22hrs)
replace unbiased_sleep=(new_sleep+0.9) if black==1 // black individuals overestimate sleep by 54 minutes (0.9 hrs)

gen unbiased_less_sleep=0
replace unbiased_less_sleep=1 if unbiased_sleep<7

gen unbiased_good_sleep=0
replace unbiased_good_sleep=1 if unbiased_sleep>=7 & unbiased_sleep<=9

gen unbiased_long_sleep=0
replace unbiased_long_sleep=1 if unbiased_sleep>9


gen byte sleep=unbiased_less_sleep*0 + unbiased_good_sleep*1 + unbiased_long_sleep*2


save temp, replace                                       

	local zcrit=invnorm(.975)
	set seed 20201209                                         
	local iters 10000                                         
	local lb = round(`iters'*0.025)
	local ub = round(`iters'*0.975)

	capture postclose rates
	postfile rates str10 group float year rate_less_ rate_long_ rate_good_ stderr_less_ stderr_long_ stderr_good_ ///
				  lb_less_ lb_long_ lb_good_ ub_less_ ub_long_ ub_good_ using ratefile, replace
	
	*****

	qui foreach G in white black { 
		u temp, clear
		svy, subpop(`G'): mlogit sleep C_age C_neast C_midwest C_south C_west year_*, nocons  
		matrix z=e(b)  
		matrix V=e(V)
		local y0=colnumb(z,"0:year_2004")
		local y2=colnumb(z,"2:year_2004")
		drawnorm x1-x60, means(z) cov(V) clear n(`iters')  
		
		forv y=2004/2018 {
			local n0=(`y'-2004)+`y0'
                        local n2=(`y'-2004)+`y2'
			gen denom=1+exp(x`n0')+exp(x`n2')
			gen rate_less=exp(x`n0')/denom
			gen rate_long=exp(x`n2')/denom
			gen rate_good=1/denom
			foreach O in less long good {
				sort rate_`O'
				sum rate_`O'
				local rate_`O'=r(mean)	
				local se_`O'=r(sd)
				local lb_`O'=rate_`O'[`lb']
				local ub_`O'=rate_`O'[`ub']
			}
			post rates ("`G'") (`y') (`rate_less') (`rate_long') (`rate_good') (`se_less') (`se_long') (`se_good') ///
				  (`lb_less') (`lb_long') (`lb_good') (`ub_less') (`ub_long') (`ub_good')
			drop rate_* denom
		}
	
	}	

postclose rates
u ratefile, clear
reshape wide rate_* stderr_* lb_* ub_* , i(year) j(group) string

save ratefile_biased_sleep, replace


local zcrit=invnorm(.975)

foreach K in less good long {

     gen diff_`K'_black=(rate_`K'_black - rate_`K'_white)     
     gen diff_`K'_black_SE = sqrt(stderr_`K'_black^2 + stderr_`K'_white^2)
     gen diff_`K'_black_lb=diff_`K'_black-diff_`K'_black_SE*`zcrit'
     gen diff_`K'_black_ub=diff_`K'_black+diff_`K'_black_SE*`zcrit'
     gen wt_diff_`K'_black= 1/diff_`K'_black_SE^2 
		
	}


qui {
foreach K in less good long {	
	
	foreach R in white black    {
		gen wt_`K'_`R'=1/(stderr_`K'_`R')^2         

}
}


noi {
	display " "
	display " "
	disp "**********************************************"
	display "Change in prevalence"
	disp "**********************************************"
	display " "
	foreach R in white black    {
    reg rate_less_`R' year [aw=wt_less_`R'] 

}
}

noi {
	display " "
	display " "
	disp "**********************************************"
	display "Change in disparities"
	disp "**********************************************"
	display " "
	foreach P in black   {
    reg diff_less_`P' year [aw=(wt_diff_less_`P')]  


}
}
 
keep if inlist(year,2004,2018)
sort year

local zcrit=invnorm(.975)
qui {

	noi display " "
foreach R in white black    {

	noi display " "
	noi display " "
	noi disp "**********************************************"
	noi disp "Change in short sleep prevalence, 2004-2018"
	noi disp "**********************************************"
    local diff=rate_less_`R'[2]-rate_less_`R'[1]         
    local SE = sqrt(stderr_less_`R'[2]^2+stderr_less_`R'[1]^2)
    local lb=`diff'-`zcrit'*`SE'
    local ub=`diff'+`zcrit'*`SE'
    local Pval=(2*(1-normal(abs(`diff'/`SE'))))
    local Pval=cond(`Pval'<0.001,"<0.001",string(`Pval',"%5.3f"))
    noi di "`R'" _col(20) %5.2f `diff'*100 _col(30) "(" %5.2f `lb'*100 "," %5.2f `ub'*100 ")" _col(50) "`Pval'"
	

}
}



qui {
	
	noi display " "
	noi display " "
	noi disp "**********************************************"
	noi disp "Change in short sleep disparity, 2004-2018"
	noi disp "**********************************************"
    local diff_1=rate_less_black[1]-rate_less_white[1]         
    local diff_2=rate_less_black[2]-rate_less_white[2]        
    local did=`diff_2'-`diff_1'
    local SE_1= sqrt(stderr_less_black[1]^2+stderr_less_white[1]^2) 
    local SE_2= sqrt(stderr_less_black[2]^2+stderr_less_white[2]^2) 
    local SE_did=sqrt(`SE_2'^2+`SE_1'^2)
    local lb=`did'-`zcrit'*`SE_did'
    local ub=`did'+`zcrit'*`SE_did'
    local Pval=2*(1-normal(abs(`did'/`SE_did')))
    local Pval=cond(`Pval'<0.001,"<0.001",string(`Pval',"%5.3f"))
    noi di "black" _col(20) %5.2f `did'*100 _col(30) "(" %5.2f `lb'*100 "," %5.2f `ub'*100 ")" _col(50) "`Pval'"
}


qui if year==2004  {


	noi display " "
	noi display " "
	noi disp "**********************************************"
	noi disp "Disparity in short sleep, 2004"
	noi disp "**********************************************"
    local Pval=2*(1-normal(abs(diff_less_black/diff_less_black_SE)))
    local Pval=cond(`Pval'<0.001,"<0.001",string(`Pval',"%5.3f"))
  noi disp "black-white '04" _col(20) %5.2f diff_less_black*100 _col(30) "(" %5.2f diff_less_black_lb*100 "," %5.2f diff_less_black_ub*100 ")" _col(50) "`Pval'"



}


qui { 
keep if year==2018


	noi display " "
	noi display " "
	noi disp "**********************************************"
	noi disp "Disparity in short sleep, 2018"
	noi disp "**********************************************"
    local Pval=2*(1-normal(abs(diff_less_black/diff_less_black_SE)))
    local Pval=cond(`Pval'<0.001,"<0.001",string(`Pval',"%5.3f"))
  noi disp "black-white '18" _col(20) %5.2f diff_less_black*100 _col(30) "(" %5.2f diff_less_black_lb*100 "," %5.2f diff_less_black_ub*100 ")" _col(50) "`Pval'"




}
}  

** figure

use ratefile_biased_sleep,clear

#delimit ;
 mylabels 0(5)30, myscale(@/100) local(myla) ;

twoway 

	(connected rate_less_black year, 
		lpattern(solid) lcolor(cranberry) lwidth(medium) msymbol(s) mcolor(cranberry)
		graphregion(color(none))
		) 


	(connected rate_less_white year, 
		lpattern(solid) lcolor(lavender) lwidth(medium) msymbol(d) mcolor(lavender)
		graphregion(color(none))
		)
		
		(rcap lb_less_black ub_less_black year, lwidth(thin) lpattern(solid) lcolor(cranberry))
		(rcap lb_less_white ub_less_white year, lwidth(thin) lpattern(solid) lcolor(lavender))
		,
		
		
	xlabel(2004(1)2018) xtitle("Year of interview", size(small)) 
	xlabel(, labsize(vsmall) angle(forty_five) valuelabel nogrid) 
	ylabel(`myla', angle(horizontal)) ytitle("Estimated percent reporting fewer than 7 hours of sleep", size(small))
	subtitle("", size(small)) 
	legend(

		order(1 "Black" 2 "White")
		size(small) position(11) ring(0) col(2)
		region(fcolor(white)) bmargin(small) 
		title(""))
	xsize(8) ysize(5)
	scheme(plotplainblind) 
	;
#delimit cr
