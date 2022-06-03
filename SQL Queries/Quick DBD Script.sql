courses
-
code_mod_pres PK string
module_presentation_length string

studentInfo
-
unique_identifier PK string
id_student int
gender string
region string
highest_education string
imd_band string
age_band string
num_of_previous_attempts int
studied_credits int
disability string
final_results string
code_mod_pres string FK >- courses.code_mod_pres


assessments
--
id_assessment PK string
assessment_type string
date FLOAT
weight FLOAT
code_mod_pres string FK >- courses.code_mod_pres

vle
--
id_site PK int,
activity_type string
week_from float
week_to float
code_mod_pres string FK >- courses.code_mod_pres

studentAssessment
--
id_assessment int FK >- assessments.id_assessment
id_student int
date_submitted int
is_banked int
score float

studentRegistration
--
code_mod_pres string FK >- courses.code_mod_pres
date_registration float
date_unregistration float
id_student int
unique_identifier string FK >- studentInfo.unique_identifier

studentVle
--
code_mod_pres string FK >- courses.code_mod_pres
unique_identifier string FK >- studentInfo.unique_identifier
id_student int
id_site int FK >- vle.id_site
date FLOAT
sum_click FLOAT




