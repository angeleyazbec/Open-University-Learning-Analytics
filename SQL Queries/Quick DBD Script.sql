courses
-
code_mod_pres PK string
module_presentation_length string

studentInfo
-
code_mod_pres string FK >- courses.code_mod_pres
id_student PK int
gender string
region string
highest_education string
imd_band string
age_band string
num_of_previous_attempts int
studied_credits int
disability string
final_results string

assessments
--
code_mod_pres string FK >- courses.code_mod_pres
id_assessment PK string
assessment_type string
date FLOAT
weight FLOAT

vle
--
id_site PK int,
code_mod_pres string FK >- courses.code_mod_pres
activity_type string
week_from float
week_to float

studentAssessment
--
id_assessment int FK >- assessments.id_assessment
id_student int FK >- studentInfo.id_student
date_submitted int
is_banked int
score float

studentRegistration
--
code_mod_pres string FK >- courses.code_mod_pres
id_student int FK >- studentInfo.id_student
date_registration float
date_unregistration float

studentVle
--
code_mod_pres string FK >- courses.code_mod_pres
id_student int FK >- studentInfo.id_student
id_site int FK >- vle.id_site
date float
sum_click float 

