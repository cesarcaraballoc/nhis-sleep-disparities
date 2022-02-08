/* 

			Temporal Trends in Racial and Ethnic Disparities in Sleep 
				Duration in the United States, 2004–2018

César Caraballo, Shiwani Mahajan, Javier Valero-Elizondo, Daisy Massey, Yuan Lu,
Brita Roy, Carley Riley, Amarnath R. Annapureddy, Karthik Murugiah, Johanna Elumn,
Khurram Nasir, Marcella Nunez-Smith, Howard P. Forman, Chandra L. Jackson, 
Jeph Herrin, Harlan M. Krumholz

medRxiv 2021.10.31.21265202

Available from: https://doi.org/10.1101/2021.10.31.21265202

			
	Trends in prevalence and disparities 
	
	This .do file provides the change in prevalence and disparities of short, 
	recommended, and long sleep duration by race/ethnicity, from 2004 to 2018. 
	
*/

**#			1. Overall


use ratefile_sleep_all, clear
	local zcrit=invnorm(.975)


foreach K in less good long {
	foreach D in black asian hisp {
     gen diff_`K'_`D'=(rate_`K'_`D' - rate_`K'_white)     
     gen diff_`K'_`D'_SE = sqrt(stderr_`K'_`D'^2 + stderr_`K'_white^2)
     gen diff_`K'_`D'_lb=diff_`K'_`D'-diff_`K'_`D'_SE*`zcrit'
     gen diff_`K'_`D'_ub=diff_`K'_`D'+diff_`K'_`D'_SE*`zcrit'
     gen wt_diff_`K'_`D'= 1/diff_`K'_`D'_SE^2 
		}
	}


qui {
foreach K in less good long {	
foreach R in white black asian hisp allfour {
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
	foreach R in white black asian hisp allfour {
    reg rate_less_`R' year [aw=wt_less_`R'] 
    reg rate_good_`R' year [aw=wt_good_`R'] 
    reg rate_long_`R' year [aw=wt_long_`R'] 
}
}

noi {
	display " "
	display " "
	disp "**********************************************"
	display "Change in disparities"
	disp "**********************************************"
	display " "
	foreach P in black asian hisp {
    reg diff_less_`P' year [aw=(wt_diff_less_`P')]  
    reg diff_good_`P' year [aw=(wt_diff_good_`P')] 
    reg diff_long_`P' year [aw=(wt_diff_long_`P')]  

}
}
 
keep if inlist(year,2004,2018)
sort year

