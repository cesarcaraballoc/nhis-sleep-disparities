
/* 

			Temporal Trends in Racial and Ethnic Disparities in Sleep 
				Duration in the United States, 2004–2018

César Caraballo, Shiwani Mahajan, Javier Valero-Elizondo, Daisy Massey, Yuan Lu,
Brita Roy, Carley Riley, Amarnath R. Annapureddy, Karthik Murugiah, Johanna Elumn,
Khurram Nasir, Marcella Nunez-Smith, Howard P. Forman, Chandra L. Jackson, 
Jeph Herrin, Harlan M. Krumholz

medRxiv 2021.10.31.21265202

Available from: https://doi.org/10.1101/2021.10.31.21265202

			
	Age prevalence and differences figures
	
	This .do file produces the age figures. 
	
	
	Table of contents
			1. Overall
				1.1 Short sleep duration
				1.2 Long sleep duration
			2. By sex/gender
				2.1 Short sleep duration
					2.1.1 Females only
					2.1.2 Males only
				2.2 Long sleep duration
					2.2.1 Females only
					2.2.2 Males only
			3. By income level
				3.1 Short sleep duration
					3.1.1 Low-income only
					3.1.2 Mid/high-income only
				3.2 Long sleep duration
					3.2.1 Low-income only
					3.2.2 Mid/high-income only

*/

**#			1. Overall

use ratefile_sleep_age_all,clear
label var age_group "Age group, (years)"
label define age_group 1 "18-24" 2 "25-29" 3 "30-34" 4 "35-39" 5 "40-44" 6 "45-49" 7 "50-54" 8 "55-59" 9 "60-64" 10 "65-69" 11 "70-74" 12 "75-79" 13 ">=80"
label value age_group age_group

**#				1.1 Short sleep duration

#delimit ;
 mylabels 0(5)50, myscale(@/100) local(myla) ;

