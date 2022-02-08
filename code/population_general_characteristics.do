
/* 				

			Temporal Trends in Racial and Ethnic Disparities in Sleep 
				Duration in the United States, 2004–2018

César Caraballo, Shiwani Mahajan, Javier Valero-Elizondo, Daisy Massey, Yuan Lu,
Brita Roy, Carley Riley, Amarnath R. Annapureddy, Karthik Murugiah, Johanna Elumn,
Khurram Nasir, Marcella Nunez-Smith, Howard P. Forman, Chandra L. Jackson, 
Jeph Herrin, Harlan M. Krumholz

medRxiv 2021.10.31.21265202

Available from: https://doi.org/10.1101/2021.10.31.21265202

	Study population general characteristics
							
*/

use sleep, clear

* Age, median (IQR) 

foreach R in asian black hispanic white allfour {
	
_pctile age  if `R'==1 [pweight=sampweight_ipums_pooled],p(50)
disp "`R' P50:"
return list
_pctile age  if `R'==1 [pweight=sampweight_ipums_pooled],p(25) 
disp "`R' P25:"
return list
_pctile age  if `R'==1 [pweight=sampweight_ipums_pooled],p(75)
disp "`R' P75:"
return list
}

* Age category

svy: tabulate agecat race, col ci

* Sex

svy: tabulate sex race, col ci

* Citizenship

svy: tabulate uscitizen race, col ci

* Education

svy: tabulate education race, col ci

* Income level is calculated at the end of this document

* Insurance

svy: tabulate noinsurance race, col ci

* Region

svy: tabulate region race, col ci

* Marital status

svy: tabulate married race, col ci

* Employment status

svy: tabulate workstat race, col ci

* Health status

svy: tabulate poorhealth race, col ci

* Chronic conditions

svy: tabulate hypertension race, col ci

svy: tabulate diabetes race, col ci

svy: tabulate mi_stroke race, col ci

svy: tabulate cancer race, col ci

svy: tabulate copd race, col ci

svy: tabulate cancer race, col ci

svy: tabulate stroke race, col ci

* Smoking Status

svy: tabulate currentsmoker race, col ci

* Obesity

svy: tabulate bminew race, col ci

* Sleep distribution

hist sleepdist, discrete percent by(race, note("")) xlabel(3(1)13, valuelabel)

/*******************************************************************************

Low-income estimation using multiply imputed variables

*******************************************************************************/


forvalues i=1/5 {
u sleep, clear
	
save temp, replace                                       

local zcrit=invnorm(.975)
set seed 20201209                                         
local iters 10000                                         
local lb = round(`iters'*0.025)
local ub = round(`iters'*0.975)

capture postclose rates
postfile rates str10 group float year rate_ stderr_ lb_ ub_ using ratefile, replace

qui foreach G in white black asian hispanic allfour { 
	u temp, clear
	svy, subpop(`G'): logit lowincome_`i' year_*  
	matrix b=e(b)
	matrix V=e(V)
	drawnorm x1-x16, means(b) cov(V) clear n(`iters')  
	forv y=2004/2018 {
		local n=(`y'-2004)+1                            
		gen rate=invlogit(x`n'+x16)                    
		sort rate
		sum rate
		post rates ("`G'") (`y') (invlogit(b[1,`n']+b[1,16])) (r(sd)) (rate[`lb']) (rate[`ub'])
		drop rate
	}
}
postclose rates
u ratefile, clear
reshape wide rate_ stderr_ lb_ ub_ , i(year) j(group) string

save ratefile_`i', replace                          
}
****************************************

****************************************
	
use ratefile_1, clear

foreach x in 2 3 4 5{
	append using ratefile_`x'
}

save appendedfile, replace 


foreach G in white black hispanic asian allfour {
		use appendedfile, clear
		sort year
		gen U=stderr_`G'^2      
        collapse (mean) rate_`G' U lb_`G' ub_`G' (sd) B=rate_`G' (count) M=rate_`G' , by(year)
        gen T=U+(M+1)*(B^2/M)
        gen stderr_`G'=T^0.5
        drop M B T U
		save collapsedfile_`G', replace
	} 

use	collapsedfile_asian, clear

foreach x in white black hispanic allfour {
	merge 1:1 year using collapsedfile_`x'
	drop _merge
}

foreach G in asian black hispanic white allfour {
	
	gen rate1_`G'=rate_`G'*100
	gen lb1_`G'=lb_`G'*100
	gen ub1_`G'=ub_`G'*100
	gen stderr1_`G'=stderr_`G'*100
	
	
}	

mean rate1_* lb1_* ub1_* stderr1_*
