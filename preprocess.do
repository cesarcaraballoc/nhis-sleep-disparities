/* 				


			Temporal Trends in Racial and Ethnic Disparities in Sleep 
				Duration in the United States, 2004–2018

César Caraballo, Shiwani Mahajan, Javier Valero-Elizondo, Daisy Massey, Yuan Lu,
Brita Roy, Carley Riley, Amarnath R. Annapureddy, Karthik Murugiah, Johanna Elumn,
Khurram Nasir, Marcella Nunez-Smith, Howard P. Forman, Chandra L. Jackson, 
Jeph Herrin, Harlan M. Krumholz

medRxiv 2021.10.31.21265202

Available from: https://doi.org/10.1101/2021.10.31.21265202 

	Preprocessing, study sample creation, variables of interest.	

	Table of contents
		1. Independent variables
		2. Dependent variables
		3. Other descriptive variables of interest
		4. Other indicators
		5. Exclusions, centering, and saving file

*/

use nhis_04-18.dta, clear

/*

Important note:

The data file used above was obtained from the Integrated Public Use Microdata
Series website (https://nhis.ipums.org/nhis/), containing NHIS data from years 
2004 to 2018.

When generating the variables of interest, inspect each variable encoding. 
Their underlying values may have changed from the ones in the version that we used.

*/
	  

* keep only sample adult

keep if astatflg==1

drop if age < 18

* 0. Fixing weights and survey set.

gen sampweight_ipums_pooled = sampweight / 15

gen strata_ipums_pooled = strata / 15

gen psu_ipums_pooled = psu / 15

svyset [pw=sampweight_ipums_pooled], strata(strata_ipums_pooled) psu(psu_ipums_pooled)


/*******************************************************************************
********************************************************************************	

1. Independent variables

********************************************************************************	
*******************************************************************************/

/*

	1.1 Race/Ethnicity

*/

gen race=.
replace race=1 if racea==100 & hispyn==1
replace race=3 if racea==200 & hispyn==1
replace race=7 if (racea>201 & racea<889) & hispyn==1
replace race=5 if (racea>=400 & racea<500) & hispyn==1
replace race=9 if hispyn==2

label variable race "Race/Ethnicity"
label define race 	1 "NH White" 3 "NH Black" 5 "NH Asian" 7 "NH Other" 9 "Hispanic"
label value race race


gen white=0
replace white=1 if race==1

gen black=0
replace black=1 if race==3

gen asian=0
replace asian=1 if race==5

gen otherrace=0 
replace otherrace=1 if race==7

gen hispanic=0
replace hispanic=1 if race==9

gen allfour=0
replace allfour=1 if race==1 | race==3 | race==5 | race==9
 
/*

	1.2 Mulitply imputed low-income level indicators

*/

foreach G in 1 2 3 4 5 {
gen lowincome_`G'=.
replace lowincome_`G'=0 if povimp`G' >=8 & povimp`G'!=98
replace lowincome_`G'=1 if povimp`G' <8

label variable lowincome_`G' "Low Income (<200% Federal Poverty Limit)"
	label define lowincome_`G' 0 "No" 1 "Yes"
	label value lowincome_`G' lowincome_`G'

	
}

/*******************************************************************************
********************************************************************************	

2. Dependent variables

********************************************************************************	
*******************************************************************************/

** sleep duration

gen less_sleep=.
replace less_sleep=0 if hrsleep>=7 & hrsleep<25
replace less_sleep=1 if hrsleep<7
lab var less_sleep "Sleep <7 hrs"
lab def less_sleep 0 "No" 1 "Yes"
lab val less_sleep less_sleep

gen long_sleep=.
replace long_sleep=0 if hrsleep<=9 | hrsleep==25
replace long_sleep=1 if hrsleep>9  & hrsleep<25
lab var long_sleep "Sleep ≥10 hrs"
lab def long_sleep 0 "No" 1 "Yes"
lab val long_sleep long_sleep

gen bad_sleep=.
replace bad_sleep=0 if less_sleep==0 & long_sleep==0 
replace bad_sleep=1 if less_sleep==1 | long_sleep==1
lab var bad_sleep "Sleep disturbance"
lab def bad_sleep 0 "No" 1 "Yes"
lab val bad_sleep bad_sleep

