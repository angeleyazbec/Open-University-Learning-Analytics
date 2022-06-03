--Creating the database schema with the appropriate relationships, primary keys, foreign keys, and constraints.
--Tables are listed in the order in which data need to be imported to align with the constraints. 

--Inserting "courses" table
CREATE TABLE courses (
module_presentation_length INT,
code_mod_pres VARCHAR(20) PRIMARY KEY
);

--Inserting "student_info" table
CREATE TABLE student_info (
id_student INT,
gender VARCHAR(3),
region VARCHAR(100),
highest_education VARCHAR(100),
imd_band VARCHAR(100),
age_band VARCHAR(20),
num_of_prev_attempts INT,
studied_credits INT,
disability VARCHAR(3),
final_result VARCHAR(20),
code_mod_pres VARCHAR(20),
unique_identifier VARCHAR(20) PRIMARY KEY,
FOREIGN KEY (code_mod_pres) REFERENCES courses(code_mod_pres)
);

--Inserting "assessments" table
CREATE TABLE assessments (
id_assessment INT PRIMARY KEY,
assessment_type VARCHAR(5),
date FLOAT,
weight FLOAT,
code_mod_pres VARCHAR(20),
FOREIGN KEY (code_mod_pres) REFERENCES courses(code_mod_pres)
);

--Inserting "vle" table
CREATE TABLE vle (
id_site INT PRIMARY KEY,
activity_type VARCHAR(25),
week_from FLOAT,
week_to FLOAT,
code_mod_pres VARCHAR(20),
FOREIGN KEY (code_mod_pres) REFERENCES courses(code_mod_pres)
);

--Inserting "student_assessment" table
CREATE TABLE student_assessment(
id_assessment INT,
id_student INT,
date_submitted INT,
is_banked INT,
score FLOAT,
FOREIGN KEY (id_assessment) REFERENCES assessments(id_assessment)
);

--Inserting "student_registration" table
CREATE TABLE student_registration (
code_mod_pres VARCHAR(20),
date_registration FLOAT,
date_unregistration FLOAT,
id_student INT,
unique_identifier VARCHAR(20),
FOREIGN KEY (unique_identifier) REFERENCES student_info(unique_identifier),
FOREIGN KEY (code_mod_pres) REFERENCES courses(code_mod_pres)
);

--Inserting "student_vle" table
CREATE TABLE student_vle (
id_student INT,
id_site INT,
date FLOAT,
sum_click FLOAT,
code_mod_pres VARCHAR(20),
unique_identifier VARCHAR(20),
FOREIGN KEY (unique_identifier) REFERENCES student_info(unique_identifier),
FOREIGN KEY (id_site) REFERENCES vle(id_site),
FOREIGN KEY (code_mod_pres) REFERENCES courses(code_mod_pres)
);

