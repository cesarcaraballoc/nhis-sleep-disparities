# Temporal Trends in Racial and Ethnic Disparities in Sleep Duration in the United States, 2004–2018

César Caraballo, Shiwani Mahajan, Javier Valero-Elizondo, Daisy Massey, Yuan Lu, Brita Roy, Carley Riley, Amarnath R. Annapureddy, Karthik Murugiah, Johanna Elumn, Khurram Nasir, Marcella Nunez-Smith, Howard P. Forman, Chandra L. Jackson, Jeph Herrin, Harlan M. Krumholz

Available from: https://doi.org/10.1101/2021.10.31.21265202

## Replication File Read Me

In these files, we included the code used to obtain the data presented in tables and figures in the main paper and its supplemental material. We also included the dataset codebook. 

All the data used in this study are publicly available. We obtained the data from the Integrated Public Use Microdata Series website (https://nhis.ipums.org/nhis/). [1]

Below, we describe each of the Stata .do files. These .do files use the special bookmark comment –**#– to facilitate the inspection of its contents using Stata's Do-file Editor Navigation Control.


### preprocess.do
•	Describes the study sample creation and generation of variables of interest. 

### population_general_characteristics.do
•	Estimates the study population characteristics by race and ethnicity. 

### annual_prevalence_estimation.do
•	Estimates the annual prevalence by race and ethnicity of short and long sleep duration.

### temporal_trends_analysis.do
• Estimates the annualized rate of change of each sleep duration prevalence by race and ethnicity, along with the racial and ethnic differences from 2004 to 2018.

### temporal_trends_figures.do
•	Plots the annual prevalence of each sleep duration by race/ethnicity using the estimates obtained by running annual_prevalence_estimation.do 

### prevalence_by_age.do
•	Estimates the prevalence of each sleep duration variable by age group and race/ethnicity. 

### age_figures.do
•	Plots each sleep duration prevalence by age and race/ethnicity using the estimates obtained by running prevalence_by_age.do

### sensitivity-analysis.do
• Estimates short sleep prevalence for Black individuals and White individuals while accounting for differences in self-reported sleep duration overestimation between the two groups.

## Reference: 
1. Lynn A. Blewett, Julia A. Rivera Drew, Miriam L. King and Kari C.W. Williams. IPUMS Health Surveys: National Health Interview Survey, Version 6.4 [dataset]. Minneapolis, MN: IPUMS, 2019. https://doi.org/10.18128/D070.V6.4 