gen good_sleep=0
replace good_sleep=1 if hrsleep >=7 & hrsleep<=9
lab var good_sleep "Recommended sleep"
lab def good_sleep 0 "No" 1 "Yes"
lab val good_sleep good_sleep

** sleep distribution

gen sleepdist=.
replace sleepdist=3 if hrsleep<4
replace sleepdist=4 if hrsleep==4
replace sleepdist=5 if hrsleep==5
replace sleepdist=6 if hrsleep==6
replace sleepdist=7 if hrsleep==7
replace sleepdist=8 if hrsleep==8
replace sleepdist=9 if hrsleep==9
replace sleepdist=10 if hrsleep==10
replace sleepdist=11 if hrsleep==11
replace sleepdist=12 if hrsleep==12
replace sleepdist=13 if hrsleep>12 & hrsleep!=.

lab var sleepdist "Sleep duration"
lab def sleepdist 3 "≤3" 4 "4" 5 "5" 6 "6" 7 "7" 8 "8" 9 "9" 10 "10" 11 "11" 12 "12" 13 "≥13"
lab val sleepdist sleepdist


/*******************************************************************************
********************************************************************************	

3. Other descriptive variables of interest

********************************************************************************	
*******************************************************************************/

/*

	3.1 Female sex indicator

*/ 

gen female=0
replace female=1 if sex==2

/*

	3.2 Marital status

*/ 

gen married=.
replace married=1 if marstat>14 & marstat<98
replace married=3 if marstat<14
replace married=. if marstat==99

label variable married "Marital Status"
	label define married 1 "Not Married" 3 "Married" 
	label value married married

/*

	3.3 Education level

*/ 

gen education=.
replace education=1 if educ <200
replace education=2 if educ >=200 
replace education=3 if educ >=300 
replace education=4 if educ >=400 & educ <995
replace education=. if educ >995

lab var education "Education Recode"
lab def education 1 "Less than high school" 2 "High school diploma or GED" 3 "Some college" 4 "Bachelor's degree or higher" 
lab val education education

/*

	3.4 Family size

*/ 

gen family=.
replace family=1 if famsize==1
replace family=3 if famsize==2
replace family=7 if famsize>=3 & famsize<.

label variable family "Family Size"
	label define family 1 "1" 3 "2" 7 "≥3"
	label value family family

/*

	3.5 BMI

*/ 
 
gen bmicat=.
replace bmicat=0 if bmi<18.5
replace bmicat=1 if bmi>=18.5 & bmi<25 
replace bmicat=2 if bmi>=25 & bmi<30
replace bmicat=3 if bmi>=30 & bmi<35
replace bmicat=4 if bmi>=35 & bmi<=60  

lab var bmicat "BMI Category"
lab def bmicat 0 "Underweight" 1 "Normal" 2 "Overweight" 3 "Obese" 4 "Severely Obese"
lab val bmicat bmicat

gen bminew=.
replace bminew=0 if bmicat==0 | bmicat==1 | bmicat==2 
replace bminew=1 if bmicat==3 | bmicat==4

lab var bminew "Obese"
lab def bminew 0 "No" 1 "Yes"
lab val bminew bminew

/*

	3.6 Smoking status

*/ 

gen smokestatnew=.
replace  smokestatnew=0 if  smokestatus2==30
replace smokestatnew=1 if smokestatus2==20
replace smokestatnew=2 if smokestatus2==11 | smokestatus2==12
lab var smokestatnew "Smoking status"
lab def smokestatnew 0 "Never smoker" 1 "Former smoker" 2 "Current everyday/someday smoker"
lab val smokestatnew smokestatnew

gen currentsmoker=.
replace currentsmoker=0 if  smokestatnew==0 | smokestatnew==1
replace currentsmoker=1 if  smokestatnew==2
lab var currentsmoker "Current everyday/someday Smoker"
lab def currentsmoker 0 "No" 1 "Yes" 
lab val currentsmoker currentsmoker

/*

	3.4 Flu shot 

*/ 

replace vacflush12m=. if vacflush12m>2

