<h1> 📓๋ Student Analytics </h1>
This project done using PGAdmin and PostgreSQL, analyses the effect of various factors on student scores in reading, math and writing. 

## 📚 Table of Contents
- [Dataset Details](#Dataset-Details)
- [Creating the table and Loading the Dataset](#Creating-the-table-and-Loading-the-Dataset)
- [Database Analytics](#Database-Analytics)

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
| Gender | Race | Parental_level_of_education | lunch | test_preparation_course | math_score | reading_score | writing_score
| ---- | ----- | ----- | ----- | ------ | ----- | -----| -----|
|female | group B | bachelor's degree | standard |none | 72 | 72 | 74 |
|female | group C| some college | standard | completed | 69 | 90 | 88 |
|female | group B | master's degree | standard |none | 90 | 95 | 93 |
| male | group A | associate's degree | free/reduced |none | 47 | 57 | 44 |
| male | group c | some degree | standard |none | 76 | 78 | 75 |

# Database Analytics

1. What is the average math, reading, and writing score?
````sql
SELECT round(avg(math_score),2) as avg_math_score, 
round(avg(reading_score),2) as avg_reading_score,
round(avg(writing_score),2) as avg_writing_score 
FROM student_analytics;
````
Result: 
| avg_math_score | avg_reading_score | avg_writing_score |
|-----|------|-----|
|66.09 | 69.17 | 68.05 |
2. 
3. 
