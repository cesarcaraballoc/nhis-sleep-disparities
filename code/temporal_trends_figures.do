/* 

			Temporal Trends in Racial and Ethnic Disparities in Sleep 
				Duration in the United States, 2004–2018

César Caraballo, Shiwani Mahajan, Javier Valero-Elizondo, Daisy Massey, Yuan Lu,
Brita Roy, Carley Riley, Amarnath R. Annapureddy, Karthik Murugiah, Johanna Elumn,
Khurram Nasir, Marcella Nunez-Smith, Howard P. Forman, Chandra L. Jackson, 
Jeph Herrin, Harlan M. Krumholz

medRxiv 2021.10.31.21265202

Available from: https://doi.org/10.1101/2021.10.31.21265202 

			
	Trends figures
	
	This .do file produces the trends figures. 
	
	
	Table of contents
			1. Overall
				1.1 Short sleep duration
				1.2 Long sleep duration
			2. By sex/gender
				2.1 Short sleep duration
				2.2 Long sleep duration
			3. By income level
				3.1 Short sleep duration
				3.2 Long sleep duration
			4. By health status
				4.1 Short sleep duration
				4.2 Long sleep duration

*/

**#			1. Overall

use ratefile_sleep_all,clear

**#					1.1 Short sleep duration


#delimit ;
 mylabels 0(5)50, myscale(@/100) local(myla) ;

