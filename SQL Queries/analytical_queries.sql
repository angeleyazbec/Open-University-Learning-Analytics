--Querying the assessments types
SELECT DISTINCT assessment_type
FROM assessments;

--Querying coure information about the  courses
SELECT * FROM courses;

-- Command to see entire student_info table
--SELECT * FROM student_info;

-- Querying students with one or more previous attempt
SELECT id_student, gender, region, highest_education, age_band, num_of_prev_attempts, code_mod_pres
FROM student_info 
WHERE num_of_prev_attempts > 0
ORDER BY id_student ASC;

--Creating a view with self joining assessment tables
CREATE VIEW combined_assessment AS
SELECT S.id_student, S.score, S.id_assessment, A.assessment_type, A.code_mod_pres
FROM student_assessment S, assessments A
WHERE S.id_assessment = A.id_assessment;

--Query the view for successful creation
SELECT * FROM combined_assessment;

--Creating a view with inner joining student and student vle
CREATE VIEW student_info_vle AS
SELECT student_info.unique_identifier, student_info.id_student, student_info.code_mod_pres, id_site
FROM student_info
INNER JOIN student_vle
ON student_info.unique_identifier = student_vle.unique_identifier;

--Query the view for successful creation
SELECT * FROM student_info_vle;

--Creating a view combining the previous two joins
CREATE VIEW student_scores AS
SELECT C.unique_identifier, C.id_student, C.code_mod_pres,
FROM student_courses C, combined_assessments CA
WHERE C.code_mod_pres = A. code_mod_pres; 
SELECT S.id_student, S.score, S.id_assessment, A.assessment_type, A.code_mod_pres

--Query student activity in vle for students who passed
SELECT activity_type
FROM vle
WHERE id_site
IN (
	--Query student_vle table
	SELECT id_site
	FROM student_vle
	WHERE unique_identifier
	IN (
		--Query student_info table
		SELECT unique_identifier
		FROM student_info
		WHERE final_result LIKE 'Pass'));

-- Count the number of students in each final_result category
SELECT COUNT(unique_identifier), final_result
FROM student_info
GROUP BY final_result;

--Count the number of students by region
SELECT COUNT(unique_identifier), region
FROM student_info
GROUP BY region;