gen flushot=.
replace flushot=0 if  vacflush12m==1 
replace flushot=1 if  vacflush12m==2 
lab var flushot "Flu Shot in past 12 m"
lab def flushot 0 "No" 1 "Yes" 
lab val flushot flushot

gen noflushot=.
replace noflushot=0 if  flushot==1 
replace noflushot=1 if  flushot==0
lab var noflushot "NO Flu Shot in past 12 m"
lab def noflushot 0 "Received flu shot" 1 "No flu shot" 
lab val noflushot noflushot



/*

	3.5 Employment/work status

*/ 

gen workstat=.
replace workstat=1 if empstat>9 & empstat<29
replace workstat=3 if empstat==40
replace workstat=7 if empstat==30
replace workstat=. if empstat>40

label var workstat "Work Status"
label def workstat 1 "With a Job or Working" 3 "Not in Labor Force" 7 "Unemployed" 
label value workstat workstat

/*

	3.6 US citizenship

*/ 

gen uscitizen=.
replace uscitizen=0 if citizen==1
replace uscitizen=1 if citizen==2
replace uscitizen=. if citizen==7 | citizen==8 | citizen==9


label var uscitizen "U.S. Citizenship Status"
label define uscitizen 0 "Not U.S. citizen" 1 "U.S. citizen" 
label value uscitizen uscitizen

/*

	3.7 Age categories and age group indicators

*/ 

gen agecat=.
replace agecat=1 if age<40
replace agecat=3 if age>=40 & age<65
replace agecat=5 if age>=65 & age<.

label var agecat "Age Category"
label define agecat 1 "18–39 years" 3 "40–64 years" 5 "≥65 years"
label value agecat agecat

gen age_cate=.
	replace age_cate=1 if age>=18
	replace age_cate=2 if age>=25 
	replace age_cate=3 if age>=30
	replace age_cate=4 if age>=35
	replace age_cate=5 if age>=40 
	replace age_cate=6 if age>=45
	replace age_cate=7 if age>=50 
	replace age_cate=8 if age>=55
	replace age_cate=9 if age>=60
	replace age_cate=10 if age>=65
	replace age_cate=11 if age>=70
	replace age_cate=12 if age>=75
	replace age_cate=13 if age>=80
	
	tab age_cate, gen(age_group)
	

/*

	3.8 No insurance coverage
	
*/

gen noinsurance=.
replace noinsurance=0 if hinotcove==1
replace noinsurance=1 if hinotcove==2
replace noinsurance=. if hinotcove==9 

label variable noinsurance "Insurance Coverage"
	label define noinsurance 0 "Insured" 1 "Uninsured"
	label value noinsurance noinsurance
	
/* 

	3.9 Chronic conditions and multimorbidity
	
*/


*** Diabetes


gen dibev=.
replace dibev=0 if diabeticev==1 | diabeticev==3
replace dibev=1 if diabeticev==2 
lab var dibev "Ever told had diabetes"
lab def dibev 0 "No" 1 "Yes" 
lab val dibev dibev

*** HTN


gen htnev=.
replace htnev=0 if  hypertenev==1 
replace htnev=1 if  hypertenev==2 
lab var htnev "Ever told had Hypertension"
lab def htnev 0 "No" 1 "Yes" 
lab val htnev htnev


*** Stroke

gen everstroke=.
replace everstroke=0 if  strokev==1 
replace everstroke=1 if  strokev==2 
lab var everstroke "Ever told had Stroke"
lab def everstroke 0 "No" 1 "Yes" 
lab val everstroke everstroke

*** MI or stroke (for table 1)
gen mi_stroke=.
replace mi_stroke=0 if heartattev==1 & strokev==1 
replace mi_stroke=1 if heartattev==2 | strokev==2
lab var mi_stroke "Ever had MI or Stroke"
lab def mi_stroke 0 "No" 1 "Yes" 
lab val mi_stroke mi_stroke


*** Cancer

gen canev=.
replace canev=0 if  cancerev==1 
replace canev=1 if  cancerev==2 
lab var canev "Ever told had Cancer"
lab def canev 0 "No" 1 "Yes" 
lab val canev canev


*** Asthma