twoway 
	(connected rate_less_asian year, 
		lpattern(solid) lcolor(midgreen) lwidth(medium) msymbol(o) mcolor(midgreen)
		graphregion(color(none))
		) 
	(connected rate_less_black year, 
		lpattern(solid) lcolor(cranberry) lwidth(medium) msymbol(s) mcolor(cranberry)
		graphregion(color(none))
		) 
	(connected rate_less_hispanic year, 
		lpattern(solid) lcolor(sand) lwidth(medium) msymbol(t) mcolor(sand)
		graphregion(color(none))
		) 
	(connected rate_less_white year, 
		lpattern(solid) lcolor(lavender) lwidth(medium) msymbol(d) mcolor(lavender)
		graphregion(color(none))
		)
		
		(rcap lb_less_asian ub_less_asian year, lwidth(thin) lpattern(solid) lcolor(midgreen))
		(rcap lb_less_black ub_less_black year, lwidth(thin) lpattern(solid) lcolor(cranberry))
		(rcap lb_less_hispanic ub_less_hispanic year, lwidth(thin) lpattern(solid) lcolor(sand))
		(rcap lb_less_white ub_less_white year, lwidth(thin) lpattern(solid) lcolor(lavender))
		,
		
		
	xlabel(2004(1)2018) xtitle("Year of interview", size(small)) 
	xlabel(, labsize(vsmall) angle(forty_five) valuelabel nogrid) 
	ylabel(`myla', angle(horizontal)) ytitle("Estimated percent reporting fewer than 7 hours of sleep", size(small))
	subtitle("", size(small)) 
	legend(
		label(1 "Asian") 
		label(2 "Black") 
		label(3 "Latino/Hispanic") 
		label(4 "White")
		order(1 "Asian" 2 "Black" 3 "Latino/Hispanic" 4 "White")
		size(small) position(11) ring(0) col(2)
		region(fcolor(white)) bmargin(small) 
		title(""))
	xsize(8) ysize(5)
	scheme(plotplainblind) 
	;
graph save figure_less_sleep_year, replace ;
graph export figure_less_sleep_year.jpg, as(jpg) name("Graph") quality(100) replace ;
graph export figure_less_sleep_year.eps, as(eps) name("Graph") preview(off)replace ;

#delimit cr

**#					1.2 Long sleep duration
#delimit ;
 mylabels 0(2)20, myscale(@/100) local(myla) ;

twoway 
	(connected rate_long_asian year, 
		lpattern(solid) lcolor(midgreen) lwidth(medium) msymbol(o) mcolor(midgreen)
		graphregion(color(none))
		) 
	(connected rate_long_black year, 
		lpattern(solid) lcolor(cranberry) lwidth(medium) msymbol(s) mcolor(cranberry)
		graphregion(color(none))
		) 
	(connected rate_long_hispanic year, 
		lpattern(solid) lcolor(sand) lwidth(medium) msymbol(t) mcolor(sand)
		graphregion(color(none))
		) 
	(connected rate_long_white year, 
		lpattern(solid) lcolor(lavender) lwidth(medium) msymbol(d) mcolor(lavender)
		graphregion(color(none))
		)
		
		(rcap lb_long_asian ub_long_asian year, lwidth(thin) lpattern(solid) lcolor(midgreen))
		(rcap lb_long_black ub_long_black year, lwidth(thin) lpattern(solid) lcolor(cranberry))
		(rcap lb_long_hispanic ub_long_hispanic year, lwidth(thin) lpattern(solid) lcolor(sand))
		(rcap lb_long_white ub_long_white year, lwidth(thin) lpattern(solid) lcolor(lavender))
		,
		
		
	xlabel(2004(1)2018) xtitle("Year of interview", size(small)) 
	xlabel(, labsize(vsmall) angle(forty_five) valuelabel nogrid) 
	ylabel(`myla', angle(horizontal)) ytitle("Estimated percent reporting more than 9 hours of sleep", size(small))
	subtitle("", size(small)) 
	legend(
		label(1 "Asian") 
		label(2 "Black") 
		label(3 "Latino/Hispanic") 
		label(4 "White")
		order(1 "Asian" 2 "Black" 3 "Latino/Hispanic" 4 "White")
		size(small) position(11) ring(0) col(2)
		region(fcolor(white)) bmargin(small) 
		title(""))
	xsize(8) ysize(5)
	scheme(plotplainblind) 
	;
graph save figure_long_sleep_year, replace ;
graph export figure_long_sleep_year.jpg, as(jpg) name("Graph") quality(100) replace ;
graph export figure_long_sleep_year.eps, as(eps) name("Graph") preview(off)replace ;

#delimit cr

**#				2. By sex/gender
**#					2.1 Short sleep duration

u ratefile_sleep_female.dta, clear
#delimit ;
 mylabels 0(5)50, myscale(@/100) local(myla) ;

twoway 
	(connected rate_less_asian year, 
		lpattern(solid) lcolor(midgreen) lwidth(medium) msymbol(o) mcolor(midgreen)
		graphregion(color(none))
		) 
	(connected rate_less_black year, 
		lpattern(solid) lcolor(cranberry) lwidth(medium) msymbol(s) mcolor(cranberry)
		graphregion(color(none))
		) 
	(connected rate_less_hispanic year, 
		lpattern(solid) lcolor(sand) lwidth(medium) msymbol(t) mcolor(sand)
		graphregion(color(none))
		) 
	(connected rate_less_white year, 
		lpattern(solid) lcolor(lavender) lwidth(medium) msymbol(d) mcolor(lavender)
		graphregion(color(none))
		)
		
		(rcap lb_less_asian ub_less_asian year, lwidth(thin) lpattern(solid) lcolor(midgreen))
		(rcap lb_less_black ub_less_black year, lwidth(thin) lpattern(solid) lcolor(cranberry))
		(rcap lb_less_hispanic ub_less_hispanic year, lwidth(thin) lpattern(solid) lcolor(sand))
		(rcap lb_less_white ub_less_white year, lwidth(thin) lpattern(solid) lcolor(lavender))
		,
		
		
	xlabel(2004(1)2018) xtitle("Year of interview", size(small)) 
	xlabel(, labsize(vsmall) angle(forty_five) valuelabel nogrid) 
	ylabel(`myla', angle(horizontal)) ytitle("Estimated percent reporting fewer than 7 hours of sleep", size(small))
	subtitle("Women only", size(medium)) 
	legend(
		label(1 "Asian") 
		label(2 "Black") 
		label(3 "Latino/Hispanic") 
		label(4 "White")
		order(1 "Asian" 2 "Black" 3 "Latino/Hispanic" 4 "White")
		size(small) position(11) ring(0) col(2)
		region(fcolor(white)) bmargin(small) 
		title(""))
	xsize(8) ysize(5)
	scheme(plotplainblind) 
	;
graph save figure_less_sleep_female_year, replace ;
graph export figure_less_sleep_female_year.jpg, as(jpg) name("Graph") quality(100) replace ;
graph export figure_less_sleep_female_year.eps, as(eps) name("Graph") preview(off)replace ;


#delimit cr


u ratefile_sleep_male.dta, clear
#delimit ;
 mylabels 0(5)50, myscale(@/100) local(myla) ;

twoway 
	(connected rate_less_asian year, 
		lpattern(solid) lcolor(midgreen) lwidth(medium) msymbol(o) mcolor(midgreen)
		graphregion(color(none))
		) 
	(connected rate_less_black year, 
		lpattern(solid) lcolor(cranberry) lwidth(medium) msymbol(s) mcolor(cranberry)
		graphregion(color(none))
		) 
	(connected rate_less_hispanic year, 
		lpattern(solid) lcolor(sand) lwidth(medium) msymbol(t) mcolor(sand)
		graphregion(color(none))
		) 
	(connected rate_less_white year, 
		lpattern(solid) lcolor(lavender) lwidth(medium) msymbol(d) mcolor(lavender)
		graphregion(color(none))
		)
		
		(rcap lb_less_asian ub_less_asian year, lwidth(thin) lpattern(solid) lcolor(midgreen))
		(rcap lb_less_black ub_less_black year, lwidth(thin) lpattern(solid) lcolor(cranberry))
		(rcap lb_less_hispanic ub_less_hispanic year, lwidth(thin) lpattern(solid) lcolor(sand))
		(rcap lb_less_white ub_less_white year, lwidth(thin) lpattern(solid) lcolor(lavender))
		,
		
		
	xlabel(2004(1)2018) xtitle("Year of interview", size(small)) 
	xlabel(, labsize(vsmall) angle(forty_five) valuelabel nogrid) 
	ylabel(`myla', angle(horizontal)) ytitle("Estimated percent reporting fewer than 7 hours of sleep", size(small))
	subtitle("Men only", size(medium)) 
	legend(
		label(1 "Asian") 
		label(2 "Black") 
		label(3 "Latino/Hispanic") 
		label(4 "White")
		order(1 "Asian" 2 "Black" 3 "Latino/Hispanic" 4 "White")
		size(small) position(11) ring(0) col(2)
		region(fcolor(white)) bmargin(small) 
		title(""))
	xsize(8) ysize(5)
	scheme(plotplainblind) 
	;
graph save figure_less_sleep_male_year, replace ;
graph export figure_less_sleep_male_year.jpg, as(jpg) name("Graph") quality(100) replace ;
graph export figure_less_sleep_male_year.eps, as(eps) name("Graph") preview(off)replace ;

#delimit cr


**#					2.2 Long sleep duration

	
u ratefile_sleep_female.dta, clear
 
#delimit ;
 mylabels 0(2)20, myscale(@/100) local(myla) ;

twoway 
	(connected rate_long_asian year, 
		lpattern(solid) lcolor(midgreen) lwidth(medium) msymbol(o) mcolor(midgreen)
		graphregion(color(none))
		) 
	(connected rate_long_black year, 
		lpattern(solid) lcolor(cranberry) lwidth(medium) msymbol(s) mcolor(cranberry)
		graphregion(color(none))
		) 
	(connected rate_long_hispanic year, 
		lpattern(solid) lcolor(sand) lwidth(medium) msymbol(t) mcolor(sand)
		graphregion(color(none))
		) 
	(connected rate_long_white year, 
		lpattern(solid) lcolor(lavender) lwidth(medium) msymbol(d) mcolor(lavender)
		graphregion(color(none))
		)
		
		(rcap lb_long_asian ub_long_asian year, lwidth(thin) lpattern(solid) lcolor(midgreen))
		(rcap lb_long_black ub_long_black year, lwidth(thin) lpattern(solid) lcolor(cranberry))
		(rcap lb_long_hispanic ub_long_hispanic year, lwidth(thin) lpattern(solid) lcolor(sand))
		(rcap lb_long_white ub_long_white year, lwidth(thin) lpattern(solid) lcolor(lavender))
		,
		
		
	xlabel(2004(1)2018) xtitle("Year of interview", size(small)) 
	xlabel(, labsize(vsmall) angle(forty_five) valuelabel nogrid) 
	ylabel(`myla', angle(horizontal)) ytitle("Percent reporting more than 9 hours of sleep", size(small))
	subtitle("Women only", size(medium)) 
	legend(
		label(1 "Asian") 
		label(2 "Black") 
		label(3 "Latino/Hispanic") 
		label(4 "White")
		order(1 "Asian" 2 "Black" 3 "Latino/Hispanic" 4 "White")
		size(small) position(11) ring(0) col(2)
		region(fcolor(white)) bmargin(small) 
		title(""))
	xsize(8) ysize(5)
	scheme(plotplainblind) 
	;
graph save figure_long_sleep_female_year, replace ;
graph export figure_long_sleep_female_year.jpg, as(jpg) name("Graph") quality(100) replace ;
graph export figure_long_sleep_female_year.eps, as(eps) name("Graph") preview(off)replace ;

#delimit cr



u ratefile_sleep_male.dta, clear
 
#delimit ;
 mylabels 0(2)20, myscale(@/100) local(myla) ;

twoway 
	(connected rate_long_asian year, 
		lpattern(solid) lcolor(midgreen) lwidth(medium) msymbol(o) mcolor(midgreen)
		graphregion(color(none))
		) 
	(connected rate_long_black year, 
		lpattern(solid) lcolor(cranberry) lwidth(medium) msymbol(s) mcolor(cranberry)
		graphregion(color(none))
		) 
	(connected rate_long_hispanic year, 
		lpattern(solid) lcolor(sand) lwidth(medium) msymbol(t) mcolor(sand)
		graphregion(color(none))
		) 
	(connected rate_long_white year, 
		lpattern(solid) lcolor(lavender) lwidth(medium) msymbol(d) mcolor(lavender)
		graphregion(color(none))
		)
		
		(rcap lb_long_asian ub_long_asian year, lwidth(thin) lpattern(solid) lcolor(midgreen))
		(rcap lb_long_black ub_long_black year, lwidth(thin) lpattern(solid) lcolor(cranberry))
		(rcap lb_long_hispanic ub_long_hispanic year, lwidth(thin) lpattern(solid) lcolor(sand))
		(rcap lb_long_white ub_long_white year, lwidth(thin) lpattern(solid) lcolor(lavender))
		,
		
		
	xlabel(2004(1)2018) xtitle("Year of interview", size(small)) 
	xlabel(, labsize(vsmall) angle(forty_five) valuelabel nogrid) 
	ylabel(`myla', angle(horizontal)) ytitle("Percent reporting more than 9 hours of sleep", size(small))
	subtitle("Men only", size(medium)) 
	legend(
		label(1 "Asian") 
		label(2 "Black") 
		label(3 "Latino/Hispanic") 
		label(4 "White")
		order(1 "Asian" 2 "Black" 3 "Latino/Hispanic" 4 "White")
		size(small) position(11) ring(0) col(2)
		region(fcolor(white)) bmargin(small) 
		title(""))
	xsize(8) ysize(5)
	scheme(plotplainblind) 
	;
graph save figure_long_sleep_male_year, replace ;
graph export figure_long_sleep_male_year.jpg, as(jpg) name("Graph") quality(100) replace ;
graph export figure_long_sleep_male_year.eps, as(eps) name("Graph") preview(off)replace ;

#delimit cr

**#				3. By income level

**#					3.1 Short sleep duration

u ratefile_lowinc,clear

#delimit ;
 mylabels 0(5)50, myscale(@/100) local(myla) ;

twoway 
	(connected rate_less_asian year , 
		lpattern(solid) lcolor(midgreen) msymbol(o) mcolor(midgreen)
		graphregion(color(none))
		) 

		
	(connected rate_less_black year, 
		lpattern(solid) lcolor(cranberry) 
		msymbol(s) mcolor(cranberry)  mlabel()
		graphregion(color(none))
		) 

		
	(connected rate_less_hispanic year, 
		lpattern(solid) lcolor(sand) msymbol(t) mcolor(sand)
		graphregion(color(none))
		) 

		
	(connected rate_less_white year, 
		lpattern(solid) lcolor(lavender) msymbol(d) mcolor(lavender)
		graphregion(color(none))
		)
		

	(rcap lb_less_asian ub_less_asian year , lwidth(thin) lpattern(solid) lcolor(midgreen))
	(rcap lb_less_black ub_less_black year , lwidth(thin) lpattern(solid) lcolor(cranberry))
	(rcap lb_less_hispanic ub_less_hispanic year , lwidth(thin) lpattern(solid) lcolor(sand))
	(rcap lb_less_white ub_less_white year , lwidth(thin) lpattern(solid) lcolor(lavender))
	

		,		

	xlabel(2004(1)2018) xtitle("Year of interview", size(small)) 
	xlabel(, labsize(vsmall) angle(h) valuelabel nogrid) 
	ylabel(`myla', angle(horizontal)) ytitle("Percent reporting fewer than 7 hours of sleep", size(small))
	subtitle("Low-income only", size(medium)) 
	legend(
		label(1 "Asian") 
		label(2 "Black") 
		label(3 "Latino/Hispanic") 
		label(4 "White")
		order(1 "Asian" 2 "Black" 3 "Latino/Hispanic" 4 "White" )
		size(vsmall) position(11) ring(0)
		region(fcolor(white)) bmargin(small) col(2)
		title("")) 
	xsize(8) ysize(5)
	scheme(plotplainblind) 
	;

graph save figure_less_sleep_year_low-income.gph,replace ; 
graph export figure_less_sleep_year_low-income.jpg, as(jpg) name("Graph") quality(100) replace ; 
graph export figure_less_sleep_year_low-income.eps, as(eps) name("Graph") preview(off)replace ; 

#delimit cr


u ratefile_midhighinc,clear

#delimit ;
 mylabels 0(5)50, myscale(@/100) local(myla) ;

twoway 
	(connected rate_less_asian year , 
		lpattern(solid) lcolor(midgreen) msymbol(o) mcolor(midgreen)
		graphregion(color(none))
		) 

		
	(connected rate_less_black year, 
		lpattern(solid) lcolor(cranberry) 
		msymbol(s) mcolor(cranberry)  mlabel()
		graphregion(color(none))
		) 

		
	(connected rate_less_hispanic year, 
		lpattern(solid) lcolor(sand) msymbol(t) mcolor(sand)
		graphregion(color(none))
		) 

		
	(connected rate_less_white year, 
		lpattern(solid) lcolor(lavender) msymbol(d) mcolor(lavender)
		graphregion(color(none))
		)
		

	(rcap lb_less_asian ub_less_asian year , lwidth(thin) lpattern(solid) lcolor(midgreen))
	(rcap lb_less_black ub_less_black year , lwidth(thin) lpattern(solid) lcolor(cranberry))
	(rcap lb_less_hispanic ub_less_hispanic year , lwidth(thin) lpattern(solid) lcolor(sand))
	(rcap lb_less_white ub_less_white year , lwidth(thin) lpattern(solid) lcolor(lavender))
	

		,		

	xlabel(2004(1)2018) xtitle("Year of interview", size(small)) 
	xlabel(, labsize(vsmall) angle(h) valuelabel nogrid) 
	ylabel(`myla', angle(horizontal)) ytitle("Percent reporting fewer than 7 hours of sleep", size(small))
	subtitle("Middle/high-income only", size(medium)) 
	legend(
		label(1 "Asian") 
		label(2 "Black") 
		label(3 "Latino/Hispanic") 
		label(4 "White")
		order(1 "Asian" 2 "Black" 3 "Latino/Hispanic" 4 "White" )
		size(vsmall) position(11) ring(0)
		region(fcolor(white)) bmargin(small) col(2)
		title("")) 
	xsize(8) ysize(5)
	scheme(plotplainblind) 
	;

graph save figure_less_sleep_year_midhigh-income.gph,replace ; 
graph export figure_less_sleep_year_midhigh-income.jpg, as(jpg) name("Graph") quality(100) replace ;
graph export figure_less_sleep_year_midhigh-income.eps, as(eps) name("Graph") preview(off)replace ; 

#delimit cr

**#					3.2 Long sleep duration


u ratefile_lowinc,clear

#delimit ;
 mylabels 0(2)20, myscale(@/100) local(myla) ;

twoway 
	(connected rate_long_asian year , 
		lpattern(solid) lcolor(midgreen) msymbol(o) mcolor(midgreen)
		graphregion(color(none))
		) 

		
	(connected rate_long_black year, 
		lpattern(solid) lcolor(cranberry) 
		msymbol(s) mcolor(cranberry)  mlabel()
		graphregion(color(none))
		) 

		
	(connected rate_long_hispanic year, 
		lpattern(solid) lcolor(sand) msymbol(t) mcolor(sand)
		graphregion(color(none))
		) 

		
	(connected rate_long_white year, 
		lpattern(solid) lcolor(lavender) msymbol(d) mcolor(lavender)
		graphregion(color(none))
		)
		

	(rcap lb_long_asian ub_long_asian year , lwidth(thin) lpattern(solid) lcolor(midgreen))
	(rcap lb_long_black ub_long_black year , lwidth(thin) lpattern(solid) lcolor(cranberry))
	(rcap lb_long_hispanic ub_long_hispanic year , lwidth(thin) lpattern(solid) lcolor(sand))
	(rcap lb_long_white ub_long_white year , lwidth(thin) lpattern(solid) lcolor(lavender))
	

		,		

	xlabel(2004(1)2018) xtitle("Year of interview", size(small)) 
	xlabel(, labsize(vsmall) angle(h) valuelabel nogrid) 
	ylabel(`myla', angle(horizontal)) ytitle("Percent reporting more than 9 hours of sleep", size(small))
	subtitle("Low-income only", size(medium)) 
	legend(
		label(1 "Asian") 
		label(2 "Black") 
		label(3 "Latino/Hispanic") 
		label(4 "White")
		order(1 "Asian" 2 "Black" 3 "Latino/Hispanic" 4 "White" )
		size(vsmall) position(11) ring(0)
		region(fcolor(white)) bmargin(small) col(2)
		title("")) 
	xsize(8) ysize(5)
	scheme(plotplainblind) 
	;

graph save figure_long_sleep_year_low-income.gph,replace ; 
graph export figure_long_sleep_year_low-income.jpg, as(jpg) name("Graph") quality(100) replace ; 
graph export figure_long_sleep_year_low-income.eps, as(eps) name("Graph") preview(off)replace ; 

#delimit cr


u ratefile_midhighinc,clear

#delimit ;
 mylabels 0(2)20, myscale(@/100) local(myla) ;

twoway 
	(connected rate_long_asian year , 
		lpattern(solid) lcolor(midgreen) msymbol(o) mcolor(midgreen)
		graphregion(color(none))
		) 

		
	(connected rate_long_black year, 
		lpattern(solid) lcolor(cranberry) 
		msymbol(s) mcolor(cranberry)  mlabel()
		graphregion(color(none))
		) 

		
	(connected rate_long_hispanic year, 
		lpattern(solid) lcolor(sand) msymbol(t) mcolor(sand)
		graphregion(color(none))
		) 

		
	(connected rate_long_white year, 
		lpattern(solid) lcolor(lavender) msymbol(d) mcolor(lavender)
		graphregion(color(none))
		)
		

	(rcap lb_long_asian ub_long_asian year , lwidth(thin) lpattern(solid) lcolor(midgreen))
	(rcap lb_long_black ub_long_black year , lwidth(thin) lpattern(solid) lcolor(cranberry))
	(rcap lb_long_hispanic ub_long_hispanic year , lwidth(thin) lpattern(solid) lcolor(sand))
	(rcap lb_long_white ub_long_white year , lwidth(thin) lpattern(solid) lcolor(lavender))
	

		,		

	xlabel(2004(1)2018) xtitle("Year of interview", size(small)) 
	xlabel(, labsize(vsmall) angle(h) valuelabel nogrid) 
	ylabel(`myla', angle(horizontal)) ytitle("Percent reporting more than 9 hours of sleep", size(small))
	subtitle("Middle/high-income only", size(medium)) 
	legend(
		label(1 "Asian") 
		label(2 "Black") 
		label(3 "Latino/Hispanic") 
		label(4 "White")
		order(1 "Asian" 2 "Black" 3 "Latino/Hispanic" 4 "White" )
		size(vsmall) position(11) ring(0)
		region(fcolor(white)) bmargin(small) col(2)
		title("")) 
	xsize(8) ysize(5)
	scheme(plotplainblind) 
	;

graph save figure_long_sleep_year_midhigh-income.gph,replace ; 
graph export figure_long_sleep_year_midhigh-income.jpg, as(jpg) name("Graph") quality(100) replace ; 
graph export figure_long_sleep_year_midhigh-income.eps, as(eps) name("Graph") preview(off)replace ; 
#delimit cr

**#				4. By health status

**#					4.1 Short sleep duration


u ratefile_sleep_poorhealth.dta, clear
 
#delimit ;
 mylabels 0(5)70, myscale(@/100) local(myla) ;

twoway 
	(connected rate_less_asian year, 
		lpattern(solid) lcolor(midgreen) lwidth(medium) msymbol(o) mcolor(midgreen)
		graphregion(color(none))
		) 
	(connected rate_less_black year, 
		lpattern(solid) lcolor(cranberry) lwidth(medium) msymbol(s) mcolor(cranberry)
		graphregion(color(none))
		) 
	(connected rate_less_hispanic year, 
		lpattern(solid) lcolor(sand) lwidth(medium) msymbol(t) mcolor(sand)
		graphregion(color(none))
		) 
	(connected rate_less_white year, 
		lpattern(solid) lcolor(lavender) lwidth(medium) msymbol(d) mcolor(lavender)
		graphregion(color(none))
		)
		
		(rcap lb_less_asian ub_less_asian year, lwidth(thin) lpattern(solid) lcolor(midgreen))
		(rcap lb_less_black ub_less_black year, lwidth(thin) lpattern(solid) lcolor(cranberry))
		(rcap lb_less_hispanic ub_less_hispanic year, lwidth(thin) lpattern(solid) lcolor(sand))
		(rcap lb_less_white ub_less_white year, lwidth(thin) lpattern(solid) lcolor(lavender))
		,
		
		
	xlabel(2004(1)2018) xtitle("Year of interview", size(small)) 
	xlabel(, labsize(vsmall) angle(forty_five) valuelabel nogrid) 
	ylabel(`myla', angle(horizontal)) ytitle("Estimated percent reporting fewer than 7 hours of sleep", size(small))
	subtitle("Poor or fair health only", size(medium)) 
	legend(
		label(1 "Asian") 
		label(2 "Black") 
		label(3 "Latino/Hispanic") 
		label(4 "White")
		order(1 "Asian" 2 "Black" 3 "Latino/Hispanic" 4 "White")
		size(small) position(11) ring(0) col(2)
		region(fcolor(white)) bmargin(small) 
		title(""))
	xsize(8) ysize(5)
	scheme(plotplainblind) 
	;
graph save figure_less_sleep_poor_health_year, replace ;
graph export figure_less_sleep_poor_health_year.jpg, as(jpg) name("Graph") quality(100) replace ;
graph export figure_less_sleep_poor_health_year.eps, as(eps) name("Graph") preview(off)replace ;

#delimit cr

***********

u ratefile_sleep_goodhealth.dta, clear
 
#delimit ;
 mylabels 0(5)70, myscale(@/100) local(myla) ;

twoway 
	(connected rate_less_asian year, 
		lpattern(solid) lcolor(midgreen) lwidth(medium) msymbol(o) mcolor(midgreen)
		graphregion(color(none))
		) 
	(connected rate_less_black year, 
		lpattern(solid) lcolor(cranberry) lwidth(medium) msymbol(s) mcolor(cranberry)
		graphregion(color(none))
		) 
	(connected rate_less_hispanic year, 
		lpattern(solid) lcolor(sand) lwidth(medium) msymbol(t) mcolor(sand)
		graphregion(color(none))
		) 
	(connected rate_less_white year, 
		lpattern(solid) lcolor(lavender) lwidth(medium) msymbol(d) mcolor(lavender)
		graphregion(color(none))
		)
		
		(rcap lb_less_asian ub_less_asian year, lwidth(thin) lpattern(solid) lcolor(midgreen))
		(rcap lb_less_black ub_less_black year, lwidth(thin) lpattern(solid) lcolor(cranberry))
		(rcap lb_less_hispanic ub_less_hispanic year, lwidth(thin) lpattern(solid) lcolor(sand))
		(rcap lb_less_white ub_less_white year, lwidth(thin) lpattern(solid) lcolor(lavender))
		,
		
		
	xlabel(2004(1)2018) xtitle("Year of interview", size(small)) 
	xlabel(, labsize(vsmall) angle(forty_five) valuelabel nogrid) 
	ylabel(`myla', angle(horizontal)) ytitle("Estimated percent reporting fewer than 7 hours of sleep", size(small))
	subtitle("Good to excellent health only", size(medium)) 
	legend(
		label(1 "Asian") 
		label(2 "Black") 
		label(3 "Latino/Hispanic") 
		label(4 "White")
		order(1 "Asian" 2 "Black" 3 "Latino/Hispanic" 4 "White")
		size(small) position(11) ring(0) col(2)
		region(fcolor(white)) bmargin(small) 
		title(""))
	xsize(8) ysize(5)
	scheme(plotplainblind) 
	;
graph save figure_less_sleep_good_health_year, replace ;
graph export figure_less_sleep_good_health_year.jpg, as(jpg) name("Graph") quality(100) replace ;
graph export figure_less_sleep_good_health_year.eps, as(eps) name("Graph") preview(off)replace ;

#delimit cr

**#					4.2 Long sleep duration


u ratefile_sleep_poorhealth.dta, clear
 
#delimit ;
 mylabels 0(2)20, myscale(@/100) local(myla) ;

twoway 
	(connected rate_long_asian year, 
		lpattern(solid) lcolor(midgreen) lwidth(medium) msymbol(o) mcolor(midgreen)
		graphregion(color(none))
		) 
	(connected rate_long_black year, 
		lpattern(solid) lcolor(cranberry) lwidth(medium) msymbol(s) mcolor(cranberry)
		graphregion(color(none))
		) 
	(connected rate_long_hispanic year, 
		lpattern(solid) lcolor(sand) lwidth(medium) msymbol(t) mcolor(sand)
		graphregion(color(none))
		) 
	(connected rate_long_white year, 
		lpattern(solid) lcolor(lavender) lwidth(medium) msymbol(d) mcolor(lavender)
		graphregion(color(none))
		)
		
		(rcap lb_long_asian ub_long_asian year, lwidth(thin) lpattern(solid) lcolor(midgreen))
		(rcap lb_long_black ub_long_black year, lwidth(thin) lpattern(solid) lcolor(cranberry))
		(rcap lb_long_hispanic ub_long_hispanic year, lwidth(thin) lpattern(solid) lcolor(sand))
		(rcap lb_long_white ub_long_white year, lwidth(thin) lpattern(solid) lcolor(lavender))
		,
		
		
	xlabel(2004(1)2018) xtitle("Year of interview", size(small)) 
	xlabel(, labsize(vsmall) angle(forty_five) valuelabel nogrid) 
	ylabel(`myla', angle(horizontal)) ytitle("Percent reporting more than 9 hours of sleep", size(small))
	subtitle("Poor or fair health only", size(medium)) 
	legend(
		label(1 "Asian") 
		label(2 "Black") 
		label(3 "Latino/Hispanic") 
		label(4 "White")
		order(1 "Asian" 2 "Black" 3 "Latino/Hispanic" 4 "White")
		size(small) position(11) ring(0) col(2)
		region(fcolor(white)) bmargin(small) 
		title(""))
	xsize(8) ysize(5)
	scheme(plotplainblind) 
	;
graph save figure_long_sleep_poor_health_year, replace ;
graph export figure_long_sleep_poor_health_year.jpg, as(jpg) name("Graph") quality(100) replace ;
graph export figure_long_sleep_poor_health_year.eps, as(eps) name("Graph") preview(off)replace ;

#delimit cr



u ratefile_sleep_goodhealth.dta, clear
 
#delimit ;
 mylabels 0(2)20, myscale(@/100) local(myla) ;

twoway 
	(connected rate_long_asian year, 
		lpattern(solid) lcolor(midgreen) lwidth(medium) msymbol(o) mcolor(midgreen)
		graphregion(color(none))
		) 
	(connected rate_long_black year, 
		lpattern(solid) lcolor(cranberry) lwidth(medium) msymbol(s) mcolor(cranberry)
		graphregion(color(none))
		) 
	(connected rate_long_hispanic year, 
		lpattern(solid) lcolor(sand) lwidth(medium) msymbol(t) mcolor(sand)
		graphregion(color(none))
		) 
	(connected rate_long_white year, 
		lpattern(solid) lcolor(lavender) lwidth(medium) msymbol(d) mcolor(lavender)
		graphregion(color(none))
		)
		
		(rcap lb_long_asian ub_long_asian year, lwidth(thin) lpattern(solid) lcolor(midgreen))
		(rcap lb_long_black ub_long_black year, lwidth(thin) lpattern(solid) lcolor(cranberry))
		(rcap lb_long_hispanic ub_long_hispanic year, lwidth(thin) lpattern(solid) lcolor(sand))
		(rcap lb_long_white ub_long_white year, lwidth(thin) lpattern(solid) lcolor(lavender))
		,
		
		
	xlabel(2004(1)2018) xtitle("Year of interview", size(small)) 
	xlabel(, labsize(vsmall) angle(forty_five) valuelabel nogrid) 
	ylabel(`myla', angle(horizontal)) ytitle("Percent reporting more than 9 hours of sleep", size(small))
	subtitle("Good to excellent health only", size(medium)) 
	legend(
		label(1 "Asian") 
		label(2 "Black") 
		label(3 "Latino/Hispanic") 
		label(4 "White")
		order(1 "Asian" 2 "Black" 3 "Latino/Hispanic" 4 "White")
		size(small) position(11) ring(0) col(2)
		region(fcolor(white)) bmargin(small) 
		title(""))
	xsize(8) ysize(5)
	scheme(plotplainblind) 
	;
graph save figure_long_sleep_good_health_year, replace ;
graph export figure_long_sleep_good_health_year.jpg, as(jpg) name("Graph") quality(100) replace ;
graph export figure_long_sleep_good_health_year.eps, as(eps) name("Graph") preview(off)replace ;

#delimit cr
