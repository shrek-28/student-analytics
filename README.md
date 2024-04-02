<h1> 📓๋ Student Analytics </h1>
This project done using PGAdmin and PostgreSQL, analyses the effect of various factors on student scores in reading, math and writing. 

## 📚 Table of Contents
- [Dataset Details](#Dataset-Details)
- [Creating the table and Loading the Dataset](#Creating-the-table-and-Loading-the-Dataset)

# Dataset Details 
- The Dataset has 1000 rows, and eight columns: race, gender/ethnicity, parental level of education, lunch, test preparation course, math score, reading score and writing score.
- Various factors, and their cumulative and individual effects on average student and individual student scores.

# Creating the table and Loading the Dataset
Command used for creating the table:
````sql
CREATE TABLE "Student Analytics"(
gender varchar(100),
race varchar(100),
parental_level_of_education varchar(100),
	lunch varchar(100),
	test_preparation_course varchar(100),
	"math score" int, 
	"reading score" int,
	"writing score" int
);

````
The dataset was loaded into the table by usage of the PGAdmin Import tool.  

An overview of the dataset was loaded using the following command:
````sql
SELECT * FROM student_analytics LIMIT 5;
````
result:
| customer_id | total_points | 
| ----------- | ---------- |
| A           | 1370 |
| B           | 820 |
| A           | 1020 |
| B           | 320 |
