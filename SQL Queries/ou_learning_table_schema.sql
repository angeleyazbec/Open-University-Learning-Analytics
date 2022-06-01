--Creating the database schema with the appropriate relationships, primary keys, foreign keys, composite keys,
--and constraints.
--Tables are listed in the order in which data need to be imported to align with the constraints. 

--Inserting "courses" table
CREATE TABLE courses (
code_mod_pres VARCHAR(15) PRIMARY KEY,
module_presentation_length INT
);

--Inserting "studentInfo" table
CREATE TABLE studentInfo (
code_mod_pres VARCHAR(15),
id_student INT PRIMARY KEY,
gender VARCHAR(3),
region VARCHAR(100),
highest_education VARCHAR(100),
imd_band VARCHAR(100),
age_band VARCHAR(20),
num_of_previous_attempts INT,
studied_credits INT,
disability VARCHAR(3),
final_results VARCHAR(20),
FOREIGN KEY (code_mod_pres) REFERENCES courses(code_mod_pres)
);

--Inserting "assessments" table
CREATE TABLE assessments(
code_mod_pres VARCHAR(15),
id_assessment INT PRIMARY KEY,
assessment_type VARCHAR(5),
date FLOAT,
weight FLOAT,
FOREIGN KEY (code_mod_pres) REFERENCES courses(code_mod_pres)
);

--Inserting "vle" table
CREATE TABLE vle (
id_site INT PRIMARY KEY,
code_mod_pres VARCHAR(15),
activity_type VARCHAR(25),
week_from FLOAT,
week_to FLOAT,
FOREIGN KEY (code_mod_pres) REFERENCES courses(code_mod_pres)
);

--Inserting "studentAssessment" table
CREATE TABLE studentAssessment(
date_submitted INT,
is_banked INT,
score FLOAT,
id_assessment INT,
id_student INT,
FOREIGN KEY (id_assessment) REFERENCES assessments(id_assessment),
FOREIGN KEY (id_student) REFERENCES studentInfo(id_student)
);

--Inserting "studentRegistration" table
CREATE TABLE studentRegistration (
code_mod_pres VARCHAR(15),
date_registration FLOAT,
date_unregistration FLOAT,
id_student INT,
FOREIGN KEY (id_student) REFERENCES studentInfo(id_student),
FOREIGN KEY (code_mod_pres) REFERENCES courses(code_mod_pres)
);

--Inserting "studentVle" table
CREATE TABLE studentVle (
code_mod_pres VARCHAR(15),
date FLOAT,
sum_click FLOAT,
id_student INT,
id_site INT,
FOREIGN KEY (id_student) REFERENCES studentInfo(id_student),
FOREIGN KEY (id_site) REFERENCES vle(id_site),
FOREIGN KEY (code_mod_pres) REFERENCES courses(code_mod_pres)
);

