# Open-University-Learning-Analytics

### Source

I initially found this dataset on Kaggle, but found the source website for reference as well. The website included a nice codebook to help me, as a secondary user, undertand the data included.

https://analyse.kmi.open.ac.uk/open_dataset#about


#### Data Modeling

Schema (ERD) of data tables in PostgreSQL database.

![image](https://user-images.githubusercontent.com/90559756/173630944-2d4ecf04-a9e2-40f2-babd-38df781310e8.png)


#### Data Engineering

Specifying data types, primary keys, foreign keys, and other constraints. Data loaded through Python script. An example table schematic is listed below.

![image](https://user-images.githubusercontent.com/90559756/173631098-744440e1-b801-4bc6-a448-f2ab28ed05f9.png)

#### SQL Queries

1. Querying the assessments types

   a. Used SELECT DISTINCT statement to select the unique assessment types.
   
   b. Query listed below.

	SELECT DISTINCT assessment_type
	FROM assessments;

2. Querying course information

   a. Used SELECT statement to select all information from courses table.
   
   b. Query listed below.

	SELECT * FROM courses;

3. Query to see entire student_info table

	SELECT * FROM student_info;

4. Querying students with one or more previous attempt.

   a. Used "SELECT" statement to select relevant information from teh student_info table.
   
   b. Used "WHERE" clause to filter data to students who had have more than one previous attempt.
   
   c. Used "ORDER BY" clause to sort number of previous attempts in ascending order.
   
   d. Query listed below.

	SELECT id_student, gender, region, highest_education, age_band, num_of_prev_attempts, code_mod_pres
	FROM student_info 
	WHERE num_of_prev_attempts > 0
	ORDER BY num_of_prev_attempts ASC;

5. Creating a view with self joining assessment tables

   a. Used aliases for table names to simplify the command.
   
   b. Combined student_assessment and assessments tables to merge the tables (on id_assessment).
   
   c. Selected the relevant data.
   
   d. Query listed below.

	CREATE VIEW combined_assessment AS
	SELECT S.id_student, S.score, S.id_assessment, A.assessment_type, A.code_mod_pres
	FROM student_assessment S, assessments A
	WHERE S.id_assessment = A.id_assessment;

6. Query the view for successful creation

	SELECT * FROM combined_assessment;

7. Creating a view with inner joining student and student vle

   a. Used "INNER JOIN" clause to join the tables on unique_identifier.
   
   b. Selected relevant data from each table.
   
   c. Query listed below.

	CREATE VIEW student_info_vle AS
	SELECT student_info.unique_identifier, student_info.id_student, student_info.code_mod_pres, id_site
	FROM student_info
	INNER JOIN student_vle
	ON student_info.unique_identifier = student_vle.unique_identifier;
	
8. Query the view for successful creation
  
	SELECT * FROM student_info_vle;

9. Creating a view combining the previous two joins

   a. Used aliases for table names to simplify the command.
   
   b. Combined student_courses and combined_assessments tables to merge the data with the relevant data.

	CREATE VIEW student_scores AS
	SELECT C.unique_identifier, C.id_student, C.code_mod_pres,
	FROM student_courses C, combined_assessments CA
	WHERE C.code_mod_pres = A. code_mod_pres; 
	SELECT S.id_student, S.score, S.id_assessment, A.assessment_type, A.code_mod_pres

10. Query student activity in vle for students who passed using a series of sub-queries.

   a. Created series of queries to navigate through tables to obtain vle activity for students who passed their course.
   
   b. Query listed below.

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

11. Count the number of students in each final_result category

   a. Used "COUNT" function to count the number of students, by the student_id so we can have all instances of their final results across courses.
   
   b. Used "GROUP BY" clause to group the results by the number of students so we can quickly see how many students are in each category.
   
   b. Query listed below.

	SELECT COUNT(id_student), final_result
	FROM student_info
	GROUP BY final_result;

12. Count the number of students by region

   a. Used "COUNT" operator to count the number of students in each region.
   
   b. Used "GROUP BY" clause to group the results by region.
   
   c. Query listed below.

	SELECT COUNT(unique_identifier), region
	FROM student_info
	GROUP BY region;

### Conclusions and Lessons Learned

1. Data wrangling is absolutely essentially for prior to import into relation databases (or any project, as a matter of fact). Relational databases, such as PostgreSQL, require schemas that follow all constriants with data keys, primary keys, and foreign keys. I ended up created some unique indetifiers for some of the tables to ensure that primary keys would, in fact, be unique across each observation. For student_info, I realized that the same student ID numbers were listed multiple times; however, if I combined the student ID number with the course code and when the module was presented (code_mod_pres), then I would have a unique identifier necessary for a primary key. 

2. Schematic design is essential! Going along with my previous comment about data wrangling, I spent quite some time designing the database in my PostgreSQL server and making sure the relations between the tables were logical. Spending this time substaintially helped me design effective SQL queries.

3. It may be worth repeating this exercise in a NoSQL database to compare the flexibility of the databases and ease of queries. I am also working through a machine learning model on student outcomes. I will add more on that when it is ready.