local zcrit=invnorm(.975)
qui {
	noi display " "
	noi display " "
	noi disp "**********************************************"
	noi disp "**********************************************"
	noi disp "Change in prevalence"
	noi disp "**********************************************"
	noi disp "**********************************************"
	noi display " "
	noi display " "
foreach R in white black asian hispanic allfour {

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
	

	noi display " "
	noi display " "
	noi disp "**********************************************"
	noi disp "Change in recommended sleep prevalence, 2004-2018"
	noi disp "**********************************************"
    local diff=rate_good_`R'[2]-rate_good_`R'[1]         
    local SE = sqrt(stderr_good_`R'[2]^2+stderr_good_`R'[1]^2)
    local lb=`diff'-`zcrit'*`SE'
    local ub=`diff'+`zcrit'*`SE'
    local Pval=(2*(1-normal(abs(`diff'/`SE'))))
    local Pval=cond(`Pval'<0.001,"<0.001",string(`Pval',"%5.3f"))
    noi di "`R'" _col(20) %5.2f `diff'*100 _col(30) "(" %5.2f `lb'*100 "," %5.2f `ub'*100 ")" _col(50) "`Pval'"

	noi display " "
	noi display " "
	noi disp "**********************************************"
	noi disp "Change in long sleep prevalence, 2004-2018"
	noi disp "**********************************************"
    local diff=rate_long_`R'[2]-rate_long_`R'[1]         
    local SE = sqrt(stderr_long_`R'[2]^2+stderr_long_`R'[1]^2)
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
	noi disp "**********************************************"
	noi disp "Change in disparities"
	noi disp "**********************************************"
	noi disp "**********************************************"
	noi display " "
	noi display " "
	
foreach R in black asian hisp {
	
	noi display " "
	noi display " "
	noi disp "**********************************************"
	noi disp "Change in short sleep disparity, 2004-2018"
	noi disp "**********************************************"
    local diff_1=rate_less_`R'[1]-rate_less_white[1]         
    local diff_2=rate_less_`R'[2]-rate_less_white[2]        
    local did=`diff_2'-`diff_1'
    local SE_1= sqrt(stderr_less_`R'[1]^2+stderr_less_white[1]^2) 
    local SE_2= sqrt(stderr_less_`R'[2]^2+stderr_less_white[2]^2) 
    local SE_did=sqrt(`SE_2'^2+`SE_1'^2)
    local lb=`did'-`zcrit'*`SE_did'
    local ub=`did'+`zcrit'*`SE_did'
    local Pval=2*(1-normal(abs(`did'/`SE_did')))
    local Pval=cond(`Pval'<0.001,"<0.001",string(`Pval',"%5.3f"))
    noi di "`R'" _col(20) %5.2f `did'*100 _col(30) "(" %5.2f `lb'*100 "," %5.2f `ub'*100 ")" _col(50) "`Pval'"
	
	noi display " "
	noi display " "
	noi disp "**********************************************"
	noi disp "Change in recommended sleep disparity, 2004-2018"
	noi disp "**********************************************"
    local diff_1=rate_good_`R'[1]-rate_good_white[1]         
    local diff_2=rate_good_`R'[2]-rate_good_white[2]        
    local did=`diff_2'-`diff_1'
    local SE_1= sqrt(stderr_good_`R'[1]^2+stderr_good_white[1]^2) 
    local SE_2= sqrt(stderr_good_`R'[2]^2+stderr_good_white[2]^2) 
    local SE_did=sqrt(`SE_2'^2+`SE_1'^2)
    local lb=`did'-`zcrit'*`SE_did'
    local ub=`did'+`zcrit'*`SE_did'
    local Pval=2*(1-normal(abs(`did'/`SE_did')))
    local Pval=cond(`Pval'<0.001,"<0.001",string(`Pval',"%5.3f"))
    noi di "`R'" _col(20) %5.2f `did'*100 _col(30) "(" %5.2f `lb'*100 "," %5.2f `ub'*100 ")" _col(50) "`Pval'"
	
	noi display " "
	noi display " "
	noi disp "**********************************************"
	noi disp "Change in long sleep disparity, 2004-2018"
	noi disp "**********************************************"
    local diff_1=rate_long_`R'[1]-rate_long_white[1]         
    local diff_2=rate_long_`R'[2]-rate_long_white[2]        
    local did=`diff_2'-`diff_1'
    local SE_1= sqrt(stderr_long_`R'[1]^2+stderr_long_white[1]^2) 
    local SE_2= sqrt(stderr_long_`R'[2]^2+stderr_long_white[2]^2) 
    local SE_did=sqrt(`SE_2'^2+`SE_1'^2)
    local lb=`did'-`zcrit'*`SE_did'
    local ub=`did'+`zcrit'*`SE_did'
    local Pval=2*(1-normal(abs(`did'/`SE_did')))
    local Pval=cond(`Pval'<0.001,"<0.001",string(`Pval',"%5.3f"))
    noi di "`R'" _col(20) %5.2f `did'*100 _col(30) "(" %5.2f `lb'*100 "," %5.2f `ub'*100 ")" _col(50) "`Pval'"
	
}
}


qui if year==2004  {
	noi display " "
	noi display " "
	noi disp "**********************************************"
	noi disp "**********************************************"
	noi disp "Quantifying disparities in 2004 "
	noi disp "**********************************************"
	noi disp "**********************************************"
foreach G in asian black hisp  {

	noi display " "
	noi display " "
	noi disp "**********************************************"
	noi disp "Disparity in short sleep, 2004"
	noi disp "**********************************************"
    local Pval=2*(1-normal(abs(diff_less_`G'/diff_less_`G'_SE)))
    local Pval=cond(`Pval'<0.001,"<0.001",string(`Pval',"%5.3f"))
  noi disp "`G'-white '04" _col(20) %5.2f diff_less_`G'*100 _col(30) "(" %5.2f diff_less_`G'_lb*100 "," %5.2f diff_less_`G'_ub*100 ")" _col(50) "`Pval'"

 	noi display " "
	noi display " "
	noi disp "**********************************************"
	noi disp "Disparity in recommended sleep, 2004"
	noi disp "**********************************************"
    local Pval=2*(1-normal(abs(diff_good_`G'/diff_good_`G'_SE)))
    local Pval=cond(`Pval'<0.001,"<0.001",string(`Pval',"%5.3f"))
  noi disp "`G'-white '04" _col(20) %5.2f diff_good_`G'*100 _col(30) "(" %5.2f diff_good_`G'_lb*100 "," %5.2f diff_good_`G'_ub*100 ")" _col(50) "`Pval'"
  
 	noi display " "
	noi display " "
	noi disp "**********************************************"
	noi disp "Disparity in long sleep, 2004"
	noi disp "**********************************************"
    local Pval=2*(1-normal(abs(diff_long_`G'/diff_long_`G'_SE)))
    local Pval=cond(`Pval'<0.001,"<0.001",string(`Pval',"%5.3f"))
  noi disp "`G'-white '04" _col(20) %5.2f diff_long_`G'*100 _col(30) "(" %5.2f diff_long_`G'_lb*100 "," %5.2f diff_long_`G'_ub*100 ")" _col(50) "`Pval'"
}
}


qui { 
keep if year==2018
	noi display " "
	noi display " "
	noi disp "**********************************************"
	noi disp "**********************************************"
	noi disp "Quantifying disparities in 2018 "
	noi disp "**********************************************"
	noi disp "**********************************************"
foreach G in asian black hisp  {

	noi display " "
	noi display " "
	noi disp "**********************************************"
	noi disp "Disparity in short sleep, 2018"
	noi disp "**********************************************"
    local Pval=2*(1-normal(abs(diff_less_`G'/diff_less_`G'_SE)))
    local Pval=cond(`Pval'<0.001,"<0.001",string(`Pval',"%5.3f"))
  noi disp "`G'-white '18" _col(20) %5.2f diff_less_`G'*100 _col(30) "(" %5.2f diff_less_`G'_lb*100 "," %5.2f diff_less_`G'_ub*100 ")" _col(50) "`Pval'"

 	noi display " "
	noi display " "
	noi disp "**********************************************"
	noi disp "Disparity in recommended sleep, 2018"
	noi disp "**********************************************"
    local Pval=2*(1-normal(abs(diff_good_`G'/diff_good_`G'_SE)))
    local Pval=cond(`Pval'<0.001,"<0.001",string(`Pval',"%5.3f"))
  noi disp "`G'-white '18" _col(20) %5.2f diff_good_`G'*100 _col(30) "(" %5.2f diff_good_`G'_lb*100 "," %5.2f diff_good_`G'_ub*100 ")" _col(50) "`Pval'"
  
 	noi display " "
	noi display " "
	noi disp "**********************************************"
	noi disp "Disparity in long sleep, 2018"
	noi disp "**********************************************"
    local Pval=2*(1-normal(abs(diff_long_`G'/diff_long_`G'_SE)))
    local Pval=cond(`Pval'<0.001,"<0.001",string(`Pval',"%5.3f"))
  noi disp "`G'-white '18" _col(20) %5.2f diff_long_`G'*100 _col(30) "(" %5.2f diff_long_`G'_lb*100 "," %5.2f diff_long_`G'_ub*100 ")" _col(50) "`Pval'"
}

}
}

**#			2. By sex/gender

**#				2.1 Females only


use ratefile_sleep_female, clear
	local zcrit=invnorm(.975)


foreach K in less good long {
	foreach D in black asian hisp {
     gen diff_`K'_`D'=(rate_`K'_`D' - rate_`K'_white)     
     gen diff_`K'_`D'_SE = sqrt(stderr_`K'_`D'^2 + stderr_`K'_white^2)
     gen diff_`K'_`D'_lb=diff_`K'_`D'-diff_`K'_`D'_SE*`zcrit'
     gen diff_`K'_`D'_ub=diff_`K'_`D'+diff_`K'_`D'_SE*`zcrit'
     gen wt_diff_`K'_`D'= 1/diff_`K'_`D'_SE^2 
		}
	}


qui {
foreach K in less good long {	
foreach R in white black asian hisp allfour {
    gen wt_`K'_`R'=1/(stderr_`K'_`R')^2         

}
}


noi {
	display " "
	display " "
	disp "**********************************************"
	display "Change in prevalence, females only"
	disp "**********************************************"
	display " "
	foreach R in white black asian hisp allfour {
    reg rate_less_`R' year [aw=wt_less_`R'] 
    reg rate_good_`R' year [aw=wt_good_`R'] 
    reg rate_long_`R' year [aw=wt_long_`R'] 
}
}

noi {
	display " "
	display " "
	disp "**********************************************"
	display "Change in disparities, females only"
	disp "**********************************************"
	display " "
	foreach P in black asian hisp {
    reg diff_less_`P' year [aw=(wt_diff_less_`P')]  
    reg diff_good_`P' year [aw=(wt_diff_good_`P')] 
    reg diff_long_`P' year [aw=(wt_diff_long_`P')]  

}
}
 
keep if inlist(year,2004,2018)
sort year

local zcrit=invnorm(.975)
qui {
	noi display " "
	noi display " "
	noi disp "**********************************************"
	noi disp "**********************************************"
	noi disp "Change in prevalence, females only"
	noi disp "**********************************************"
	noi disp "**********************************************"
	noi display " "
	noi display " "
foreach R in white black asian hispanic allfour {

	noi display " "
	noi display " "
	noi disp "**********************************************"
	noi disp "Change in short sleep prevalence, 2004-2018, females only"
	noi disp "**********************************************"
    local diff=rate_less_`R'[2]-rate_less_`R'[1]         
    local SE = sqrt(stderr_less_`R'[2]^2+stderr_less_`R'[1]^2)
    local lb=`diff'-`zcrit'*`SE'
    local ub=`diff'+`zcrit'*`SE'
    local Pval=(2*(1-normal(abs(`diff'/`SE'))))
    local Pval=cond(`Pval'<0.001,"<0.001",string(`Pval',"%5.3f"))
    noi di "`R'" _col(20) %5.2f `diff'*100 _col(30) "(" %5.2f `lb'*100 "," %5.2f `ub'*100 ")" _col(50) "`Pval'"
	

	noi display " "
	noi display " "
	noi disp "**********************************************"
	noi disp "Change in recommended sleep prevalence, 2004-2018, females only"
	noi disp "**********************************************"
    local diff=rate_good_`R'[2]-rate_good_`R'[1]         
    local SE = sqrt(stderr_good_`R'[2]^2+stderr_good_`R'[1]^2)
    local lb=`diff'-`zcrit'*`SE'
    local ub=`diff'+`zcrit'*`SE'
    local Pval=(2*(1-normal(abs(`diff'/`SE'))))
    local Pval=cond(`Pval'<0.001,"<0.001",string(`Pval',"%5.3f"))
    noi di "`R'" _col(20) %5.2f `diff'*100 _col(30) "(" %5.2f `lb'*100 "," %5.2f `ub'*100 ")" _col(50) "`Pval'"

	noi display " "
	noi display " "
	noi disp "**********************************************"
	noi disp "Change in long sleep prevalence, 2004-2018, females only"
	noi disp "**********************************************"
    local diff=rate_long_`R'[2]-rate_long_`R'[1]         
    local SE = sqrt(stderr_long_`R'[2]^2+stderr_long_`R'[1]^2)
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
	noi disp "**********************************************"
	noi disp "Change in disparities, females only"
	noi disp "**********************************************"
	noi disp "**********************************************"
	noi display " "
	noi display " "
	
foreach R in black asian hisp {
	
	noi display " "
	noi display " "
	noi disp "**********************************************"
	noi disp "Change in short sleep disparity, 2004-2018, females only"
	noi disp "**********************************************"
    local diff_1=rate_less_`R'[1]-rate_less_white[1]         
    local diff_2=rate_less_`R'[2]-rate_less_white[2]        
    local did=`diff_2'-`diff_1'
    local SE_1= sqrt(stderr_less_`R'[1]^2+stderr_less_white[1]^2) 
    local SE_2= sqrt(stderr_less_`R'[2]^2+stderr_less_white[2]^2) 
    local SE_did=sqrt(`SE_2'^2+`SE_1'^2)
    local lb=`did'-`zcrit'*`SE_did'
    local ub=`did'+`zcrit'*`SE_did'
    local Pval=2*(1-normal(abs(`did'/`SE_did')))
    local Pval=cond(`Pval'<0.001,"<0.001",string(`Pval',"%5.3f"))
    noi di "`R'" _col(20) %5.2f `did'*100 _col(30) "(" %5.2f `lb'*100 "," %5.2f `ub'*100 ")" _col(50) "`Pval'"
	
	noi display " "
	noi display " "
	noi disp "**********************************************"
	noi disp "Change in recommended sleep disparity, 2004-2018, females only"
	noi disp "**********************************************"
    local diff_1=rate_good_`R'[1]-rate_good_white[1]         
    local diff_2=rate_good_`R'[2]-rate_good_white[2]        
    local did=`diff_2'-`diff_1'
    local SE_1= sqrt(stderr_good_`R'[1]^2+stderr_good_white[1]^2) 
    local SE_2= sqrt(stderr_good_`R'[2]^2+stderr_good_white[2]^2) 
    local SE_did=sqrt(`SE_2'^2+`SE_1'^2)
    local lb=`did'-`zcrit'*`SE_did'
    local ub=`did'+`zcrit'*`SE_did'
    local Pval=2*(1-normal(abs(`did'/`SE_did')))
    local Pval=cond(`Pval'<0.001,"<0.001",string(`Pval',"%5.3f"))
    noi di "`R'" _col(20) %5.2f `did'*100 _col(30) "(" %5.2f `lb'*100 "," %5.2f `ub'*100 ")" _col(50) "`Pval'"
	
	noi display " "
	noi display " "
	noi disp "**********************************************"
	noi disp "Change in long sleep disparity, 2004-2018, females only"
	noi disp "**********************************************"
    local diff_1=rate_long_`R'[1]-rate_long_white[1]         
    local diff_2=rate_long_`R'[2]-rate_long_white[2]        
    local did=`diff_2'-`diff_1'
    local SE_1= sqrt(stderr_long_`R'[1]^2+stderr_long_white[1]^2) 
    local SE_2= sqrt(stderr_long_`R'[2]^2+stderr_long_white[2]^2) 
    local SE_did=sqrt(`SE_2'^2+`SE_1'^2)
    local lb=`did'-`zcrit'*`SE_did'
    local ub=`did'+`zcrit'*`SE_did'
    local Pval=2*(1-normal(abs(`did'/`SE_did')))
    local Pval=cond(`Pval'<0.001,"<0.001",string(`Pval',"%5.3f"))
    noi di "`R'" _col(20) %5.2f `did'*100 _col(30) "(" %5.2f `lb'*100 "," %5.2f `ub'*100 ")" _col(50) "`Pval'"
	
}
}


qui if year==2004  {
	noi display " "
	noi display " "
	noi disp "**********************************************"
	noi disp "**********************************************"
	noi disp "Quantifying disparities in 2004, females only "
	noi disp "**********************************************"
	noi disp "**********************************************"
foreach G in asian black hisp  {

	noi display " "
	noi display " "
	noi disp "**********************************************"
	noi disp "Disparity in short sleep, 2004, females only"
	noi disp "**********************************************"
    local Pval=2*(1-normal(abs(diff_less_`G'/diff_less_`G'_SE)))
    local Pval=cond(`Pval'<0.001,"<0.001",string(`Pval',"%5.3f"))
  noi disp "`G'-white '04" _col(20) %5.2f diff_less_`G'*100 _col(30) "(" %5.2f diff_less_`G'_lb*100 "," %5.2f diff_less_`G'_ub*100 ")" _col(50) "`Pval'"

 	noi display " "
	noi display " "
	noi disp "**********************************************"
	noi disp "Disparity in recommended sleep, 2004, females only"
	noi disp "**********************************************"
    local Pval=2*(1-normal(abs(diff_good_`G'/diff_good_`G'_SE)))
    local Pval=cond(`Pval'<0.001,"<0.001",string(`Pval',"%5.3f"))
  noi disp "`G'-white '04" _col(20) %5.2f diff_good_`G'*100 _col(30) "(" %5.2f diff_good_`G'_lb*100 "," %5.2f diff_good_`G'_ub*100 ")" _col(50) "`Pval'"
  
 	noi display " "
	noi display " "
	noi disp "**********************************************"
	noi disp "Disparity in long sleep, 2004, females only"
	noi disp "**********************************************"
    local Pval=2*(1-normal(abs(diff_long_`G'/diff_long_`G'_SE)))
    local Pval=cond(`Pval'<0.001,"<0.001",string(`Pval',"%5.3f"))
  noi disp "`G'-white '04" _col(20) %5.2f diff_long_`G'*100 _col(30) "(" %5.2f diff_long_`G'_lb*100 "," %5.2f diff_long_`G'_ub*100 ")" _col(50) "`Pval'"
}
}


qui { 
keep if year==2018
	noi display " "
	noi display " "
	noi disp "**********************************************"
	noi disp "**********************************************"
	noi disp "Quantifying disparities in 2018, females only"
	noi disp "**********************************************"
	noi disp "**********************************************"
foreach G in asian black hisp  {

	noi display " "
	noi display " "
	noi disp "**********************************************"
	noi disp "Disparity in short sleep, 2018, females only"
	noi disp "**********************************************"
    local Pval=2*(1-normal(abs(diff_less_`G'/diff_less_`G'_SE)))
    local Pval=cond(`Pval'<0.001,"<0.001",string(`Pval',"%5.3f"))
  noi disp "`G'-white '18" _col(20) %5.2f diff_less_`G'*100 _col(30) "(" %5.2f diff_less_`G'_lb*100 "," %5.2f diff_less_`G'_ub*100 ")" _col(50) "`Pval'"

 	noi display " "
	noi display " "
	noi disp "**********************************************"
	noi disp "Disparity in recommended sleep, 2018, females only"
	noi disp "**********************************************"
    local Pval=2*(1-normal(abs(diff_good_`G'/diff_good_`G'_SE)))
    local Pval=cond(`Pval'<0.001,"<0.001",string(`Pval',"%5.3f"))
  noi disp "`G'-white '18" _col(20) %5.2f diff_good_`G'*100 _col(30) "(" %5.2f diff_good_`G'_lb*100 "," %5.2f diff_good_`G'_ub*100 ")" _col(50) "`Pval'"
  
 	noi display " "
	noi display " "
	noi disp "**********************************************"
	noi disp "Disparity in long sleep, 2018, females only"
	noi disp "**********************************************"
    local Pval=2*(1-normal(abs(diff_long_`G'/diff_long_`G'_SE)))
    local Pval=cond(`Pval'<0.001,"<0.001",string(`Pval',"%5.3f"))
  noi disp "`G'-white '18" _col(20) %5.2f diff_long_`G'*100 _col(30) "(" %5.2f diff_long_`G'_lb*100 "," %5.2f diff_long_`G'_ub*100 ")" _col(50) "`Pval'"
}

}
}

**#				2.2 Males only


use ratefile_sleep_male, clear
	local zcrit=invnorm(.975)


foreach K in less good long {
	foreach D in black asian hisp {
     gen diff_`K'_`D'=(rate_`K'_`D' - rate_`K'_white)     
     gen diff_`K'_`D'_SE = sqrt(stderr_`K'_`D'^2 + stderr_`K'_white^2)
     gen diff_`K'_`D'_lb=diff_`K'_`D'-diff_`K'_`D'_SE*`zcrit'
     gen diff_`K'_`D'_ub=diff_`K'_`D'+diff_`K'_`D'_SE*`zcrit'
     gen wt_diff_`K'_`D'= 1/diff_`K'_`D'_SE^2 
		}
	}


qui {
foreach K in less good long {	
foreach R in white black asian hisp allfour {
    gen wt_`K'_`R'=1/(stderr_`K'_`R')^2         

}
}


noi {
	display " "
	display " "
	disp "**********************************************"
	display "Change in prevalence, males only"
	disp "**********************************************"
	display " "
	foreach R in white black asian hisp allfour {
    reg rate_less_`R' year [aw=wt_less_`R'] 
    reg rate_good_`R' year [aw=wt_good_`R'] 
    reg rate_long_`R' year [aw=wt_long_`R'] 
}
}

noi {
	display " "
	display " "
	disp "**********************************************"
	display "Change in disparities, males only"
	disp "**********************************************"
	display " "
	foreach P in black asian hisp {
    reg diff_less_`P' year [aw=(wt_diff_less_`P')]  
    reg diff_good_`P' year [aw=(wt_diff_good_`P')] 
    reg diff_long_`P' year [aw=(wt_diff_long_`P')]  

}
}
 
keep if inlist(year,2004,2018)
sort year

local zcrit=invnorm(.975)
qui {
	noi display " "
	noi display " "
	noi disp "**********************************************"
	noi disp "**********************************************"
	noi disp "Change in prevalence, males only"
	noi disp "**********************************************"
	noi disp "**********************************************"
	noi display " "
	noi display " "
foreach R in white black asian hispanic allfour {

	noi display " "
	noi display " "
	noi disp "**********************************************"
	noi disp "Change in short sleep prevalence, 2004-2018, males only"
	noi disp "**********************************************"
    local diff=rate_less_`R'[2]-rate_less_`R'[1]         
    local SE = sqrt(stderr_less_`R'[2]^2+stderr_less_`R'[1]^2)
    local lb=`diff'-`zcrit'*`SE'
    local ub=`diff'+`zcrit'*`SE'
    local Pval=(2*(1-normal(abs(`diff'/`SE'))))
    local Pval=cond(`Pval'<0.001,"<0.001",string(`Pval',"%5.3f"))
    noi di "`R'" _col(20) %5.2f `diff'*100 _col(30) "(" %5.2f `lb'*100 "," %5.2f `ub'*100 ")" _col(50) "`Pval'"
	

	noi display " "
	noi display " "
	noi disp "**********************************************"
	noi disp "Change in recommended sleep prevalence, 2004-2018, males only"
	noi disp "**********************************************"
    local diff=rate_good_`R'[2]-rate_good_`R'[1]         
    local SE = sqrt(stderr_good_`R'[2]^2+stderr_good_`R'[1]^2)
    local lb=`diff'-`zcrit'*`SE'
    local ub=`diff'+`zcrit'*`SE'
    local Pval=(2*(1-normal(abs(`diff'/`SE'))))
    local Pval=cond(`Pval'<0.001,"<0.001",string(`Pval',"%5.3f"))
    noi di "`R'" _col(20) %5.2f `diff'*100 _col(30) "(" %5.2f `lb'*100 "," %5.2f `ub'*100 ")" _col(50) "`Pval'"

	noi display " "
	noi display " "
	noi disp "**********************************************"
	noi disp "Change in long sleep prevalence, 2004-2018, males only"
	noi disp "**********************************************"
    local diff=rate_long_`R'[2]-rate_long_`R'[1]         
    local SE = sqrt(stderr_long_`R'[2]^2+stderr_long_`R'[1]^2)
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
	noi disp "**********************************************"
	noi disp "Change in disparities, males only"
	noi disp "**********************************************"
	noi disp "**********************************************"
	noi display " "
	noi display " "
	
foreach R in black asian hisp {
	
	noi display " "
	noi display " "
	noi disp "**********************************************"
	noi disp "Change in short sleep disparity, 2004-2018, males only"
	noi disp "**********************************************"
    local diff_1=rate_less_`R'[1]-rate_less_white[1]         
    local diff_2=rate_less_`R'[2]-rate_less_white[2]        
    local did=`diff_2'-`diff_1'
    local SE_1= sqrt(stderr_less_`R'[1]^2+stderr_less_white[1]^2) 
    local SE_2= sqrt(stderr_less_`R'[2]^2+stderr_less_white[2]^2) 
    local SE_did=sqrt(`SE_2'^2+`SE_1'^2)
    local lb=`did'-`zcrit'*`SE_did'
    local ub=`did'+`zcrit'*`SE_did'
    local Pval=2*(1-normal(abs(`did'/`SE_did')))
    local Pval=cond(`Pval'<0.001,"<0.001",string(`Pval',"%5.3f"))
    noi di "`R'" _col(20) %5.2f `did'*100 _col(30) "(" %5.2f `lb'*100 "," %5.2f `ub'*100 ")" _col(50) "`Pval'"
	
	noi display " "
	noi display " "
	noi disp "**********************************************"
	noi disp "Change in recommended sleep disparity, 2004-2018, males only"
	noi disp "**********************************************"
    local diff_1=rate_good_`R'[1]-rate_good_white[1]         
    local diff_2=rate_good_`R'[2]-rate_good_white[2]        
    local did=`diff_2'-`diff_1'
    local SE_1= sqrt(stderr_good_`R'[1]^2+stderr_good_white[1]^2) 
    local SE_2= sqrt(stderr_good_`R'[2]^2+stderr_good_white[2]^2) 
    local SE_did=sqrt(`SE_2'^2+`SE_1'^2)
    local lb=`did'-`zcrit'*`SE_did'
    local ub=`did'+`zcrit'*`SE_did'
    local Pval=2*(1-normal(abs(`did'/`SE_did')))
    local Pval=cond(`Pval'<0.001,"<0.001",string(`Pval',"%5.3f"))
    noi di "`R'" _col(20) %5.2f `did'*100 _col(30) "(" %5.2f `lb'*100 "," %5.2f `ub'*100 ")" _col(50) "`Pval'"
	
	noi display " "
	noi display " "
	noi disp "**********************************************"
	noi disp "Change in long sleep disparity, 2004-2018, males only"
	noi disp "**********************************************"
    local diff_1=rate_long_`R'[1]-rate_long_white[1]         
    local diff_2=rate_long_`R'[2]-rate_long_white[2]        
    local did=`diff_2'-`diff_1'
    local SE_1= sqrt(stderr_long_`R'[1]^2+stderr_long_white[1]^2) 
    local SE_2= sqrt(stderr_long_`R'[2]^2+stderr_long_white[2]^2) 
    local SE_did=sqrt(`SE_2'^2+`SE_1'^2)
    local lb=`did'-`zcrit'*`SE_did'
    local ub=`did'+`zcrit'*`SE_did'
    local Pval=2*(1-normal(abs(`did'/`SE_did')))
    local Pval=cond(`Pval'<0.001,"<0.001",string(`Pval',"%5.3f"))
    noi di "`R'" _col(20) %5.2f `did'*100 _col(30) "(" %5.2f `lb'*100 "," %5.2f `ub'*100 ")" _col(50) "`Pval'"
	
}
}


qui if year==2004  {
	noi display " "
	noi display " "
	noi disp "**********************************************"
	noi disp "**********************************************"
	noi disp "Quantifying disparities in 2004, males only "
	noi disp "**********************************************"
	noi disp "**********************************************"
foreach G in asian black hisp  {

	noi display " "
	noi display " "
	noi disp "**********************************************"
	noi disp "Disparity in short sleep, 2004, males only"
	noi disp "**********************************************"
    local Pval=2*(1-normal(abs(diff_less_`G'/diff_less_`G'_SE)))
    local Pval=cond(`Pval'<0.001,"<0.001",string(`Pval',"%5.3f"))
  noi disp "`G'-white '04" _col(20) %5.2f diff_less_`G'*100 _col(30) "(" %5.2f diff_less_`G'_lb*100 "," %5.2f diff_less_`G'_ub*100 ")" _col(50) "`Pval'"

 	noi display " "
	noi display " "
	noi disp "**********************************************"
	noi disp "Disparity in recommended sleep, 2004, males only"
	noi disp "**********************************************"
    local Pval=2*(1-normal(abs(diff_good_`G'/diff_good_`G'_SE)))
    local Pval=cond(`Pval'<0.001,"<0.001",string(`Pval',"%5.3f"))
  noi disp "`G'-white '04" _col(20) %5.2f diff_good_`G'*100 _col(30) "(" %5.2f diff_good_`G'_lb*100 "," %5.2f diff_good_`G'_ub*100 ")" _col(50) "`Pval'"
  
 	noi display " "
	noi display " "
	noi disp "**********************************************"
	noi disp "Disparity in long sleep, 2004, males only"
	noi disp "**********************************************"
    local Pval=2*(1-normal(abs(diff_long_`G'/diff_long_`G'_SE)))
    local Pval=cond(`Pval'<0.001,"<0.001",string(`Pval',"%5.3f"))
  noi disp "`G'-white '04" _col(20) %5.2f diff_long_`G'*100 _col(30) "(" %5.2f diff_long_`G'_lb*100 "," %5.2f diff_long_`G'_ub*100 ")" _col(50) "`Pval'"
}
}


qui { 
keep if year==2018
	noi display " "
	noi display " "
	noi disp "**********************************************"
	noi disp "**********************************************"
	noi disp "Quantifying disparities in 2018, males only"
	noi disp "**********************************************"
	noi disp "**********************************************"
foreach G in asian black hisp  {

	noi display " "
	noi display " "
	noi disp "**********************************************"
	noi disp "Disparity in short sleep, 2018, males only"
	noi disp "**********************************************"
    local Pval=2*(1-normal(abs(diff_less_`G'/diff_less_`G'_SE)))
    local Pval=cond(`Pval'<0.001,"<0.001",string(`Pval',"%5.3f"))
  noi disp "`G'-white '18" _col(20) %5.2f diff_less_`G'*100 _col(30) "(" %5.2f diff_less_`G'_lb*100 "," %5.2f diff_less_`G'_ub*100 ")" _col(50) "`Pval'"

 	noi display " "
	noi display " "
	noi disp "**********************************************"
	noi disp "Disparity in recommended sleep, 2018, males only"
	noi disp "**********************************************"
    local Pval=2*(1-normal(abs(diff_good_`G'/diff_good_`G'_SE)))
    local Pval=cond(`Pval'<0.001,"<0.001",string(`Pval',"%5.3f"))
  noi disp "`G'-white '18" _col(20) %5.2f diff_good_`G'*100 _col(30) "(" %5.2f diff_good_`G'_lb*100 "," %5.2f diff_good_`G'_ub*100 ")" _col(50) "`Pval'"
  
 	noi display " "
	noi display " "
	noi disp "**********************************************"
	noi disp "Disparity in long sleep, 2018, males only"
	noi disp "**********************************************"
    local Pval=2*(1-normal(abs(diff_long_`G'/diff_long_`G'_SE)))
    local Pval=cond(`Pval'<0.001,"<0.001",string(`Pval',"%5.3f"))
  noi disp "`G'-white '18" _col(20) %5.2f diff_long_`G'*100 _col(30) "(" %5.2f diff_long_`G'_lb*100 "," %5.2f diff_long_`G'_ub*100 ")" _col(50) "`Pval'"
}

}
}

**#			3. By household income level

**#				3.1 Low-income only


use ratefile_lowinc, clear
	local zcrit=invnorm(.975)


foreach K in less good long {
	foreach D in black asian hisp {
     gen diff_`K'_`D'=(rate_`K'_`D' - rate_`K'_white)     
     gen diff_`K'_`D'_SE = sqrt(stderr_`K'_`D'^2 + stderr_`K'_white^2)
     gen diff_`K'_`D'_lb=diff_`K'_`D'-diff_`K'_`D'_SE*`zcrit'
     gen diff_`K'_`D'_ub=diff_`K'_`D'+diff_`K'_`D'_SE*`zcrit'
     gen wt_diff_`K'_`D'= 1/diff_`K'_`D'_SE^2 
		}
	}


qui {
foreach K in less good long {	
foreach R in white black asian hisp allfour {
    gen wt_`K'_`R'=1/(stderr_`K'_`R')^2         

}
}


noi {
	display " "
	display " "
	disp "**********************************************"
	display "Change in prevalence, low-income only"
	disp "**********************************************"
	display " "
	foreach R in white black asian hisp allfour {
    reg rate_less_`R' year [aw=wt_less_`R'] 
    reg rate_good_`R' year [aw=wt_good_`R'] 
    reg rate_long_`R' year [aw=wt_long_`R'] 
}
}

noi {
	display " "
	display " "
	disp "**********************************************"
	display "Change in disparities, low-income only"
	disp "**********************************************"
	display " "
	foreach P in black asian hisp {
    reg diff_less_`P' year [aw=(wt_diff_less_`P')]  
    reg diff_good_`P' year [aw=(wt_diff_good_`P')] 
    reg diff_long_`P' year [aw=(wt_diff_long_`P')]  

}
}
 
keep if inlist(year,2004,2018)
sort year

local zcrit=invnorm(.975)
qui {
	noi display " "
	noi display " "
	noi disp "**********************************************"
	noi disp "**********************************************"
	noi disp "Change in prevalence, low-income only"
	noi disp "**********************************************"
	noi disp "**********************************************"
	noi display " "
	noi display " "
foreach R in white black asian hispanic allfour {

	noi display " "
	noi display " "
	noi disp "**********************************************"
	noi disp "Change in short sleep prevalence, 2004-2018, low-income only"
	noi disp "**********************************************"
    local diff=rate_less_`R'[2]-rate_less_`R'[1]         
    local SE = sqrt(stderr_less_`R'[2]^2+stderr_less_`R'[1]^2)
    local lb=`diff'-`zcrit'*`SE'
    local ub=`diff'+`zcrit'*`SE'
    local Pval=(2*(1-normal(abs(`diff'/`SE'))))
    local Pval=cond(`Pval'<0.001,"<0.001",string(`Pval',"%5.3f"))
    noi di "`R'" _col(20) %5.2f `diff'*100 _col(30) "(" %5.2f `lb'*100 "," %5.2f `ub'*100 ")" _col(50) "`Pval'"
	

	noi display " "
	noi display " "
	noi disp "**********************************************"
	noi disp "Change in recommended sleep prevalence, 2004-2018, low-income only"
	noi disp "**********************************************"
    local diff=rate_good_`R'[2]-rate_good_`R'[1]         
    local SE = sqrt(stderr_good_`R'[2]^2+stderr_good_`R'[1]^2)
    local lb=`diff'-`zcrit'*`SE'
    local ub=`diff'+`zcrit'*`SE'
    local Pval=(2*(1-normal(abs(`diff'/`SE'))))
    local Pval=cond(`Pval'<0.001,"<0.001",string(`Pval',"%5.3f"))
    noi di "`R'" _col(20) %5.2f `diff'*100 _col(30) "(" %5.2f `lb'*100 "," %5.2f `ub'*100 ")" _col(50) "`Pval'"

	noi display " "
	noi display " "
	noi disp "**********************************************"
	noi disp "Change in long sleep prevalence, 2004-2018, low-income only"
	noi disp "**********************************************"
    local diff=rate_long_`R'[2]-rate_long_`R'[1]         
    local SE = sqrt(stderr_long_`R'[2]^2+stderr_long_`R'[1]^2)
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
	noi disp "**********************************************"
	noi disp "Change in disparities, low-income only"
	noi disp "**********************************************"
	noi disp "**********************************************"
	noi display " "
	noi display " "
	
foreach R in black asian hisp {
	
	noi display " "
	noi display " "
	noi disp "**********************************************"
	noi disp "Change in short sleep disparity, 2004-2018, low-income only"
	noi disp "**********************************************"
    local diff_1=rate_less_`R'[1]-rate_less_white[1]         
    local diff_2=rate_less_`R'[2]-rate_less_white[2]        
    local did=`diff_2'-`diff_1'
    local SE_1= sqrt(stderr_less_`R'[1]^2+stderr_less_white[1]^2) 
    local SE_2= sqrt(stderr_less_`R'[2]^2+stderr_less_white[2]^2) 
    local SE_did=sqrt(`SE_2'^2+`SE_1'^2)
    local lb=`did'-`zcrit'*`SE_did'
    local ub=`did'+`zcrit'*`SE_did'
    local Pval=2*(1-normal(abs(`did'/`SE_did')))
    local Pval=cond(`Pval'<0.001,"<0.001",string(`Pval',"%5.3f"))
    noi di "`R'" _col(20) %5.2f `did'*100 _col(30) "(" %5.2f `lb'*100 "," %5.2f `ub'*100 ")" _col(50) "`Pval'"
	
	noi display " "
	noi display " "
	noi disp "**********************************************"
	noi disp "Change in recommended sleep disparity, 2004-2018, low-income only"
	noi disp "**********************************************"
    local diff_1=rate_good_`R'[1]-rate_good_white[1]         
    local diff_2=rate_good_`R'[2]-rate_good_white[2]        
    local did=`diff_2'-`diff_1'
    local SE_1= sqrt(stderr_good_`R'[1]^2+stderr_good_white[1]^2) 
    local SE_2= sqrt(stderr_good_`R'[2]^2+stderr_good_white[2]^2) 
    local SE_did=sqrt(`SE_2'^2+`SE_1'^2)
    local lb=`did'-`zcrit'*`SE_did'
    local ub=`did'+`zcrit'*`SE_did'
    local Pval=2*(1-normal(abs(`did'/`SE_did')))
    local Pval=cond(`Pval'<0.001,"<0.001",string(`Pval',"%5.3f"))
    noi di "`R'" _col(20) %5.2f `did'*100 _col(30) "(" %5.2f `lb'*100 "," %5.2f `ub'*100 ")" _col(50) "`Pval'"
	
	noi display " "
	noi display " "
	noi disp "**********************************************"
	noi disp "Change in long sleep disparity, 2004-2018, low-income only"
	noi disp "**********************************************"
    local diff_1=rate_long_`R'[1]-rate_long_white[1]         
    local diff_2=rate_long_`R'[2]-rate_long_white[2]        
    local did=`diff_2'-`diff_1'
    local SE_1= sqrt(stderr_long_`R'[1]^2+stderr_long_white[1]^2) 
    local SE_2= sqrt(stderr_long_`R'[2]^2+stderr_long_white[2]^2) 
    local SE_did=sqrt(`SE_2'^2+`SE_1'^2)
    local lb=`did'-`zcrit'*`SE_did'
    local ub=`did'+`zcrit'*`SE_did'
    local Pval=2*(1-normal(abs(`did'/`SE_did')))
    local Pval=cond(`Pval'<0.001,"<0.001",string(`Pval',"%5.3f"))
    noi di "`R'" _col(20) %5.2f `did'*100 _col(30) "(" %5.2f `lb'*100 "," %5.2f `ub'*100 ")" _col(50) "`Pval'"
	
}
}


qui if year==2004  {
	noi display " "
	noi display " "
	noi disp "**********************************************"
	noi disp "**********************************************"
	noi disp "Quantifying disparities in 2004, low-income only "
	noi disp "**********************************************"
	noi disp "**********************************************"
foreach G in asian black hisp  {

	noi display " "
	noi display " "
	noi disp "**********************************************"
	noi disp "Disparity in short sleep, 2004, low-income only"
	noi disp "**********************************************"
    local Pval=2*(1-normal(abs(diff_less_`G'/diff_less_`G'_SE)))
    local Pval=cond(`Pval'<0.001,"<0.001",string(`Pval',"%5.3f"))
  noi disp "`G'-white '04" _col(20) %5.2f diff_less_`G'*100 _col(30) "(" %5.2f diff_less_`G'_lb*100 "," %5.2f diff_less_`G'_ub*100 ")" _col(50) "`Pval'"

 	noi display " "
	noi display " "
	noi disp "**********************************************"
	noi disp "Disparity in recommended sleep, 2004, low-income only"
	noi disp "**********************************************"
    local Pval=2*(1-normal(abs(diff_good_`G'/diff_good_`G'_SE)))
    local Pval=cond(`Pval'<0.001,"<0.001",string(`Pval',"%5.3f"))
  noi disp "`G'-white '04" _col(20) %5.2f diff_good_`G'*100 _col(30) "(" %5.2f diff_good_`G'_lb*100 "," %5.2f diff_good_`G'_ub*100 ")" _col(50) "`Pval'"
  
 	noi display " "
	noi display " "
	noi disp "**********************************************"
	noi disp "Disparity in long sleep, 2004, low-income only"
	noi disp "**********************************************"
    local Pval=2*(1-normal(abs(diff_long_`G'/diff_long_`G'_SE)))
    local Pval=cond(`Pval'<0.001,"<0.001",string(`Pval',"%5.3f"))
  noi disp "`G'-white '04" _col(20) %5.2f diff_long_`G'*100 _col(30) "(" %5.2f diff_long_`G'_lb*100 "," %5.2f diff_long_`G'_ub*100 ")" _col(50) "`Pval'"
}
}


qui { 
keep if year==2018
	noi display " "
	noi display " "
	noi disp "**********************************************"
	noi disp "**********************************************"
	noi disp "Quantifying disparities in 2018, low-income only"
	noi disp "**********************************************"
	noi disp "**********************************************"
foreach G in asian black hisp  {

	noi display " "
	noi display " "
	noi disp "**********************************************"
	noi disp "Disparity in short sleep, 2018, low-income only"
	noi disp "**********************************************"
    local Pval=2*(1-normal(abs(diff_less_`G'/diff_less_`G'_SE)))
    local Pval=cond(`Pval'<0.001,"<0.001",string(`Pval',"%5.3f"))
  noi disp "`G'-white '18" _col(20) %5.2f diff_less_`G'*100 _col(30) "(" %5.2f diff_less_`G'_lb*100 "," %5.2f diff_less_`G'_ub*100 ")" _col(50) "`Pval'"

 	noi display " "
	noi display " "
	noi disp "**********************************************"
	noi disp "Disparity in recommended sleep, 2018, low-income only"
	noi disp "**********************************************"
    local Pval=2*(1-normal(abs(diff_good_`G'/diff_good_`G'_SE)))
    local Pval=cond(`Pval'<0.001,"<0.001",string(`Pval',"%5.3f"))
  noi disp "`G'-white '18" _col(20) %5.2f diff_good_`G'*100 _col(30) "(" %5.2f diff_good_`G'_lb*100 "," %5.2f diff_good_`G'_ub*100 ")" _col(50) "`Pval'"
  
 	noi display " "
	noi display " "
	noi disp "**********************************************"
	noi disp "Disparity in long sleep, 2018, low-income only"
	noi disp "**********************************************"
    local Pval=2*(1-normal(abs(diff_long_`G'/diff_long_`G'_SE)))
    local Pval=cond(`Pval'<0.001,"<0.001",string(`Pval',"%5.3f"))
  noi disp "`G'-white '18" _col(20) %5.2f diff_long_`G'*100 _col(30) "(" %5.2f diff_long_`G'_lb*100 "," %5.2f diff_long_`G'_ub*100 ")" _col(50) "`Pval'"
}

}
}

**#				3.2 Middle/high-income only

use ratefile_midhighinc, clear
	local zcrit=invnorm(.975)


foreach K in less good long {
	foreach D in black asian hisp {
     gen diff_`K'_`D'=(rate_`K'_`D' - rate_`K'_white)     
     gen diff_`K'_`D'_SE = sqrt(stderr_`K'_`D'^2 + stderr_`K'_white^2)
     gen diff_`K'_`D'_lb=diff_`K'_`D'-diff_`K'_`D'_SE*`zcrit'
     gen diff_`K'_`D'_ub=diff_`K'_`D'+diff_`K'_`D'_SE*`zcrit'
     gen wt_diff_`K'_`D'= 1/diff_`K'_`D'_SE^2 
		}
	}


qui {
foreach K in less good long {	
foreach R in white black asian hisp allfour {
    gen wt_`K'_`R'=1/(stderr_`K'_`R')^2         

}
}


noi {
	display " "
	display " "
	disp "**********************************************"
	display "Change in prevalence, middle/high-income only"
	disp "**********************************************"
	display " "
	foreach R in white black asian hisp allfour {
    reg rate_less_`R' year [aw=wt_less_`R'] 
    reg rate_good_`R' year [aw=wt_good_`R'] 
    reg rate_long_`R' year [aw=wt_long_`R'] 
}
}

noi {
	display " "
	display " "
	disp "**********************************************"
	display "Change in disparities, middle/high-income only"
	disp "**********************************************"
	display " "
	foreach P in black asian hisp {
    reg diff_less_`P' year [aw=(wt_diff_less_`P')]  
    reg diff_good_`P' year [aw=(wt_diff_good_`P')] 
    reg diff_long_`P' year [aw=(wt_diff_long_`P')]  

}
}
 
keep if inlist(year,2004,2018)
sort year

local zcrit=invnorm(.975)
qui {
	noi display " "
	noi display " "
	noi disp "**********************************************"
	noi disp "**********************************************"
	noi disp "Change in prevalence, middle/high-income only"
	noi disp "**********************************************"
	noi disp "**********************************************"
	noi display " "
	noi display " "
foreach R in white black asian hispanic allfour {

	noi display " "
	noi display " "
	noi disp "**********************************************"
	noi disp "Change in short sleep prevalence, 2004-2018, middle/high-income only"
	noi disp "**********************************************"
    local diff=rate_less_`R'[2]-rate_less_`R'[1]         
    local SE = sqrt(stderr_less_`R'[2]^2+stderr_less_`R'[1]^2)
    local lb=`diff'-`zcrit'*`SE'
    local ub=`diff'+`zcrit'*`SE'
    local Pval=(2*(1-normal(abs(`diff'/`SE'))))
    local Pval=cond(`Pval'<0.001,"<0.001",string(`Pval',"%5.3f"))
    noi di "`R'" _col(20) %5.2f `diff'*100 _col(30) "(" %5.2f `lb'*100 "," %5.2f `ub'*100 ")" _col(50) "`Pval'"
	

	noi display " "
	noi display " "
	noi disp "**********************************************"
	noi disp "Change in recommended sleep prevalence, 2004-2018, middle/high-income only"
	noi disp "**********************************************"
    local diff=rate_good_`R'[2]-rate_good_`R'[1]         
    local SE = sqrt(stderr_good_`R'[2]^2+stderr_good_`R'[1]^2)
    local lb=`diff'-`zcrit'*`SE'
    local ub=`diff'+`zcrit'*`SE'
    local Pval=(2*(1-normal(abs(`diff'/`SE'))))
    local Pval=cond(`Pval'<0.001,"<0.001",string(`Pval',"%5.3f"))
    noi di "`R'" _col(20) %5.2f `diff'*100 _col(30) "(" %5.2f `lb'*100 "," %5.2f `ub'*100 ")" _col(50) "`Pval'"

	noi display " "
	noi display " "
	noi disp "**********************************************"
	noi disp "Change in long sleep prevalence, 2004-2018, middle/high-income only"
	noi disp "**********************************************"
    local diff=rate_long_`R'[2]-rate_long_`R'[1]         
    local SE = sqrt(stderr_long_`R'[2]^2+stderr_long_`R'[1]^2)
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
	noi disp "**********************************************"
	noi disp "Change in disparities, middle/high-income only"
	noi disp "**********************************************"
	noi disp "**********************************************"
	noi display " "
	noi display " "
	
foreach R in black asian hisp {
	
	noi display " "
	noi display " "
	noi disp "**********************************************"
	noi disp "Change in short sleep disparity, 2004-2018, middle/high-income only"
	noi disp "**********************************************"
    local diff_1=rate_less_`R'[1]-rate_less_white[1]         
    local diff_2=rate_less_`R'[2]-rate_less_white[2]        
    local did=`diff_2'-`diff_1'
    local SE_1= sqrt(stderr_less_`R'[1]^2+stderr_less_white[1]^2) 
    local SE_2= sqrt(stderr_less_`R'[2]^2+stderr_less_white[2]^2) 
    local SE_did=sqrt(`SE_2'^2+`SE_1'^2)
    local lb=`did'-`zcrit'*`SE_did'
    local ub=`did'+`zcrit'*`SE_did'
    local Pval=2*(1-normal(abs(`did'/`SE_did')))
    local Pval=cond(`Pval'<0.001,"<0.001",string(`Pval',"%5.3f"))
    noi di "`R'" _col(20) %5.2f `did'*100 _col(30) "(" %5.2f `lb'*100 "," %5.2f `ub'*100 ")" _col(50) "`Pval'"
	
	noi display " "
	noi display " "
	noi disp "**********************************************"
	noi disp "Change in recommended sleep disparity, 2004-2018, middle/high-income only"
	noi disp "**********************************************"
    local diff_1=rate_good_`R'[1]-rate_good_white[1]         
    local diff_2=rate_good_`R'[2]-rate_good_white[2]        
    local did=`diff_2'-`diff_1'
    local SE_1= sqrt(stderr_good_`R'[1]^2+stderr_good_white[1]^2) 
    local SE_2= sqrt(stderr_good_`R'[2]^2+stderr_good_white[2]^2) 
    local SE_did=sqrt(`SE_2'^2+`SE_1'^2)
    local lb=`did'-`zcrit'*`SE_did'
    local ub=`did'+`zcrit'*`SE_did'
    local Pval=2*(1-normal(abs(`did'/`SE_did')))
    local Pval=cond(`Pval'<0.001,"<0.001",string(`Pval',"%5.3f"))
    noi di "`R'" _col(20) %5.2f `did'*100 _col(30) "(" %5.2f `lb'*100 "," %5.2f `ub'*100 ")" _col(50) "`Pval'"
	
	noi display " "
	noi display " "
	noi disp "**********************************************"
	noi disp "Change in long sleep disparity, 2004-2018, middle/high-income only"
	noi disp "**********************************************"
    local diff_1=rate_long_`R'[1]-rate_long_white[1]         
    local diff_2=rate_long_`R'[2]-rate_long_white[2]        
    local did=`diff_2'-`diff_1'
    local SE_1= sqrt(stderr_long_`R'[1]^2+stderr_long_white[1]^2) 
    local SE_2= sqrt(stderr_long_`R'[2]^2+stderr_long_white[2]^2) 
    local SE_did=sqrt(`SE_2'^2+`SE_1'^2)
    local lb=`did'-`zcrit'*`SE_did'
    local ub=`did'+`zcrit'*`SE_did'
    local Pval=2*(1-normal(abs(`did'/`SE_did')))
    local Pval=cond(`Pval'<0.001,"<0.001",string(`Pval',"%5.3f"))
    noi di "`R'" _col(20) %5.2f `did'*100 _col(30) "(" %5.2f `lb'*100 "," %5.2f `ub'*100 ")" _col(50) "`Pval'"
	
}
}


qui if year==2004  {
	noi display " "
	noi display " "
	noi disp "**********************************************"
	noi disp "**********************************************"
	noi disp "Quantifying disparities in 2004, middle/high-income only "
	noi disp "**********************************************"
	noi disp "**********************************************"
foreach G in asian black hisp  {

	noi display " "
	noi display " "
	noi disp "**********************************************"
	noi disp "Disparity in short sleep, 2004, middle/high-income only"
	noi disp "**********************************************"
    local Pval=2*(1-normal(abs(diff_less_`G'/diff_less_`G'_SE)))
    local Pval=cond(`Pval'<0.001,"<0.001",string(`Pval',"%5.3f"))
  noi disp "`G'-white '04" _col(20) %5.2f diff_less_`G'*100 _col(30) "(" %5.2f diff_less_`G'_lb*100 "," %5.2f diff_less_`G'_ub*100 ")" _col(50) "`Pval'"

 	noi display " "
	noi display " "
	noi disp "**********************************************"
	noi disp "Disparity in recommended sleep, 2004, middle/high-income only"
	noi disp "**********************************************"
    local Pval=2*(1-normal(abs(diff_good_`G'/diff_good_`G'_SE)))
    local Pval=cond(`Pval'<0.001,"<0.001",string(`Pval',"%5.3f"))
  noi disp "`G'-white '04" _col(20) %5.2f diff_good_`G'*100 _col(30) "(" %5.2f diff_good_`G'_lb*100 "," %5.2f diff_good_`G'_ub*100 ")" _col(50) "`Pval'"
  
 	noi display " "
	noi display " "
	noi disp "**********************************************"
	noi disp "Disparity in long sleep, 2004, middle/high-income only"
	noi disp "**********************************************"
    local Pval=2*(1-normal(abs(diff_long_`G'/diff_long_`G'_SE)))
    local Pval=cond(`Pval'<0.001,"<0.001",string(`Pval',"%5.3f"))
  noi disp "`G'-white '04" _col(20) %5.2f diff_long_`G'*100 _col(30) "(" %5.2f diff_long_`G'_lb*100 "," %5.2f diff_long_`G'_ub*100 ")" _col(50) "`Pval'"
}
}


qui { 
keep if year==2018
	noi display " "
	noi display " "
	noi disp "**********************************************"
	noi disp "**********************************************"
	noi disp "Quantifying disparities in 2018, middle/high-income only"
	noi disp "**********************************************"
	noi disp "**********************************************"
foreach G in asian black hisp  {

	noi display " "
	noi display " "
	noi disp "**********************************************"
	noi disp "Disparity in short sleep, 2018, middle/high-income only"
	noi disp "**********************************************"
    local Pval=2*(1-normal(abs(diff_less_`G'/diff_less_`G'_SE)))
    local Pval=cond(`Pval'<0.001,"<0.001",string(`Pval',"%5.3f"))
  noi disp "`G'-white '18" _col(20) %5.2f diff_less_`G'*100 _col(30) "(" %5.2f diff_less_`G'_lb*100 "," %5.2f diff_less_`G'_ub*100 ")" _col(50) "`Pval'"

 	noi display " "
	noi display " "
	noi disp "**********************************************"
	noi disp "Disparity in recommended sleep, 2018, middle/high-income only"
	noi disp "**********************************************"
    local Pval=2*(1-normal(abs(diff_good_`G'/diff_good_`G'_SE)))
    local Pval=cond(`Pval'<0.001,"<0.001",string(`Pval',"%5.3f"))
  noi disp "`G'-white '18" _col(20) %5.2f diff_good_`G'*100 _col(30) "(" %5.2f diff_good_`G'_lb*100 "," %5.2f diff_good_`G'_ub*100 ")" _col(50) "`Pval'"
  
 	noi display " "
	noi display " "
	noi disp "**********************************************"
	noi disp "Disparity in long sleep, 2018, middle/high-income only"
	noi disp "**********************************************"
    local Pval=2*(1-normal(abs(diff_long_`G'/diff_long_`G'_SE)))
    local Pval=cond(`Pval'<0.001,"<0.001",string(`Pval',"%5.3f"))
  noi disp "`G'-white '18" _col(20) %5.2f diff_long_`G'*100 _col(30) "(" %5.2f diff_long_`G'_lb*100 "," %5.2f diff_long_`G'_ub*100 ")" _col(50) "`Pval'"
}

}
}

**#			4. By health status

**#				4.1 Poor or fair health


use ratefile_sleep_poorhealth, clear
	local zcrit=invnorm(.975)


foreach K in less good long {
	foreach D in black asian hisp {
     gen diff_`K'_`D'=(rate_`K'_`D' - rate_`K'_white)     
     gen diff_`K'_`D'_SE = sqrt(stderr_`K'_`D'^2 + stderr_`K'_white^2)
     gen diff_`K'_`D'_lb=diff_`K'_`D'-diff_`K'_`D'_SE*`zcrit'
     gen diff_`K'_`D'_ub=diff_`K'_`D'+diff_`K'_`D'_SE*`zcrit'
     gen wt_diff_`K'_`D'= 1/diff_`K'_`D'_SE^2 
		}
	}


qui {
foreach K in less good long {	
foreach R in white black asian hisp allfour {
    gen wt_`K'_`R'=1/(stderr_`K'_`R')^2         

}
}


noi {
	display " "
	display " "
	disp "**********************************************"
	display "Change in prevalence, poor health only"
	disp "**********************************************"
	display " "
	foreach R in white black asian hisp allfour {
    reg rate_less_`R' year [aw=wt_less_`R'] 
    reg rate_good_`R' year [aw=wt_good_`R'] 
    reg rate_long_`R' year [aw=wt_long_`R'] 
}
}

noi {
	display " "
	display " "
	disp "**********************************************"
	display "Change in disparities, poor health only"
	disp "**********************************************"
	display " "
	foreach P in black asian hisp {
    reg diff_less_`P' year [aw=(wt_diff_less_`P')]  
    reg diff_good_`P' year [aw=(wt_diff_good_`P')] 
    reg diff_long_`P' year [aw=(wt_diff_long_`P')]  

}
}
 
keep if inlist(year,2004,2018)
sort year

local zcrit=invnorm(.975)
qui {
	noi display " "
	noi display " "
	noi disp "**********************************************"
	noi disp "**********************************************"
	noi disp "Change in prevalence, poor health only"
	noi disp "**********************************************"
	noi disp "**********************************************"
	noi display " "
	noi display " "
foreach R in white black asian hispanic allfour {

	noi display " "
	noi display " "
	noi disp "**********************************************"
	noi disp "Change in short sleep prevalence, 2004-2018, poor health only"
	noi disp "**********************************************"
    local diff=rate_less_`R'[2]-rate_less_`R'[1]         
    local SE = sqrt(stderr_less_`R'[2]^2+stderr_less_`R'[1]^2)
    local lb=`diff'-`zcrit'*`SE'
    local ub=`diff'+`zcrit'*`SE'
    local Pval=(2*(1-normal(abs(`diff'/`SE'))))
    local Pval=cond(`Pval'<0.001,"<0.001",string(`Pval',"%5.3f"))
    noi di "`R'" _col(20) %5.2f `diff'*100 _col(30) "(" %5.2f `lb'*100 "," %5.2f `ub'*100 ")" _col(50) "`Pval'"
	

	noi display " "
	noi display " "
	noi disp "**********************************************"
	noi disp "Change in recommended sleep prevalence, 2004-2018, poor health only"
	noi disp "**********************************************"
    local diff=rate_good_`R'[2]-rate_good_`R'[1]         
    local SE = sqrt(stderr_good_`R'[2]^2+stderr_good_`R'[1]^2)
    local lb=`diff'-`zcrit'*`SE'
    local ub=`diff'+`zcrit'*`SE'
    local Pval=(2*(1-normal(abs(`diff'/`SE'))))
    local Pval=cond(`Pval'<0.001,"<0.001",string(`Pval',"%5.3f"))
    noi di "`R'" _col(20) %5.2f `diff'*100 _col(30) "(" %5.2f `lb'*100 "," %5.2f `ub'*100 ")" _col(50) "`Pval'"

	noi display " "
	noi display " "
	noi disp "**********************************************"
	noi disp "Change in long sleep prevalence, 2004-2018, poor health only"
	noi disp "**********************************************"
    local diff=rate_long_`R'[2]-rate_long_`R'[1]         
    local SE = sqrt(stderr_long_`R'[2]^2+stderr_long_`R'[1]^2)
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
	noi disp "**********************************************"
	noi disp "Change in disparities, poor health only"
	noi disp "**********************************************"
	noi disp "**********************************************"
	noi display " "
	noi display " "
	
foreach R in black asian hisp {
	
	noi display " "
	noi display " "
	noi disp "**********************************************"
	noi disp "Change in short sleep disparity, 2004-2018, poor health only"
	noi disp "**********************************************"
    local diff_1=rate_less_`R'[1]-rate_less_white[1]         
    local diff_2=rate_less_`R'[2]-rate_less_white[2]        
    local did=`diff_2'-`diff_1'
    local SE_1= sqrt(stderr_less_`R'[1]^2+stderr_less_white[1]^2) 
    local SE_2= sqrt(stderr_less_`R'[2]^2+stderr_less_white[2]^2) 
    local SE_did=sqrt(`SE_2'^2+`SE_1'^2)
    local lb=`did'-`zcrit'*`SE_did'
    local ub=`did'+`zcrit'*`SE_did'
    local Pval=2*(1-normal(abs(`did'/`SE_did')))
    local Pval=cond(`Pval'<0.001,"<0.001",string(`Pval',"%5.3f"))
    noi di "`R'" _col(20) %5.2f `did'*100 _col(30) "(" %5.2f `lb'*100 "," %5.2f `ub'*100 ")" _col(50) "`Pval'"
	
	noi display " "
	noi display " "
	noi disp "**********************************************"
	noi disp "Change in recommended sleep disparity, 2004-2018, poor health only"
	noi disp "**********************************************"
    local diff_1=rate_good_`R'[1]-rate_good_white[1]         
    local diff_2=rate_good_`R'[2]-rate_good_white[2]        
    local did=`diff_2'-`diff_1'
    local SE_1= sqrt(stderr_good_`R'[1]^2+stderr_good_white[1]^2) 
    local SE_2= sqrt(stderr_good_`R'[2]^2+stderr_good_white[2]^2) 
    local SE_did=sqrt(`SE_2'^2+`SE_1'^2)
    local lb=`did'-`zcrit'*`SE_did'
    local ub=`did'+`zcrit'*`SE_did'
    local Pval=2*(1-normal(abs(`did'/`SE_did')))
    local Pval=cond(`Pval'<0.001,"<0.001",string(`Pval',"%5.3f"))
    noi di "`R'" _col(20) %5.2f `did'*100 _col(30) "(" %5.2f `lb'*100 "," %5.2f `ub'*100 ")" _col(50) "`Pval'"
	
	noi display " "
	noi display " "
	noi disp "**********************************************"
	noi disp "Change in long sleep disparity, 2004-2018, poor health only"
	noi disp "**********************************************"
    local diff_1=rate_long_`R'[1]-rate_long_white[1]         
    local diff_2=rate_long_`R'[2]-rate_long_white[2]        
    local did=`diff_2'-`diff_1'
    local SE_1= sqrt(stderr_long_`R'[1]^2+stderr_long_white[1]^2) 
    local SE_2= sqrt(stderr_long_`R'[2]^2+stderr_long_white[2]^2) 
    local SE_did=sqrt(`SE_2'^2+`SE_1'^2)
    local lb=`did'-`zcrit'*`SE_did'
    local ub=`did'+`zcrit'*`SE_did'
    local Pval=2*(1-normal(abs(`did'/`SE_did')))
    local Pval=cond(`Pval'<0.001,"<0.001",string(`Pval',"%5.3f"))
    noi di "`R'" _col(20) %5.2f `did'*100 _col(30) "(" %5.2f `lb'*100 "," %5.2f `ub'*100 ")" _col(50) "`Pval'"
	
}
}


qui if year==2004  {
	noi display " "
	noi display " "
	noi disp "**********************************************"
	noi disp "**********************************************"
	noi disp "Quantifying disparities in 2004, poor health only "
	noi disp "**********************************************"
	noi disp "**********************************************"
foreach G in asian black hisp  {

	noi display " "
	noi display " "
	noi disp "**********************************************"
	noi disp "Disparity in short sleep, 2004, poor health only"
	noi disp "**********************************************"
    local Pval=2*(1-normal(abs(diff_less_`G'/diff_less_`G'_SE)))
    local Pval=cond(`Pval'<0.001,"<0.001",string(`Pval',"%5.3f"))
  noi disp "`G'-white '04" _col(20) %5.2f diff_less_`G'*100 _col(30) "(" %5.2f diff_less_`G'_lb*100 "," %5.2f diff_less_`G'_ub*100 ")" _col(50) "`Pval'"

 	noi display " "
	noi display " "
	noi disp "**********************************************"
	noi disp "Disparity in recommended sleep, 2004, poor health only"
	noi disp "**********************************************"
    local Pval=2*(1-normal(abs(diff_good_`G'/diff_good_`G'_SE)))
    local Pval=cond(`Pval'<0.001,"<0.001",string(`Pval',"%5.3f"))
  noi disp "`G'-white '04" _col(20) %5.2f diff_good_`G'*100 _col(30) "(" %5.2f diff_good_`G'_lb*100 "," %5.2f diff_good_`G'_ub*100 ")" _col(50) "`Pval'"
  
 	noi display " "
	noi display " "
	noi disp "**********************************************"
	noi disp "Disparity in long sleep, 2004, poor health only"
	noi disp "**********************************************"
    local Pval=2*(1-normal(abs(diff_long_`G'/diff_long_`G'_SE)))
    local Pval=cond(`Pval'<0.001,"<0.001",string(`Pval',"%5.3f"))
  noi disp "`G'-white '04" _col(20) %5.2f diff_long_`G'*100 _col(30) "(" %5.2f diff_long_`G'_lb*100 "," %5.2f diff_long_`G'_ub*100 ")" _col(50) "`Pval'"
}
}


qui { 
keep if year==2018
	noi display " "
	noi display " "
	noi disp "**********************************************"
	noi disp "**********************************************"
	noi disp "Quantifying disparities in 2018, poor health only"
	noi disp "**********************************************"
	noi disp "**********************************************"
foreach G in asian black hisp  {

	noi display " "
	noi display " "
	noi disp "**********************************************"
	noi disp "Disparity in short sleep, 2018, poor health only"
	noi disp "**********************************************"
    local Pval=2*(1-normal(abs(diff_less_`G'/diff_less_`G'_SE)))
    local Pval=cond(`Pval'<0.001,"<0.001",string(`Pval',"%5.3f"))
  noi disp "`G'-white '18" _col(20) %5.2f diff_less_`G'*100 _col(30) "(" %5.2f diff_less_`G'_lb*100 "," %5.2f diff_less_`G'_ub*100 ")" _col(50) "`Pval'"

 	noi display " "
	noi display " "
	noi disp "**********************************************"
	noi disp "Disparity in recommended sleep, 2018, poor health only"
	noi disp "**********************************************"
    local Pval=2*(1-normal(abs(diff_good_`G'/diff_good_`G'_SE)))
    local Pval=cond(`Pval'<0.001,"<0.001",string(`Pval',"%5.3f"))
  noi disp "`G'-white '18" _col(20) %5.2f diff_good_`G'*100 _col(30) "(" %5.2f diff_good_`G'_lb*100 "," %5.2f diff_good_`G'_ub*100 ")" _col(50) "`Pval'"
  
 	noi display " "
	noi display " "
	noi disp "**********************************************"
	noi disp "Disparity in long sleep, 2018, poor health only"
	noi disp "**********************************************"
    local Pval=2*(1-normal(abs(diff_long_`G'/diff_long_`G'_SE)))
    local Pval=cond(`Pval'<0.001,"<0.001",string(`Pval',"%5.3f"))
  noi disp "`G'-white '18" _col(20) %5.2f diff_long_`G'*100 _col(30) "(" %5.2f diff_long_`G'_lb*100 "," %5.2f diff_long_`G'_ub*100 ")" _col(50) "`Pval'"
}

}
}

**#				4.2 Good, very good, and excellent health


use ratefile_sleep_goodhealth, clear
	local zcrit=invnorm(.975)


foreach K in less good long {
	foreach D in black asian hisp {
     gen diff_`K'_`D'=(rate_`K'_`D' - rate_`K'_white)     
     gen diff_`K'_`D'_SE = sqrt(stderr_`K'_`D'^2 + stderr_`K'_white^2)
     gen diff_`K'_`D'_lb=diff_`K'_`D'-diff_`K'_`D'_SE*`zcrit'
     gen diff_`K'_`D'_ub=diff_`K'_`D'+diff_`K'_`D'_SE*`zcrit'
     gen wt_diff_`K'_`D'= 1/diff_`K'_`D'_SE^2 
		}
	}


qui {
foreach K in less good long {	
foreach R in white black asian hisp allfour {
    gen wt_`K'_`R'=1/(stderr_`K'_`R')^2         

}
}


noi {
	display " "
	display " "
	disp "**********************************************"
	display "Change in prevalence, good health only"
	disp "**********************************************"
	display " "
	foreach R in white black asian hisp allfour {
    reg rate_less_`R' year [aw=wt_less_`R'] 
    reg rate_good_`R' year [aw=wt_good_`R'] 
    reg rate_long_`R' year [aw=wt_long_`R'] 
}
}

noi {
	display " "
	display " "
	disp "**********************************************"
	display "Change in disparities, good health only"
	disp "**********************************************"
	display " "
	foreach P in black asian hisp {
    reg diff_less_`P' year [aw=(wt_diff_less_`P')]  
    reg diff_good_`P' year [aw=(wt_diff_good_`P')] 
    reg diff_long_`P' year [aw=(wt_diff_long_`P')]  

}
}
 
keep if inlist(year,2004,2018)
sort year

local zcrit=invnorm(.975)
qui {
	noi display " "
	noi display " "
	noi disp "**********************************************"
	noi disp "**********************************************"
	noi disp "Change in prevalence, good health only"
	noi disp "**********************************************"
	noi disp "**********************************************"
	noi display " "
	noi display " "
foreach R in white black asian hispanic allfour {

	noi display " "
	noi display " "
	noi disp "**********************************************"
	noi disp "Change in short sleep prevalence, 2004-2018, good health only"
	noi disp "**********************************************"
    local diff=rate_less_`R'[2]-rate_less_`R'[1]         
    local SE = sqrt(stderr_less_`R'[2]^2+stderr_less_`R'[1]^2)
    local lb=`diff'-`zcrit'*`SE'
    local ub=`diff'+`zcrit'*`SE'
    local Pval=(2*(1-normal(abs(`diff'/`SE'))))
    local Pval=cond(`Pval'<0.001,"<0.001",string(`Pval',"%5.3f"))
    noi di "`R'" _col(20) %5.2f `diff'*100 _col(30) "(" %5.2f `lb'*100 "," %5.2f `ub'*100 ")" _col(50) "`Pval'"
	

	noi display " "
	noi display " "
	noi disp "**********************************************"
	noi disp "Change in recommended sleep prevalence, 2004-2018, good health only"
	noi disp "**********************************************"
    local diff=rate_good_`R'[2]-rate_good_`R'[1]         
    local SE = sqrt(stderr_good_`R'[2]^2+stderr_good_`R'[1]^2)
    local lb=`diff'-`zcrit'*`SE'
    local ub=`diff'+`zcrit'*`SE'
    local Pval=(2*(1-normal(abs(`diff'/`SE'))))
    local Pval=cond(`Pval'<0.001,"<0.001",string(`Pval',"%5.3f"))
    noi di "`R'" _col(20) %5.2f `diff'*100 _col(30) "(" %5.2f `lb'*100 "," %5.2f `ub'*100 ")" _col(50) "`Pval'"

	noi display " "
	noi display " "
	noi disp "**********************************************"
	noi disp "Change in long sleep prevalence, 2004-2018, good health only"
	noi disp "**********************************************"
    local diff=rate_long_`R'[2]-rate_long_`R'[1]         
    local SE = sqrt(stderr_long_`R'[2]^2+stderr_long_`R'[1]^2)
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
	noi disp "**********************************************"
	noi disp "Change in disparities, good health only"
	noi disp "**********************************************"
	noi disp "**********************************************"
	noi display " "
	noi display " "
	
foreach R in black asian hisp {
	
	noi display " "
	noi display " "
	noi disp "**********************************************"
	noi disp "Change in short sleep disparity, 2004-2018, good health only"
	noi disp "**********************************************"
    local diff_1=rate_less_`R'[1]-rate_less_white[1]         
    local diff_2=rate_less_`R'[2]-rate_less_white[2]        
    local did=`diff_2'-`diff_1'
    local SE_1= sqrt(stderr_less_`R'[1]^2+stderr_less_white[1]^2) 
    local SE_2= sqrt(stderr_less_`R'[2]^2+stderr_less_white[2]^2) 
    local SE_did=sqrt(`SE_2'^2+`SE_1'^2)
    local lb=`did'-`zcrit'*`SE_did'
    local ub=`did'+`zcrit'*`SE_did'
    local Pval=2*(1-normal(abs(`did'/`SE_did')))
    local Pval=cond(`Pval'<0.001,"<0.001",string(`Pval',"%5.3f"))
    noi di "`R'" _col(20) %5.2f `did'*100 _col(30) "(" %5.2f `lb'*100 "," %5.2f `ub'*100 ")" _col(50) "`Pval'"
	
	noi display " "
	noi display " "
	noi disp "**********************************************"
	noi disp "Change in recommended sleep disparity, 2004-2018, good health only"
	noi disp "**********************************************"
    local diff_1=rate_good_`R'[1]-rate_good_white[1]         
    local diff_2=rate_good_`R'[2]-rate_good_white[2]        
    local did=`diff_2'-`diff_1'
    local SE_1= sqrt(stderr_good_`R'[1]^2+stderr_good_white[1]^2) 
    local SE_2= sqrt(stderr_good_`R'[2]^2+stderr_good_white[2]^2) 
    local SE_did=sqrt(`SE_2'^2+`SE_1'^2)
    local lb=`did'-`zcrit'*`SE_did'
    local ub=`did'+`zcrit'*`SE_did'
    local Pval=2*(1-normal(abs(`did'/`SE_did')))
    local Pval=cond(`Pval'<0.001,"<0.001",string(`Pval',"%5.3f"))
    noi di "`R'" _col(20) %5.2f `did'*100 _col(30) "(" %5.2f `lb'*100 "," %5.2f `ub'*100 ")" _col(50) "`Pval'"
	
	noi display " "
	noi display " "
	noi disp "**********************************************"
	noi disp "Change in long sleep disparity, 2004-2018, good health only"
	noi disp "**********************************************"
    local diff_1=rate_long_`R'[1]-rate_long_white[1]         
    local diff_2=rate_long_`R'[2]-rate_long_white[2]        
    local did=`diff_2'-`diff_1'
    local SE_1= sqrt(stderr_long_`R'[1]^2+stderr_long_white[1]^2) 
    local SE_2= sqrt(stderr_long_`R'[2]^2+stderr_long_white[2]^2) 
    local SE_did=sqrt(`SE_2'^2+`SE_1'^2)
    local lb=`did'-`zcrit'*`SE_did'
    local ub=`did'+`zcrit'*`SE_did'
    local Pval=2*(1-normal(abs(`did'/`SE_did')))
    local Pval=cond(`Pval'<0.001,"<0.001",string(`Pval',"%5.3f"))
    noi di "`R'" _col(20) %5.2f `did'*100 _col(30) "(" %5.2f `lb'*100 "," %5.2f `ub'*100 ")" _col(50) "`Pval'"
	
}
}


qui if year==2004  {
	noi display " "
	noi display " "
	noi disp "**********************************************"
	noi disp "**********************************************"
	noi disp "Quantifying disparities in 2004, good health only "
	noi disp "**********************************************"
	noi disp "**********************************************"
foreach G in asian black hisp  {

	noi display " "
	noi display " "
	noi disp "**********************************************"
	noi disp "Disparity in short sleep, 2004, good health only"
	noi disp "**********************************************"
    local Pval=2*(1-normal(abs(diff_less_`G'/diff_less_`G'_SE)))
    local Pval=cond(`Pval'<0.001,"<0.001",string(`Pval',"%5.3f"))
  noi disp "`G'-white '04" _col(20) %5.2f diff_less_`G'*100 _col(30) "(" %5.2f diff_less_`G'_lb*100 "," %5.2f diff_less_`G'_ub*100 ")" _col(50) "`Pval'"

 	noi display " "
	noi display " "
	noi disp "**********************************************"
	noi disp "Disparity in recommended sleep, 2004, good health only"
	noi disp "**********************************************"
    local Pval=2*(1-normal(abs(diff_good_`G'/diff_good_`G'_SE)))
    local Pval=cond(`Pval'<0.001,"<0.001",string(`Pval',"%5.3f"))
  noi disp "`G'-white '04" _col(20) %5.2f diff_good_`G'*100 _col(30) "(" %5.2f diff_good_`G'_lb*100 "," %5.2f diff_good_`G'_ub*100 ")" _col(50) "`Pval'"
  
 	noi display " "
	noi display " "
	noi disp "**********************************************"
	noi disp "Disparity in long sleep, 2004, good health only"
	noi disp "**********************************************"
    local Pval=2*(1-normal(abs(diff_long_`G'/diff_long_`G'_SE)))
    local Pval=cond(`Pval'<0.001,"<0.001",string(`Pval',"%5.3f"))
  noi disp "`G'-white '04" _col(20) %5.2f diff_long_`G'*100 _col(30) "(" %5.2f diff_long_`G'_lb*100 "," %5.2f diff_long_`G'_ub*100 ")" _col(50) "`Pval'"
}
}


qui { 
keep if year==2018
	noi display " "
	noi display " "
	noi disp "**********************************************"
	noi disp "**********************************************"
	noi disp "Quantifying disparities in 2018, good health only"
	noi disp "**********************************************"
	noi disp "**********************************************"
foreach G in asian black hisp  {

	noi display " "
	noi display " "
	noi disp "**********************************************"
	noi disp "Disparity in short sleep, 2018, good health only"
	noi disp "**********************************************"
    local Pval=2*(1-normal(abs(diff_less_`G'/diff_less_`G'_SE)))
    local Pval=cond(`Pval'<0.001,"<0.001",string(`Pval',"%5.3f"))
  noi disp "`G'-white '18" _col(20) %5.2f diff_less_`G'*100 _col(30) "(" %5.2f diff_less_`G'_lb*100 "," %5.2f diff_less_`G'_ub*100 ")" _col(50) "`Pval'"

 	noi display " "
	noi display " "
	noi disp "**********************************************"
	noi disp "Disparity in recommended sleep, 2018, good health only"
	noi disp "**********************************************"
    local Pval=2*(1-normal(abs(diff_good_`G'/diff_good_`G'_SE)))
    local Pval=cond(`Pval'<0.001,"<0.001",string(`Pval',"%5.3f"))
  noi disp "`G'-white '18" _col(20) %5.2f diff_good_`G'*100 _col(30) "(" %5.2f diff_good_`G'_lb*100 "," %5.2f diff_good_`G'_ub*100 ")" _col(50) "`Pval'"
  
 	noi display " "
	noi display " "
	noi disp "**********************************************"
	noi disp "Disparity in long sleep, 2018, good health only"
	noi disp "**********************************************"
    local Pval=2*(1-normal(abs(diff_long_`G'/diff_long_`G'_SE)))
    local Pval=cond(`Pval'<0.001,"<0.001",string(`Pval',"%5.3f"))
  noi disp "`G'-white '18" _col(20) %5.2f diff_long_`G'*100 _col(30) "(" %5.2f diff_long_`G'_lb*100 "," %5.2f diff_long_`G'_ub*100 ")" _col(50) "`Pval'"
}

}
}