twoway 
	(connected rate_less_asian age_group, lpattern(solid) lcolor(midgreen) msymbol(o) mcolor(midgreen)) 
	(connected rate_less_black age_group, lpattern(solid) lcolor(cranberry) msymbol(s) mcolor(cranberry)) 
	(connected rate_less_hispanic age_group, lpattern(solid) lcolor(sand) msymbol(t) mcolor(sand)) 
	(connected rate_less_white age_group, lpattern(solid) lcolor(lavender) msymbol(d) mcolor(lavender))
	
	(rcap lb_less_asian ub_less_asian age_group, lwidth(thin) lpattern(solid) lcolor(midgreen))
	(rcap lb_less_black ub_less_black age_group, lwidth(thin) lpattern(solid) lcolor(cranberry))
	(rcap lb_less_hispanic ub_less_hispanic age_group, lwidth(thin) lpattern(solid) lcolor(sand))
	(rcap lb_less_white ub_less_white age_group, lwidth(thin) lpattern(solid) lcolor(lavender)), 
	
	
	xlabel(1(1)13) xtitle("Age group (years)", size(vsmall)) 
	xlabel(, labsize(vsmall) angle(forty_five) valuelabel) 
	ylabel(`myla', angle(horizontal)) ytitle("Percent reporting fewer than 7 hours of sleep", size(small))
	subtitle("", size(vsmall)) 
	legend(
		label(1 "Asian") 
		label(2 "Black") 
		label(3 "Latino/Hispanic") 
		label(4 "White") 
		order(1 "Asian" 2 "Black" 3 "Latino/Hispanic" 4 "White")
		size(small) position(1) ring(0) 
		region(fcolor(white%30)) bmargin(small) 
		title("")) 
	xsize(5) ysize(4)
	scheme(plotplainblind) 
	;
graph save figure_less_sleep_age, replace;
graph export figure_less_sleep_age.jpg, as(jpg) name("Graph") quality(100) replace ;
graph export figure_less_sleep_age.eps, as(eps) name("Graph") preview(off) replace ;

#delimit cr


#delimit ;
 mylabels -20(5)20, myscale(@/100) local(myla) ;

twoway 
	(connected diff_less_asian age_group, lpattern(solid) lcolor(midgreen) msymbol(o) mcolor(midgreen)) 
	(connected diff_less_black age_group, lpattern(solid) lcolor(cranberry) msymbol(s) mcolor(cranberry)) 
	(connected diff_less_hisp age_group, lpattern(solid) lcolor(sand) msymbol(t) mcolor(sand)) 
	
	(rcap diff_less_asian_lb diff_less_asian_ub age_group, lwidth(thin) lpattern(solid) lcolor(midgreen))
	(rcap diff_less_black_lb diff_less_black_ub age_group, lwidth(thin) lpattern(solid) lcolor(cranberry))
	(rcap diff_less_hisp_lb diff_less_hisp_ub age_group, lwidth(thin) lpattern(solid) lcolor(sand))

	
	, 
	
	
	xlabel(1(1)13) xtitle("Age group (years)", size(vsmall)) 
	xlabel(, labsize(vsmall) angle(forty_five) valuelabel) 
	yline(0, lpattern(solid) lwidth(thin) lcolor(lavender))
	ylabel(`myla', angle(horizontal)) ytitle("Percent reporting fewer than 7 hours of sleep", size(small))
	subtitle("", size(vsmall)) 
	legend(
		order(1 "Asian difference with White" 2 "Black difference with White" 3 "Latino/Hispanic difference with White")
		size(vsmall) position(5) ring(0) 
		region(fcolor(white%30)) bmargin(small) 
		title("")) 
	xsize(5) ysize(4)
	scheme(plotplainblind) 
	;
graph save figure_less_sleep_age_diff, replace;
graph export figure_less_sleep_age_diff.jpg, as(jpg) name("Graph") quality(100) replace ;
graph export figure_less_sleep_age_diff.eps, as(eps) name("Graph") preview(off) replace ;

#delimit cr
	
**#				1.2 Long sleep duration


#delimit ;
 mylabels 0(5)50, myscale(@/100) local(myla) ;

twoway 
	(connected rate_long_asian age_group, lpattern(solid) lcolor(midgreen) msymbol(o) mcolor(midgreen)) 
	(connected rate_long_black age_group, lpattern(solid) lcolor(cranberry) msymbol(s) mcolor(cranberry)) 
	(connected rate_long_hispanic age_group, lpattern(solid) lcolor(sand) msymbol(t) mcolor(sand)) 
	(connected rate_long_white age_group, lpattern(solid) lcolor(lavender) msymbol(d) mcolor(lavender))
	
	(rcap lb_long_asian ub_long_asian age_group, lwidth(thin) lpattern(solid) lcolor(midgreen))
	(rcap lb_long_black ub_long_black age_group, lwidth(thin) lpattern(solid) lcolor(cranberry))
	(rcap lb_long_hispanic ub_long_hispanic age_group, lwidth(thin) lpattern(solid) lcolor(sand))
	(rcap lb_long_white ub_long_white age_group, lwidth(thin) lpattern(solid) lcolor(lavender)), 
	
	
	xlabel(1(1)13) xtitle("Age group (years)", size(vsmall)) 
	xlabel(, labsize(vsmall) angle(forty_five) valuelabel) 
	ylabel(`myla', angle(horizontal)) ytitle("Percent reporting more than 9 hours of sleep", size(small))
	subtitle("", size(vsmall)) 
	legend(
		label(1 "Asian") 
		label(2 "Black") 
		label(3 "Latino/Hispanic") 
		label(4 "White") 
		order(1 "Asian" 2 "Black" 3 "Latino/Hispanic" 4 "White")
		size(small) position(1) ring(0) 
		region(fcolor(white%30)) bmargin(small) 
		title("")) 
	xsize(5) ysize(4)
	scheme(plotplainblind) 
	;
graph save figure_long_sleep_age, replace;
graph export figure_long_sleep_age.jpg, as(jpg) name("Graph") quality(100) replace ;
graph export figure_long_sleep_age.eps, as(eps) name("Graph") preview(off) replace ;

#delimit cr
	

#delimit ;
 mylabels -20(5)20, myscale(@/100) local(myla) ;

twoway 
	(connected diff_long_asian age_group, lpattern(solid) lcolor(midgreen) msymbol(o) mcolor(midgreen)) 
	(connected diff_long_black age_group, lpattern(solid) lcolor(cranberry) msymbol(s) mcolor(cranberry)) 
	(connected diff_long_hisp age_group, lpattern(solid) lcolor(sand) msymbol(t) mcolor(sand)) 
	
	(rcap diff_long_asian_lb diff_long_asian_ub age_group, lwidth(thin) lpattern(solid) lcolor(midgreen))
	(rcap diff_long_black_lb diff_long_black_ub age_group, lwidth(thin) lpattern(solid) lcolor(cranberry))
	(rcap diff_long_hisp_lb diff_long_hisp_ub age_group, lwidth(thin) lpattern(solid) lcolor(sand))

	
	, 
	
	
	xlabel(1(1)13) xtitle("Age group (years)", size(vsmall)) 
	xlabel(, labsize(vsmall) angle(forty_five) valuelabel) 
	yline(0, lpattern(solid) lwidth(thin) lcolor(lavender))
	ylabel(`myla', angle(horizontal)) ytitle("Percent reporting more than 9 hours of sleep", size(small))
	subtitle("", size(vsmall)) 
	legend(
		order(1 "Asian difference with White" 2 "Black difference with White" 3 "Latino/Hispanic difference with White")
		size(vsmall) position(5) ring(0) 
		region(fcolor(white%30)) bmargin(small) 
		title("")) 
	xsize(5) ysize(4)
	scheme(plotplainblind) 
	;
graph save figure_long_sleep_age_diff, replace;
graph export figure_long_sleep_age_diff.jpg, as(jpg) name("Graph") quality(100) replace ;
graph export figure_long_sleep_age_diff.eps, as(eps) name("Graph") preview(off) replace ;
#delimit cr


**#			2. By sex/gender

**#				2.1 Short sleep duration

**#					2.1.1 Females only

u ratefile_sleep_age_female,clear
	
label var age_group "Age group, (years)"
label define age_group 1 "18-24" 2 "25-29" 3 "30-34" 4 "35-39" 5 "40-44" 6 "45-49" 7 "50-54" 8 "55-59" 9 "60-64" 10 "65-69" 11 "70-74" 12 "75-79" 13 ">=80"
label value age_group age_group

#delimit ;
 mylabels 0(5)50, myscale(@/100) local(myla) ;

twoway 
	(connected rate_less_asian age_group, lpattern(solid) lcolor(midgreen) msymbol(o) mcolor(midgreen)) 
	(connected rate_less_black age_group, lpattern(solid) lcolor(cranberry) msymbol(s) mcolor(cranberry)) 
	(connected rate_less_hispanic age_group, lpattern(solid) lcolor(sand) msymbol(t) mcolor(sand)) 
	(connected rate_less_white age_group, lpattern(solid) lcolor(lavender) msymbol(d) mcolor(lavender))
	
	(rcap lb_less_asian ub_less_asian age_group, lwidth(thin) lpattern(solid) lcolor(midgreen))
	(rcap lb_less_black ub_less_black age_group, lwidth(thin) lpattern(solid) lcolor(cranberry))
	(rcap lb_less_hispanic ub_less_hispanic age_group, lwidth(thin) lpattern(solid) lcolor(sand))
	(rcap lb_less_white ub_less_white age_group, lwidth(thin) lpattern(solid) lcolor(lavender)), 
	
	
	xlabel(1(1)13) xtitle("Age group (years)", size(vsmall)) 
	xlabel(, labsize(vsmall) angle(forty_five) valuelabel) 
	ylabel(`myla', angle(horizontal)) ytitle("Percent reporting fewer than 7 hours of sleep", size(small))
	subtitle("Women only", size(medium)) 
	legend(off)
	xsize(5) ysize(4)
	scheme(plotplainblind) 
	;
graph save figure_less_sleep_age_female, replace;
graph export figure_less_sleep_age_female.jpg, as(jpg) name("Graph") quality(100) replace ;
graph export figure_less_sleep_age_female.eps, as(eps) name("Graph") preview(off) replace ;
#delimit cr

#delimit ;
 mylabels -20(5)20, myscale(@/100) local(myla) ;

twoway 
	(connected diff_less_asian age_group, lpattern(solid) lcolor(midgreen) msymbol(o) mcolor(midgreen)) 
	(connected diff_less_black age_group, lpattern(solid) lcolor(cranberry) msymbol(s) mcolor(cranberry)) 
	(connected diff_less_hisp age_group, lpattern(solid) lcolor(sand) msymbol(t) mcolor(sand)) 
	
	(rcap diff_less_asian_lb diff_less_asian_ub age_group, lwidth(thin) lpattern(solid) lcolor(midgreen))
	(rcap diff_less_black_lb diff_less_black_ub age_group, lwidth(thin) lpattern(solid) lcolor(cranberry))
	(rcap diff_less_hisp_lb diff_less_hisp_ub age_group, lwidth(thin) lpattern(solid) lcolor(sand))

	
	, 
	
	
	xlabel(1(1)13) xtitle("Age group (years)", size(vsmall)) 
	xlabel(, labsize(vsmall) angle(forty_five) valuelabel) 
	yline(0, lpattern(solid) lwidth(thin) lcolor(lavender))
	ylabel(`myla', angle(horizontal)) ytitle("Percent reporting fewer than 7 hours of sleep", size(small))
	subtitle("Women only", size(medium)) 
	legend(
		order(1 "Asian difference with White" 2 "Black difference with White" 3 "Latino/Hispanic difference with White")
		size(vsmall) position(5) ring(0) 
		region(fcolor(white%30)) bmargin(small) 
		title("")) 
	xsize(5) ysize(4)
	scheme(plotplainblind) 
	;
graph save figure_less_sleep_age_diff_less_female, replace;
graph export figure_less_sleep_age_diff_less_female.jpg, as(jpg) name("Graph") quality(100) replace ;
graph export figure_less_sleep_age_diff_less_female.eps, as(eps) name("Graph") preview(off) replace ;
#delimit cr

**#					2.1.2 Males only

u ratefile_sleep_age_male,clear
	
label var age_group "Age group, (years)"
label define age_group 1 "18-24" 2 "25-29" 3 "30-34" 4 "35-39" 5 "40-44" 6 "45-49" 7 "50-54" 8 "55-59" 9 "60-64" 10 "65-69" 11 "70-74" 12 "75-79" 13 ">=80"
label value age_group age_group

#delimit ;
 mylabels 0(5)50, myscale(@/100) local(myla) ;

twoway 
	(connected rate_less_asian age_group, lpattern(solid) lcolor(midgreen) msymbol(o) mcolor(midgreen)) 
	(connected rate_less_black age_group, lpattern(solid) lcolor(cranberry) msymbol(s) mcolor(cranberry)) 
	(connected rate_less_hispanic age_group, lpattern(solid) lcolor(sand) msymbol(t) mcolor(sand)) 
	(connected rate_less_white age_group, lpattern(solid) lcolor(lavender) msymbol(d) mcolor(lavender))
	
	(rcap lb_less_asian ub_less_asian age_group, lwidth(thin) lpattern(solid) lcolor(midgreen))
	(rcap lb_less_black ub_less_black age_group, lwidth(thin) lpattern(solid) lcolor(cranberry))
	(rcap lb_less_hispanic ub_less_hispanic age_group, lwidth(thin) lpattern(solid) lcolor(sand))
	(rcap lb_less_white ub_less_white age_group, lwidth(thin) lpattern(solid) lcolor(lavender)), 
	
	
	xlabel(1(1)13) xtitle("Age group (years)", size(vsmall)) 
	xlabel(, labsize(vsmall) angle(forty_five) valuelabel) 
	ylabel(`myla', angle(horizontal)) ytitle("Percent reporting fewer than 7 hours of sleep", size(small))
	subtitle("Men only", size(medium)) 
	legend(off)
	xsize(5) ysize(4)
	scheme(plotplainblind) 
	;
graph save figure_less_sleep_age_male, replace;
graph export figure_less_sleep_age_male.jpg, as(jpg) name("Graph") quality(100) replace ;
graph export figure_less_sleep_age_male.eps, as(eps) name("Graph") preview(off) replace ;
#delimit cr

#delimit ;
 mylabels -20(5)20, myscale(@/100) local(myla) ;

twoway 
	(connected diff_less_asian age_group, lpattern(solid) lcolor(midgreen) msymbol(o) mcolor(midgreen)) 
	(connected diff_less_black age_group, lpattern(solid) lcolor(cranberry) msymbol(s) mcolor(cranberry)) 
	(connected diff_less_hisp age_group, lpattern(solid) lcolor(sand) msymbol(t) mcolor(sand)) 
	
	(rcap diff_less_asian_lb diff_less_asian_ub age_group, lwidth(thin) lpattern(solid) lcolor(midgreen))
	(rcap diff_less_black_lb diff_less_black_ub age_group, lwidth(thin) lpattern(solid) lcolor(cranberry))
	(rcap diff_less_hisp_lb diff_less_hisp_ub age_group, lwidth(thin) lpattern(solid) lcolor(sand))

	
	, 
	
	
	xlabel(1(1)13) xtitle("Age group (years)", size(vsmall)) 
	xlabel(, labsize(vsmall) angle(forty_five) valuelabel) 
	yline(0, lpattern(solid) lwidth(thin) lcolor(lavender))
	ylabel(`myla', angle(horizontal)) ytitle("Percent reporting fewer than 7 hours of sleep", size(small))
	subtitle("Men only", size(medium)) 
	legend(
		order(1 "Asian difference with White" 2 "Black difference with White" 3 "Latino/Hispanic difference with White")
		size(vsmall) position(5) ring(0) 
		region(fcolor(white%30)) bmargin(small) 
		title("")) 
	xsize(5) ysize(4)
	scheme(plotplainblind) 
	;
graph save figure_less_sleep_age_diff_less_male, replace;
graph export figure_less_sleep_age_diff_less_male.jpg, as(jpg) name("Graph") quality(100) replace ;
graph export figure_less_sleep_age_diff_less_male.eps, as(eps) name("Graph") preview(off) replace ;
#delimit cr

**#				2.2 Long sleep duration

**#					2.2.1 Females only

u ratefile_sleep_age_female,clear
	
label var age_group "Age group, (years)"
label define age_group 1 "18-24" 2 "25-29" 3 "30-34" 4 "35-39" 5 "40-44" 6 "45-49" 7 "50-54" 8 "55-59" 9 "60-64" 10 "65-69" 11 "70-74" 12 "75-79" 13 ">=80"
label value age_group age_group

#delimit ;
 mylabels 0(5)50, myscale(@/100) local(myla) ;

twoway 
	(connected rate_long_asian age_group, lpattern(solid) lcolor(midgreen) msymbol(o) mcolor(midgreen)) 
	(connected rate_long_black age_group, lpattern(solid) lcolor(cranberry) msymbol(s) mcolor(cranberry)) 
	(connected rate_long_hispanic age_group, lpattern(solid) lcolor(sand) msymbol(t) mcolor(sand)) 
	(connected rate_long_white age_group, lpattern(solid) lcolor(lavender) msymbol(d) mcolor(lavender))
	
	(rcap lb_long_asian ub_long_asian age_group, lwidth(thin) lpattern(solid) lcolor(midgreen))
	(rcap lb_long_black ub_long_black age_group, lwidth(thin) lpattern(solid) lcolor(cranberry))
	(rcap lb_long_hispanic ub_long_hispanic age_group, lwidth(thin) lpattern(solid) lcolor(sand))
	(rcap lb_long_white ub_long_white age_group, lwidth(thin) lpattern(solid) lcolor(lavender)), 
	
	
	xlabel(1(1)13) xtitle("Age group (years)", size(vsmall)) 
	xlabel(, labsize(vsmall) angle(forty_five) valuelabel) 
	ylabel(`myla', angle(horizontal)) ytitle("Percent reporting more than 9 hours of sleep", size(small))
	subtitle("Women only", size(medium)) 
	legend(off)
	xsize(5) ysize(4)
	scheme(plotplainblind) 
	;
graph save figure_long_sleep_age_female, replace;
graph export figure_long_sleep_age_female.jpg, as(jpg) name("Graph") quality(100) replace ;
graph export figure_long_sleep_age_female.eps, as(eps) name("Graph") preview(off) replace ;
#delimit cr

#delimit ;
 mylabels -20(5)20, myscale(@/100) local(myla) ;

twoway 
	(connected diff_long_asian age_group, lpattern(solid) lcolor(midgreen) msymbol(o) mcolor(midgreen)) 
	(connected diff_long_black age_group, lpattern(solid) lcolor(cranberry) msymbol(s) mcolor(cranberry)) 
	(connected diff_long_hisp age_group, lpattern(solid) lcolor(sand) msymbol(t) mcolor(sand)) 
	
	(rcap diff_long_asian_lb diff_long_asian_ub age_group, lwidth(thin) lpattern(solid) lcolor(midgreen))
	(rcap diff_long_black_lb diff_long_black_ub age_group, lwidth(thin) lpattern(solid) lcolor(cranberry))
	(rcap diff_long_hisp_lb diff_long_hisp_ub age_group, lwidth(thin) lpattern(solid) lcolor(sand))

	
	, 
	
	
	xlabel(1(1)13) xtitle("Age group (years)", size(vsmall)) 
	xlabel(, labsize(vsmall) angle(forty_five) valuelabel) 
	yline(0, lpattern(solid) lwidth(thin) lcolor(lavender))
	ylabel(`myla', angle(horizontal)) ytitle("Percent reporting more than 9 hours of sleep", size(small))
	subtitle("Women only", size(medium)) 
	legend(
		order(1 "Asian difference with White" 2 "Black difference with White" 3 "Latino/Hispanic difference with White")
		size(vsmall) position(5) ring(0) 
		region(fcolor(white%30)) bmargin(small) 
		title("")) 
	xsize(5) ysize(4)
	scheme(plotplainblind) 
	;
graph save figure_long_sleep_age_diff_long_female, replace;
graph export figure_long_sleep_age_diff_long_female.jpg, as(jpg) name("Graph") quality(100) replace ;
graph export figure_long_sleep_age_diff_long_female.eps, as(eps) name("Graph") preview(off) replace ;
#delimit cr

**#					2.2.2 Males only

u ratefile_sleep_age_male,clear
	
label var age_group "Age group, (years)"
label define age_group 1 "18-24" 2 "25-29" 3 "30-34" 4 "35-39" 5 "40-44" 6 "45-49" 7 "50-54" 8 "55-59" 9 "60-64" 10 "65-69" 11 "70-74" 12 "75-79" 13 ">=80"
label value age_group age_group

#delimit ;
 mylabels 0(5)50, myscale(@/100) local(myla) ;

twoway 
	(connected rate_long_asian age_group, lpattern(solid) lcolor(midgreen) msymbol(o) mcolor(midgreen)) 
	(connected rate_long_black age_group, lpattern(solid) lcolor(cranberry) msymbol(s) mcolor(cranberry)) 
	(connected rate_long_hispanic age_group, lpattern(solid) lcolor(sand) msymbol(t) mcolor(sand)) 
	(connected rate_long_white age_group, lpattern(solid) lcolor(lavender) msymbol(d) mcolor(lavender))
	
	(rcap lb_long_asian ub_long_asian age_group, lwidth(thin) lpattern(solid) lcolor(midgreen))
	(rcap lb_long_black ub_long_black age_group, lwidth(thin) lpattern(solid) lcolor(cranberry))
	(rcap lb_long_hispanic ub_long_hispanic age_group, lwidth(thin) lpattern(solid) lcolor(sand))
	(rcap lb_long_white ub_long_white age_group, lwidth(thin) lpattern(solid) lcolor(lavender)), 
	
	
	xlabel(1(1)13) xtitle("Age group (years)", size(vsmall)) 
	xlabel(, labsize(vsmall) angle(forty_five) valuelabel) 
	ylabel(`myla', angle(horizontal)) ytitle("Percent reporting more than 9 hours of sleep", size(small))
	subtitle("Men only", size(medium)) 
	legend(off)
	xsize(5) ysize(4)
	scheme(plotplainblind) 
	;
graph save figure_long_sleep_age_male, replace;
graph export figure_long_sleep_age_male.jpg, as(jpg) name("Graph") quality(100) replace ;
graph export figure_long_sleep_age_male.eps, as(eps) name("Graph") preview(off) replace ;
#delimit cr

#delimit ;
 mylabels -20(5)20, myscale(@/100) local(myla) ;

twoway 
	(connected diff_long_asian age_group, lpattern(solid) lcolor(midgreen) msymbol(o) mcolor(midgreen)) 
	(connected diff_long_black age_group, lpattern(solid) lcolor(cranberry) msymbol(s) mcolor(cranberry)) 
	(connected diff_long_hisp age_group, lpattern(solid) lcolor(sand) msymbol(t) mcolor(sand)) 
	
	(rcap diff_long_asian_lb diff_long_asian_ub age_group, lwidth(thin) lpattern(solid) lcolor(midgreen))
	(rcap diff_long_black_lb diff_long_black_ub age_group, lwidth(thin) lpattern(solid) lcolor(cranberry))
	(rcap diff_long_hisp_lb diff_long_hisp_ub age_group, lwidth(thin) lpattern(solid) lcolor(sand))

	
	, 
	
	
	xlabel(1(1)13) xtitle("Age group (years)", size(vsmall)) 
	xlabel(, labsize(vsmall) angle(forty_five) valuelabel) 
	yline(0, lpattern(solid) lwidth(thin) lcolor(lavender))
	ylabel(`myla', angle(horizontal)) ytitle("Percent reporting more than 9 hours of sleep", size(small))
	subtitle("Men only", size(medium)) 
	legend(
		order(1 "Asian difference with White" 2 "Black difference with White" 3 "Latino/Hispanic difference with White")
		size(vsmall) position(5) ring(0) 
		region(fcolor(white%30)) bmargin(small) 
		title("")) 
	xsize(5) ysize(4)
	scheme(plotplainblind) 
	;
graph save figure_long_sleep_age_diff_long_male, replace;
graph export figure_long_sleep_age_diff_long_male.jpg, as(jpg) name("Graph") quality(100) replace ;
graph export figure_long_sleep_age_diff_long_male.eps, as(eps) name("Graph") preview(off) replace ;
#delimit cr

**#			3. By income level

**#				3.1 Short sleep duration

**#					3.1.1 Low-income only

	
u ratefile_age_lowinc,clear
	
label var age_group "Age group, (years)"
label define age_group 1 "18-24" 2 "25-29" 3 "30-34" 4 "35-39" 5 "40-44" 6 "45-49" 7 "50-54" 8 "55-59" 9 "60-64" 10 "65-69" 11 "70-74" 12 "75-79" 13 ">=80"
label value age_group age_group

#delimit ;
 mylabels 0(5)50, myscale(@/100) local(myla) ;

twoway 
	(connected rate_less_asian age_group, lpattern(solid) lcolor(midgreen) msymbol(o) mcolor(midgreen)) 
	(connected rate_less_black age_group, lpattern(solid) lcolor(cranberry) msymbol(s) mcolor(cranberry)) 
	(connected rate_less_hispanic age_group, lpattern(solid) lcolor(sand) msymbol(t) mcolor(sand)) 
	(connected rate_less_white age_group, lpattern(solid) lcolor(lavender) msymbol(d) mcolor(lavender))
	
	(rcap lb_less_asian ub_less_asian age_group, lwidth(thin) lpattern(solid) lcolor(midgreen))
	(rcap lb_less_black ub_less_black age_group, lwidth(thin) lpattern(solid) lcolor(cranberry))
	(rcap lb_less_hispanic ub_less_hispanic age_group, lwidth(thin) lpattern(solid) lcolor(sand))
	(rcap lb_less_white ub_less_white age_group, lwidth(thin) lpattern(solid) lcolor(lavender)), 
	
	
	xlabel(1(1)13) xtitle("Age group (years)", size(vsmall)) 
	xlabel(, labsize(vsmall) angle(forty_five) valuelabel) 
	ylabel(`myla', angle(horizontal)) ytitle("Percent reporting fewer than 7 hours of sleep", size(small))
	subtitle("Low-income only", size(medium)) 
	legend(off)
	xsize(5) ysize(4)
	scheme(plotplainblind) 
	;
graph save figure_less_sleep_age_lowinc, replace;
graph export figure_less_sleep_age_lowinc.jpg, as(jpg) name("Graph") quality(100) replace ;
#delimit cr

#delimit ;
 mylabels -20(5)20, myscale(@/100) local(myla) ;

twoway 
	(connected diff_less_asian age_group, lpattern(solid) lcolor(midgreen) msymbol(o) mcolor(midgreen)) 
	(connected diff_less_black age_group, lpattern(solid) lcolor(cranberry) msymbol(s) mcolor(cranberry)) 
	(connected diff_less_hisp age_group, lpattern(solid) lcolor(sand) msymbol(t) mcolor(sand)) 
	
	(rcap diff_less_asian_lb diff_less_asian_ub age_group, lwidth(thin) lpattern(solid) lcolor(midgreen))
	(rcap diff_less_black_lb diff_less_black_ub age_group, lwidth(thin) lpattern(solid) lcolor(cranberry))
	(rcap diff_less_hisp_lb diff_less_hisp_ub age_group, lwidth(thin) lpattern(solid) lcolor(sand))

	
	, 
	
	
	xlabel(1(1)13) xtitle("Age group (years)", size(vsmall)) 
	xlabel(, labsize(vsmall) angle(forty_five) valuelabel) 
	yline(0, lpattern(solid) lwidth(thin) lcolor(lavender))
	ylabel(`myla', angle(horizontal)) ytitle("Percent reporting fewer than 7 hours of sleep", size(small))
	subtitle("Low-income only", size(medium)) 
	legend(
		order(1 "Asian difference with White" 2 "Black difference with White" 3 "Latino/Hispanic difference with White")
		size(vsmall) position(5) ring(0) 
		region(fcolor(white%30)) bmargin(small) 
		title("")) 
	xsize(5) ysize(4)
	scheme(plotplainblind) 
	;
graph save figure_less_sleep_age_diff_less_lowinc, replace;
graph export figure_less_sleep_age_diff_less_lowinc.jpg, as(jpg) name("Graph") quality(100) replace ;
graph export figure_less_sleep_age_diff_less_lowinc.eps, as(eps) name("Graph") preview(off) replace ;
#delimit cr

**#					3.1.2 Middle/high-income only
	
u ratefile_age_midhighinc,clear
	
label var age_group "Age group, (years)"
label define age_group 1 "18-24" 2 "25-29" 3 "30-34" 4 "35-39" 5 "40-44" 6 "45-49" 7 "50-54" 8 "55-59" 9 "60-64" 10 "65-69" 11 "70-74" 12 "75-79" 13 ">=80"
label value age_group age_group

#delimit ;
 mylabels 0(5)50, myscale(@/100) local(myla) ;

twoway 
	(connected rate_less_asian age_group, lpattern(solid) lcolor(midgreen) msymbol(o) mcolor(midgreen)) 
	(connected rate_less_black age_group, lpattern(solid) lcolor(cranberry) msymbol(s) mcolor(cranberry)) 
	(connected rate_less_hispanic age_group, lpattern(solid) lcolor(sand) msymbol(t) mcolor(sand)) 
	(connected rate_less_white age_group, lpattern(solid) lcolor(lavender) msymbol(d) mcolor(lavender))
	
	(rcap lb_less_asian ub_less_asian age_group, lwidth(thin) lpattern(solid) lcolor(midgreen))
	(rcap lb_less_black ub_less_black age_group, lwidth(thin) lpattern(solid) lcolor(cranberry))
	(rcap lb_less_hispanic ub_less_hispanic age_group, lwidth(thin) lpattern(solid) lcolor(sand))
	(rcap lb_less_white ub_less_white age_group, lwidth(thin) lpattern(solid) lcolor(lavender)), 
	
	
	xlabel(1(1)13) xtitle("Age group (years)", size(vsmall)) 
	xlabel(, labsize(vsmall) angle(forty_five) valuelabel) 
	ylabel(`myla', angle(horizontal)) ytitle("Percent reporting fewer than 7 hours of sleep", size(small))
	subtitle("Mid/high-income only", size(medium)) 
	legend(off)
	xsize(5) ysize(4)
	scheme(plotplainblind) 
	;
graph save figure_less_sleep_age_midhighinc, replace;
graph export figure_less_sleep_age_midhighinc.jpg, as(jpg) name("Graph") quality(100) replace ;
graph export figure_less_sleep_age_midhighinc.eps, as(eps) name("Graph") preview(off) replace ;
#delimit cr

#delimit ;
 mylabels -20(5)20, myscale(@/100) local(myla) ;

twoway 
	(connected diff_less_asian age_group, lpattern(solid) lcolor(midgreen) msymbol(o) mcolor(midgreen)) 
	(connected diff_less_black age_group, lpattern(solid) lcolor(cranberry) msymbol(s) mcolor(cranberry)) 
	(connected diff_less_hisp age_group, lpattern(solid) lcolor(sand) msymbol(t) mcolor(sand)) 
	
	(rcap diff_less_asian_lb diff_less_asian_ub age_group, lwidth(thin) lpattern(solid) lcolor(midgreen))
	(rcap diff_less_black_lb diff_less_black_ub age_group, lwidth(thin) lpattern(solid) lcolor(cranberry))
	(rcap diff_less_hisp_lb diff_less_hisp_ub age_group, lwidth(thin) lpattern(solid) lcolor(sand))

	
	, 
	
	
	xlabel(1(1)13) xtitle("Age group (years)", size(vsmall)) 
	xlabel(, labsize(vsmall) angle(forty_five) valuelabel) 
	yline(0, lpattern(solid) lwidth(thin) lcolor(lavender))
	ylabel(`myla', angle(horizontal)) ytitle("Percent reporting fewer than 7 hours of sleep", size(small))
	subtitle("Mid/high-income only", size(medium)) 
	legend(
		order(1 "Asian difference with White" 2 "Black difference with White" 3 "Latino/Hispanic difference with White")
		size(vsmall) position(5) ring(0) 
		region(fcolor(white%30)) bmargin(small) 
		title("")) 
	xsize(5) ysize(4)
	scheme(plotplainblind) 
	;
graph save figure_less_sleep_age_diff_less_midhighinc, replace;
graph export figure_less_sleep_age_diff_less_midhighinc.jpg, as(jpg) name("Graph") quality(100) replace ;
graph export figure_less_sleep_age_diff_less_midhighinc.eps, as(eps) name("Graph") preview(off) replace ;
#delimit cr

**#				3.2 Long sleep duration

**#					3.2.1 Low-income only

u ratefile_age_lowinc,clear
	
label var age_group "Age group, (years)"
label define age_group 1 "18-24" 2 "25-29" 3 "30-34" 4 "35-39" 5 "40-44" 6 "45-49" 7 "50-54" 8 "55-59" 9 "60-64" 10 "65-69" 11 "70-74" 12 "75-79" 13 ">=80"
label value age_group age_group

#delimit ;
 mylabels 0(5)50, myscale(@/100) local(myla) ;

twoway 
	(connected rate_long_asian age_group, lpattern(solid) lcolor(midgreen) msymbol(o) mcolor(midgreen)) 
	(connected rate_long_black age_group, lpattern(solid) lcolor(cranberry) msymbol(s) mcolor(cranberry)) 
	(connected rate_long_hispanic age_group, lpattern(solid) lcolor(sand) msymbol(t) mcolor(sand)) 
	(connected rate_long_white age_group, lpattern(solid) lcolor(lavender) msymbol(d) mcolor(lavender))
	
	(rcap lb_long_asian ub_long_asian age_group, lwidth(thin) lpattern(solid) lcolor(midgreen))
	(rcap lb_long_black ub_long_black age_group, lwidth(thin) lpattern(solid) lcolor(cranberry))
	(rcap lb_long_hispanic ub_long_hispanic age_group, lwidth(thin) lpattern(solid) lcolor(sand))
	(rcap lb_long_white ub_long_white age_group, lwidth(thin) lpattern(solid) lcolor(lavender)), 
	
	
	xlabel(1(1)13) xtitle("Age group (years)", size(vsmall)) 
	xlabel(, labsize(vsmall) angle(forty_five) valuelabel) 
	ylabel(`myla', angle(horizontal)) ytitle("Percent reporting more than 9 hours of sleep", size(small))
	subtitle("Low-income only", size(medium)) 
	legend(off)
	xsize(5) ysize(4)
	scheme(plotplainblind) 
	;
graph save figure_long_sleep_age_lowinc, replace;
graph export figure_long_sleep_age_lowinc.jpg, as(jpg) name("Graph") quality(100) replace ;
graph export figure_long_sleep_age_lowinc.eps, as(eps) name("Graph") preview(off) replace ;
#delimit cr

#delimit ;
 mylabels -20(5)20, myscale(@/100) local(myla) ;

twoway 
	(connected diff_long_asian age_group, lpattern(solid) lcolor(midgreen) msymbol(o) mcolor(midgreen)) 
	(connected diff_long_black age_group, lpattern(solid) lcolor(cranberry) msymbol(s) mcolor(cranberry)) 
	(connected diff_long_hisp age_group, lpattern(solid) lcolor(sand) msymbol(t) mcolor(sand)) 
	
	(rcap diff_long_asian_lb diff_long_asian_ub age_group, lwidth(thin) lpattern(solid) lcolor(midgreen))
	(rcap diff_long_black_lb diff_long_black_ub age_group, lwidth(thin) lpattern(solid) lcolor(cranberry))
	(rcap diff_long_hisp_lb diff_long_hisp_ub age_group, lwidth(thin) lpattern(solid) lcolor(sand))

	
	, 
	
	
	xlabel(1(1)13) xtitle("Age group (years)", size(vsmall)) 
	xlabel(, labsize(vsmall) angle(forty_five) valuelabel) 
	yline(0, lpattern(solid) lwidth(thin) lcolor(lavender))
	ylabel(`myla', angle(horizontal)) ytitle("Percent reporting more than 9 hours of sleep", size(small))
	subtitle("Low-income only", size(medium)) 
	legend(
		order(1 "Asian difference with White" 2 "Black difference with White" 3 "Latino/Hispanic difference with White")
		size(vsmall) position(5) ring(0) 
		region(fcolor(white%30)) bmargin(small) 
		title("")) 
	xsize(5) ysize(4)
	scheme(plotplainblind) 
	;
graph save figure_long_sleep_age_diff_long_lowinc, replace;
graph export figure_long_sleep_age_diff_long_lowinc.jpg, as(jpg) name("Graph") quality(100) replace ;
graph export figure_long_sleep_age_diff_long_lowinc.eps, as(eps) name("Graph") preview(off) replace ;
#delimit cr

**#					3.2.2 Middle/high-income only
	
u ratefile_age_midhighinc,clear
	
label var age_group "Age group, (years)"
label define age_group 1 "18-24" 2 "25-29" 3 "30-34" 4 "35-39" 5 "40-44" 6 "45-49" 7 "50-54" 8 "55-59" 9 "60-64" 10 "65-69" 11 "70-74" 12 "75-79" 13 ">=80"
label value age_group age_group

#delimit ;
 mylabels 0(5)50, myscale(@/100) local(myla) ;

twoway 
	(connected rate_long_asian age_group, lpattern(solid) lcolor(midgreen) msymbol(o) mcolor(midgreen)) 
	(connected rate_long_black age_group, lpattern(solid) lcolor(cranberry) msymbol(s) mcolor(cranberry)) 
	(connected rate_long_hispanic age_group, lpattern(solid) lcolor(sand) msymbol(t) mcolor(sand)) 
	(connected rate_long_white age_group, lpattern(solid) lcolor(lavender) msymbol(d) mcolor(lavender))
	
	(rcap lb_long_asian ub_long_asian age_group, lwidth(thin) lpattern(solid) lcolor(midgreen))
	(rcap lb_long_black ub_long_black age_group, lwidth(thin) lpattern(solid) lcolor(cranberry))
	(rcap lb_long_hispanic ub_long_hispanic age_group, lwidth(thin) lpattern(solid) lcolor(sand))
	(rcap lb_long_white ub_long_white age_group, lwidth(thin) lpattern(solid) lcolor(lavender)), 
	
	
	xlabel(1(1)13) xtitle("Age group (years)", size(vsmall)) 
	xlabel(, labsize(vsmall) angle(forty_five) valuelabel) 
	ylabel(`myla', angle(horizontal)) ytitle("Percent reporting more than 9 hours of sleep", size(small))
	subtitle("Mid/high-income only", size(medium)) 
	legend(off)
	xsize(5) ysize(4)
	scheme(plotplainblind) 
	;
graph save figure_long_sleep_age_midhighinc, replace;
graph export figure_long_sleep_age_midhighinc.jpg, as(jpg) name("Graph") quality(100) replace ;
graph export figure_long_sleep_age_midhighinc.eps, as(eps) name("Graph") preview(off) replace ;
#delimit cr

#delimit ;
 mylabels -20(5)20, myscale(@/100) local(myla) ;

twoway 
	(connected diff_long_asian age_group, lpattern(solid) lcolor(midgreen) msymbol(o) mcolor(midgreen)) 
	(connected diff_long_black age_group, lpattern(solid) lcolor(cranberry) msymbol(s) mcolor(cranberry)) 
	(connected diff_long_hisp age_group, lpattern(solid) lcolor(sand) msymbol(t) mcolor(sand)) 
	
	(rcap diff_long_asian_lb diff_long_asian_ub age_group, lwidth(thin) lpattern(solid) lcolor(midgreen))
	(rcap diff_long_black_lb diff_long_black_ub age_group, lwidth(thin) lpattern(solid) lcolor(cranberry))
	(rcap diff_long_hisp_lb diff_long_hisp_ub age_group, lwidth(thin) lpattern(solid) lcolor(sand))

	
	, 
	
	
	xlabel(1(1)13) xtitle("Age group (years)", size(vsmall)) 
	xlabel(, labsize(vsmall) angle(forty_five) valuelabel) 
	yline(0, lpattern(solid) lwidth(thin) lcolor(lavender))
	ylabel(`myla', angle(horizontal)) ytitle("Percent reporting more than 9 hours of sleep", size(small))
	subtitle("Mid/high-income only", size(medium)) 
	legend(
		order(1 "Asian difference with White" 2 "Black difference with White" 3 "Latino/Hispanic difference with White")
		size(vsmall) position(5) ring(0) 
		region(fcolor(white%30)) bmargin(small) 
		title("")) 
	xsize(5) ysize(4)
	scheme(plotplainblind) 
	;
graph save figure_long_sleep_age_diff_long_midhighinc, replace;
graph export figure_long_sleep_age_diff_long_midhighinc.jpg, as(jpg) name("Graph") quality(100) replace ;
graph export figure_long_sleep_age_diff_long_midhighinc.eps, as(eps) name("Graph") preview(off) replace ;
#delimit cr