gen asthma=.
replace asthma=0 if  asthmaev==1 
replace asthma=1 if  asthmaev==2 
lab var asthma "Ever told had Asthma"
lab def asthma 0 "No" 1 "Yes" 
lab val asthma asthma


*** COPD: Emphysema/Chronic bronchitis

gen copdev=.
replace copdev=0 if  emphysemev==1 | cronbronyr==1
replace copdev=1 if  emphysemev==2 | cronbronyr==2
lab var copdev "Ever told had COPD"
lab def copdev 0 "No" 1 "Yes" 
lab val copdev copdev



*** Heart disease (CAD, MI, Angina, other heart conditions)


gen heartds=.
replace heartds=0 if  cheartdiev==1 | angipecev==1 | heartconev==1 | heartattev==1 
replace heartds=1 if  cheartdiev==2 | angipecev==2 | heartconev==2 | heartattev==2 
lab var heartds "Ever told had Any Heart Disease"
lab def heartds 0 "No" 1 "Yes" 
lab val heartds heartds


**** Chronic liver condition

gen cld_new=.
replace cld_new=0 if  liverconyr==1 
replace cld_new=1 if  liverconyr==2 
lab var cld_new "Ever told had Chronic liver condition"
lab def cld_new 0 "No" 1 "Yes" 
lab val cld_new cld_new


** Weak or failing kidneys


gen kidneyds=.
replace kidneyds=0 if  kidneywkyr==1 
replace kidneyds=1 if  kidneywkyr==2 
lab var kidneyds "Told had weak/failing kidneys in past 12m"
lab def kidneyds 0 "No" 1 "Yes" 
lab val kidneyds kidneyds

** Arthritis

gen arthritis=.
replace arthritis=0 if arthglupev==1 
replace arthritis=1 if arthglupev==2 

rename dibev diabetes
rename htnev hypertension 
rename everstroke stroke 
rename canev cancer 
rename copdev copd 
rename heartds heartdisease 
rename cld_new liverdisease
rename kidneyds ckd


egen conditions=rowtotal(diabetes hypertension stroke cancer asthma copd heartdisease liverdisease ckd arthritis)

gen missingconditions=0

replace missingconditions=1 if diabetes==. & hypertension==. &  stroke==. &  cancer==. &  asthma==. &  copd==. &  heartdisease==. &  liverdisease==. &  ckd==.  &  arthritis==. 

replace conditions=. if missingconditions==1

gen multimorbid=.
replace multimorbid=0 if conditions<2
replace multimorbid=1 if conditions>=2 & conditions<.
label var multimorbid "with ≥2 comorbidities"

/*
	3.10 Poor health
*/

replace health=. if health == 7 | health == 8 | health == 9


gen poorhealth=.
replace poorhealth=0 if health==1 | health==2 | health==3
replace poorhealth=1 if health==4 | health==5
lab var poorhealth "Poor or Fair Health"
lab def poorhealth 0 "No" 1 "Yes"
lab val poorhealth poorhealth


/*******************************************************************************
********************************************************************************	

4. Other indicators

********************************************************************************	
*******************************************************************************/

/*

	4.1 Groups of years

*/ 

gen firstyears=0
replace firstyears=1 if year==2004 | year==2005

gen midyears=0
replace midyears=1 if year==2010 | year==2011 | year==2012

gen lastyears=0
replace lastyears=1 if year==2017 | year==2018

/*

	4.2 Single year indicators

*/ 

forvalues i=2004/2018 {
	gen year_`i'=0
	replace year_`i'=1 if year==`i'	
	}

/*

	4.3 Region indicators

*/ 

gen neast=0
replace neast=1 if region==1

gen midwest=0
replace midwest=1 if region==2

gen south=0
replace south=1 if region==3

gen west=0
replace west=1 if region==4


/*******************************************************************************
********************************************************************************	

5. Exclusions, centering, and saving file

********************************************************************************	
*******************************************************************************/

drop if hispyn>6 | racea>=900

drop if race==7

drop if hrsleep>=97 | hrsleep==.


mcenter age
mcenter neast
mcenter midwest
mcenter south
mcenter west
mcenter female  

compress

save sleep.dta, replace
