
/* 

			Temporal Trends in Racial and Ethnic Disparities in Sleep 
				Duration in the United States, 2004–2018

César Caraballo, Shiwani Mahajan, Javier Valero-Elizondo, Daisy Massey, Yuan Lu,
Brita Roy, Carley Riley, Amarnath R. Annapureddy, Karthik Murugiah, Johanna Elumn,
Khurram Nasir, Marcella Nunez-Smith, Howard P. Forman, Chandra L. Jackson, 
Jeph Herrin, Harlan M. Krumholz

medRxiv 2021.10.31.21265202

Available from: https://doi.org/10.1101/2021.10.31.21265202
 

			
	Prevalence estimation by age
	
	This .do file provides estimates, by age, of short, recommended, and long
	sleep duration by race/ethnicity. 
			
		
		Table of contents
			1. Overall
			2. By sex/gender
				2.1 Females only
				2.2 Males only
			3. By household income level
				3.1 Low-income only
				3.2 Middle/high-income only
				
*/


**# 		1. Overall

u sleep, clear
gen byte sleep=less_sleep*0 + good_sleep*1 + long_sleep*2


save temp, replace                                       

	local zcrit=invnorm(.975)
	set seed 20201209                                         
	local iters 10000                                         
	local lb = round(`iters'*0.025)
	local ub = round(`iters'*0.975)

	capture postclose rates
	postfile rates str10 group float age_group rate_less_ rate_long_ rate_good_ stderr_less_ stderr_long_ stderr_good_ ///
				  lb_less_ lb_long_ lb_good_ ub_less_ ub_long_ ub_good_ using ratefile, replace
	
	*****

	qui foreach G in white black asian hispanic allfour { 
		u temp, clear
		svy, subpop(`G'): mlogit sleep age_group*, nocons  
		matrix z=e(b)  
		matrix V=e(V)
		drawnorm x1-x39, means(z) cov(V) clear n(`iters') 
		
		forv y=1/13 {
			local n0=`y'
                        local n2=`y'+26
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
reshape wide rate_* stderr_* lb_* ub_* , i(age_group) j(group) string


foreach K in less long {
	foreach D in black asian hisp {

		local zcrit=invnorm(.975)	
		gen diff_`K'_`D'=(rate_`K'_`D' - rate_`K'_white)     
		gen diff_`K'_`D'_SE = sqrt(stderr_`K'_`D'^2+ stderr_`K'_white^2)
		gen diff_`K'_`D'_lb=diff_`K'_`D'-diff_`K'_`D'_SE*`zcrit'
		gen diff_`K'_`D'_ub=diff_`K'_`D'+diff_`K'_`D'_SE*`zcrit'
		gen wt_`K'_diff_`D'= 1/diff_`K'_`D'_SE^2 
	 

}

	foreach R in white black asian hisp allfour {
		gen wt_`K'_`R'=1/(stderr_`K'_`R')^2         
}
}

save ratefile_sleep_age_all, replace  

**#			2. By sex/gender

**#				2.1 Females only

u sleep, clear
gen byte sleep=less_sleep*0 + good_sleep*1 + long_sleep*2


save temp, replace                                       

	local zcrit=invnorm(.975)
	set seed 20201209                                         
	local iters 10000                                         
	local lb = round(`iters'*0.025)
	local ub = round(`iters'*0.975)

	capture postclose rates
	postfile rates str10 group float age_group rate_less_ rate_long_ rate_good_ stderr_less_ stderr_long_ stderr_good_ ///
				  lb_less_ lb_long_ lb_good_ ub_less_ ub_long_ ub_good_ using ratefile, replace
	
	*****

	qui foreach G in white black asian hispanic allfour { 
		u temp, clear
		svy, subpop(if `G'==1 & female==1): mlogit sleep age_group*, nocons  
		matrix z=e(b)  
		matrix V=e(V)
		drawnorm x1-x39, means(z) cov(V) clear n(`iters') 
		
		forv y=1/13 {
			local n0=`y'
                        local n2=`y'+26
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
reshape wide rate_* stderr_* lb_* ub_* , i(age_group) j(group) string

foreach K in less long {
	foreach D in black asian hisp {

		local zcrit=invnorm(.975)	
		gen diff_`K'_`D'=(rate_`K'_`D' - rate_`K'_white)     
		gen diff_`K'_`D'_SE = sqrt(stderr_`K'_`D'^2+ stderr_`K'_white^2)
		gen diff_`K'_`D'_lb=diff_`K'_`D'-diff_`K'_`D'_SE*`zcrit'
		gen diff_`K'_`D'_ub=diff_`K'_`D'+diff_`K'_`D'_SE*`zcrit'
		gen wt_`K'_diff_`D'= 1/diff_`K'_`D'_SE^2 
	 

}

	foreach R in white black asian hisp allfour {
		gen wt_`K'_`R'=1/(stderr_`K'_`R')^2         
}
}

save ratefile_sleep_age_female, replace  

**#				2.2 Males only

u sleep, clear
gen byte sleep=less_sleep*0 + good_sleep*1 + long_sleep*2


save temp, replace                                       

	local zcrit=invnorm(.975)
	set seed 20201209                                         
	local iters 10000                                         
	local lb = round(`iters'*0.025)
	local ub = round(`iters'*0.975)

	capture postclose rates
	postfile rates str10 group float age_group rate_less_ rate_long_ rate_good_ stderr_less_ stderr_long_ stderr_good_ ///
				  lb_less_ lb_long_ lb_good_ ub_less_ ub_long_ ub_good_ using ratefile, replace
	
	*****

	qui foreach G in white black asian hispanic allfour { 
		u temp, clear
		svy, subpop(if `G'==1 & female==0): mlogit sleep age_group*, nocons  
		matrix z=e(b)  
		matrix V=e(V)
		drawnorm x1-x39, means(z) cov(V) clear n(`iters') 
		
		forv y=1/13 {
			local n0=`y'
                        local n2=`y'+26
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
reshape wide rate_* stderr_* lb_* ub_* , i(age_group) j(group) string

foreach K in less long {
	foreach D in black asian hisp {

		local zcrit=invnorm(.975)	
		gen diff_`K'_`D'=(rate_`K'_`D' - rate_`K'_white)     
		gen diff_`K'_`D'_SE = sqrt(stderr_`K'_`D'^2+ stderr_`K'_white^2)
		gen diff_`K'_`D'_lb=diff_`K'_`D'-diff_`K'_`D'_SE*`zcrit'
		gen diff_`K'_`D'_ub=diff_`K'_`D'+diff_`K'_`D'_SE*`zcrit'
		gen wt_`K'_diff_`D'= 1/diff_`K'_`D'_SE^2 
	 

}

	foreach R in white black asian hisp allfour {
		gen wt_`K'_`R'=1/(stderr_`K'_`R')^2         
}
}

save ratefile_sleep_age_male, replace  

**#			3. By household income level

**#				3.1 Low-income only


forv N = 1/5 {
u sleep, clear
gen byte sleep=less_sleep*0 + good_sleep*1 + long_sleep*2


save temp, replace                                       

	local zcrit=invnorm(.975)
	set seed 20201209                                         
	local iters 10000                                         
	local lb = round(`iters'*0.025)
	local ub = round(`iters'*0.975)

	capture postclose rates
	postfile rates str10 group float age_group rate_less_ rate_long_ rate_good_ stderr_less_ stderr_long_ stderr_good_ ///
				  lb_less_ lb_long_ lb_good_ ub_less_ ub_long_ ub_good_ using ratefile, replace
	
	*****

	qui foreach G in white black asian hispanic allfour { 
		u temp, clear
		svy, subpop(if `G'==1 & lowincome_`N'==1): mlogit sleep age_group*, nocons  
		matrix z=e(b)  
		matrix V=e(V)
		drawnorm x1-x39, means(z) cov(V) clear n(`iters') 
		
		forv y=1/13 {
			local n0=`y'
                        local n2=`y'+26
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
reshape wide rate_* stderr_* lb_* ub_* , i(age_group) j(group) string


save ratefile_`N', replace  
}

use ratefile_1, clear

foreach x in 2 3 4 5{
	append using ratefile_`x'
}

save appendedfile, replace 

** less_sleep

foreach G in white black hispanic asian allfour {
		use appendedfile, clear
		keep *less* age_group
		sort age_group
		gen U=stderr_less_`G'^2      
        collapse (mean) rate_less_`G' U lb_less_`G' ub_less_`G' (sd) B=rate_less_`G' (count) M=rate_less_`G' , by(age_group)
        gen T=U+(M+1)*(B^2/M)
        gen stderr_less_`G'=T^0.5
        drop M B T U
		save ratefile_less_`G'_lowinc, replace
	} 

** good_sleep

foreach G in white black hispanic asian allfour {
		use appendedfile, clear
		keep *good* age_group
		sort age_group
		gen U=stderr_good_`G'^2      
        collapse (mean) rate_good_`G' U lb_good_`G' ub_good_`G' (sd) B=rate_good_`G' (count) M=rate_good_`G' , by(age_group)
        gen T=U+(M+1)*(B^2/M)
        gen stderr_good_`G'=T^0.5
        drop M B T U
		save ratefile_good_`G'_lowinc, replace
	} 
	
** long_sleep

foreach G in white black hispanic asian allfour {
		use appendedfile, clear
		keep *long* age_group
		sort age_group
		gen U=stderr_long_`G'^2      
        collapse (mean) rate_long_`G' U lb_long_`G' ub_long_`G' (sd) B=rate_long_`G' (count) M=rate_long_`G' , by(age_group)
        gen T=U+(M+1)*(B^2/M)
        gen stderr_long_`G'=T^0.5
        drop M B T U
		save ratefile_long_`G'_lowinc, replace
	} 


** merging all

use ratefile_less_white_lowinc, clear
foreach K in black hispanic asian allfour {
merge 1:1 age_group using ratefile_less_`K'_lowinc
drop _merge
}
save ratefile_less_age_lowinc,replace

use ratefile_good_white_lowinc, clear
foreach K in black hispanic asian allfour {
merge 1:1 age_group using ratefile_good_`K'_lowinc
drop _merge
}
save ratefile_good_age_lowinc,replace	

use ratefile_long_white_lowinc, clear
foreach K in black hispanic asian allfour {
merge 1:1 age_group using ratefile_long_`K'_lowinc
drop _merge
}
save ratefile_long_age_lowinc,replace	

use ratefile_less_age_lowinc,clear
merge 1:1 age_group using ratefile_good_age_lowinc
drop _merge
merge 1:1 age_group using ratefile_long_age_lowinc
drop _merge

foreach K in less long {
	foreach D in black asian hisp {

		local zcrit=invnorm(.975)	
		gen diff_`K'_`D'=(rate_`K'_`D' - rate_`K'_white)     
		gen diff_`K'_`D'_SE = sqrt(stderr_`K'_`D'^2+ stderr_`K'_white^2)
		gen diff_`K'_`D'_lb=diff_`K'_`D'-diff_`K'_`D'_SE*`zcrit'
		gen diff_`K'_`D'_ub=diff_`K'_`D'+diff_`K'_`D'_SE*`zcrit'
		gen wt_`K'_diff_`D'= 1/diff_`K'_`D'_SE^2 
	 

}

	foreach R in white black asian hisp allfour {
		gen wt_`K'_`R'=1/(stderr_`K'_`R')^2         
}
}

save ratefile_age_lowinc,replace

**#				3.2 Middle/high-income only

forv N = 1/5 {
u sleep, clear
gen byte sleep=less_sleep*0 + good_sleep*1 + long_sleep*2


save temp, replace                                       

	local zcrit=invnorm(.975)
	set seed 20201209                                         
	local iters 10000                                         
	local lb = round(`iters'*0.025)
	local ub = round(`iters'*0.975)

	capture postclose rates
	postfile rates str10 group float age_group rate_less_ rate_long_ rate_good_ stderr_less_ stderr_long_ stderr_good_ ///
				  lb_less_ lb_long_ lb_good_ ub_less_ ub_long_ ub_good_ using ratefile, replace
	
	*****

	qui foreach G in white black asian hispanic allfour { 
		u temp, clear
		svy, subpop(if `G'==1 & lowincome_`N'==0): mlogit sleep age_group*, nocons  
		matrix z=e(b)  
		matrix V=e(V)
		drawnorm x1-x39, means(z) cov(V) clear n(`iters') 
		
		forv y=1/13 {
			local n0=`y'
                        local n2=`y'+26
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
reshape wide rate_* stderr_* lb_* ub_* , i(age_group) j(group) string



save ratefile_`N', replace  
}

use ratefile_1, clear

foreach x in 2 3 4 5{
	append using ratefile_`x'
}

save appendedfile, replace 

** less_sleep

foreach G in white black hispanic asian allfour {
		use appendedfile, clear
		keep *less* age_group
		sort age_group
		gen U=stderr_less_`G'^2      
        collapse (mean) rate_less_`G' U lb_less_`G' ub_less_`G' (sd) B=rate_less_`G' (count) M=rate_less_`G' , by(age_group)
        gen T=U+(M+1)*(B^2/M)
        gen stderr_less_`G'=T^0.5
        drop M B T U
		save ratefile_less_`G'_midhighinc, replace
	} 

** good_sleep

foreach G in white black hispanic asian allfour {
		use appendedfile, clear
		keep *good* age_group
		sort age_group
		gen U=stderr_good_`G'^2      
        collapse (mean) rate_good_`G' U lb_good_`G' ub_good_`G' (sd) B=rate_good_`G' (count) M=rate_good_`G' , by(age_group)
        gen T=U+(M+1)*(B^2/M)
        gen stderr_good_`G'=T^0.5
        drop M B T U
		save ratefile_good_`G'_midhighinc, replace
	} 
	
** long_sleep

foreach G in white black hispanic asian allfour {
		use appendedfile, clear
		keep *long* age_group
		sort age_group
		gen U=stderr_long_`G'^2      
        collapse (mean) rate_long_`G' U lb_long_`G' ub_long_`G' (sd) B=rate_long_`G' (count) M=rate_long_`G' , by(age_group)
        gen T=U+(M+1)*(B^2/M)
        gen stderr_long_`G'=T^0.5
        drop M B T U
		save ratefile_long_`G'_midhighinc, replace
	} 


** merging all

use ratefile_less_white_midhighinc, clear
foreach K in black hispanic asian allfour {
merge 1:1 age_group using ratefile_less_`K'_midhighinc
drop _merge
}
save ratefile_less_age_midhighinc,replace

use ratefile_good_white_midhighinc, clear
foreach K in black hispanic asian allfour {
merge 1:1 age_group using ratefile_good_`K'_midhighinc
drop _merge
}
save ratefile_good_age_midhighinc,replace	

use ratefile_long_white_midhighinc, clear
foreach K in black hispanic asian allfour {
merge 1:1 age_group using ratefile_long_`K'_midhighinc
drop _merge
}
save ratefile_long_age_midhighinc,replace	

use ratefile_less_age_midhighinc,clear
merge 1:1 age_group using ratefile_good_age_midhighinc
drop _merge
merge 1:1 age_group using ratefile_long_age_midhighinc
drop _merge

foreach K in less long {
	foreach D in black asian hisp {

		local zcrit=invnorm(.975)	
		gen diff_`K'_`D'=(rate_`K'_`D' - rate_`K'_white)     
		gen diff_`K'_`D'_SE = sqrt(stderr_`K'_`D'^2+ stderr_`K'_white^2)
		gen diff_`K'_`D'_lb=diff_`K'_`D'-diff_`K'_`D'_SE*`zcrit'
		gen diff_`K'_`D'_ub=diff_`K'_`D'+diff_`K'_`D'_SE*`zcrit'
		gen wt_`K'_diff_`D'= 1/diff_`K'_`D'_SE^2 
	 

}

	foreach R in white black asian hisp allfour {
		gen wt_`K'_`R'=1/(stderr_`K'_`R')^2         
}
}

save ratefile_age_midhighinc,replace
