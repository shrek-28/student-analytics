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

2. What is the distribution of scores across gender?
````sql
SELECT gender, round(avg(math_score + reading_score + writing_score),2) as avg_score
from student_analytics
group by gender;
````
Result:
| gender | avg_score | 
|-----|-----|
| male | 197.51 |
| female | 208.71 |

3. Distribution of scores across race/ethnicity
````sql
SELECT race, round(avg(math_score + reading_score + writing_score),2) as avg_score
from student_analytics
group by race
order by avg_score;
````
Result: 
| race | avg_score | 
|-----|-----|
| group A | 188.98 |
| group B | 196.41 |
| group C | 201.39 |
| group D | 207.54 |
| group E | 218.26 |

4. Distribution of scores across parental level of education
````sql
SELECT parental_level_of_education as "parental education", round(avg(math_score + reading_score + writing_score),2) as avg_score
from student_analytics
group by "parental education"
order by avg_score;
````
Result: 
| parental education | avg_score | 
|-----|-----|
| high school | 189.29 |
| some high school | 195.32 |
| some college | 205.43 |
| associate's degree | 208.71 |
| bachelor's degree | 215.77 |
| master's degree | 220.80 |

5. Distribution of scores across lunch type
````sql
SELECT lunch, round(avg(math_score + reading_score + writing_score),2) as avg_score
from student_analytics
group by lunch
order by avg_score;
````
Result: 
| lunch | avg_score | 
|-----|-----|
| free/reduced | 186.60 |
| standard | 212.51 |

6. Distribution of Scores across Test Preparation
````sql
SELECT test_preparation_course as test_prep, round(avg(math_score+reading_score+writing_score),2) as avg_score
from student_analytics 
group by test_prep order by avg_score;
````
Result:
| test_prep | avg_score | 
|-----|-----|
| none | 195.12 |
| completed | 218.01 |

7. How does the type of lunch (free/reduced vs. standard) affect student scores in each subject?
````sql
SELECT lunch, round(avg(math_score),2) as math, round(avg(reading_score),2) as reading, 
round(avg(writing_score),2) as writing
from student_analytics 
group by lunch;
````
Result: 
| lunch | math | reading | writing 
|-----|-----|-----|----|
| free/reduced | 59.92 | 64.65 | 63.02 |
| standard | 70.03 | 71.65 | 70.82 |

8. Are there any gender differences in participation in test preparation classes?
````sql
SELECT gender, test_preparation_course, count(test_preparation_course) from student_analytics
group by gender, test_preparation_course
order by count(test_preparation_course);
````
Result: 
| gender | test_preparation_course | count |  
|-----|-----|-----|
| male | completed | 174 | 
| female | completed | 184 | 
| male | none | 308 |
| female | none | 334 | 

9. Is there an interaction effect between gender and parental level of education on student performance?
````sql
SELECT parental_level_of_education as parent_education, gender, round(avg(math_score + reading_score + writing_score),2) as avg_score
from student_analytics
group by parent_education, gender
order by avg_score;
````
Result: 
| parent_education | gender | avg_score |  
|-----|-----|-----|
| high school |male | 184.73 |
|some high school | male |193.91|
| high school | female | 194.24 |
| some high school | female | 196.69 |
| some college | male | 197.15 |
| associate's degree | male | 203.60 |
| bachelor's degree | male | 206.33 |
| some college | female | 213.01 |
| associate's degree | female | 213.37 |
| master's degree | male | 220.57 |
| master's degree | female | 220.94 |
| bachelor's degree | female | 224.92 |

10. Are there any significant differences in performance between different racial/ethnic groups when controlling for parental level of education?
````sql
SELECT parental_level_of_education as parent_education, race, round(avg(math_score + reading_score + writing_score),2) as avg_score
from student_analytics
group by race, parent_education
order by parent_education, race;
````
Result:
| parent_education | race | avg_score |
|-----| ----- | -----|
| associate's degree | group A | 191.64 |
| associate's degree | group B | 203.93 |
| associate's degree | group C | 208.13 |
| associate's degree | group D | 208.00 |
| associate's degree | group E | 221.92 |
| bachelor's degree | group A | 203.58 |
| bachelor's degree | group B | 213.90 |
| bachelor's degree | group C | 219.73 |
| bachelor's degree | group D | 209.61 |
| bachelor's degree | group E | 226.78 |
| high school | group A | 183.73 |
| high school | group B | 184.50 |
| high school | group C | 186.98 |
| high school | group D | 190.43 |
| high school | group E | 208.64 |
| master's degree | group A | 190.00 |
| master's degree | group B | 190.00 |
| master's degree | group C | 190.00 |
| master's degree | group D | 190.00 |
| master's degree | group E | 190.00 |
| some college | group A | 194.67 |
| some college | group B | 193.14 |
| some college | group C | 203.43 |
| some college | group D | 211.31 |
| some college | group E | 216.66 |
| some high school | group A | 179.58 |
| some high school | group B | 192.87 |
| some high school | group C | 189.47 |
| some high school | group D | 205.84 |
| some high school | group E | 208.22 |

11. Are there any correlations between socioeconomic factors (such as parental level of education or lunch type) and student performance across subjects?
````sql
SELECT parental_level_of_education as parent_education, lunch, round(avg(math_score + reading_score + writing_score),2) as avg_score
from student_analytics
group by parent_education, lunch
order by parent_education, lunch;
````
Result:
| parent_education | lunch | avg_score |
|-----| ----- | -----|
| associate's degree | free/reduced | 196.29 |
| associate's degree | standard | 215.30 |
| bachelor's degree | free/reduced | 201.16 |
| bachelor's degree | standard | 223.46 |
| high school | free/reduced | 172.13 |
| high school | standard | 198.83 |
| master's degree | free/reduced | 201.33 |
| master's degree | standard | 234.14 |
| some college | free/reduced | 188.91 |
| some college | standard | 214.31 |
| some high school | free/reduced | 171.67 |
| some high school | standard | 207.55 |

12. Are there any notable differences in performance between genders in specific subject areas (math, reading, writing)?
````sql
SELECT gender, round(avg(math_score),2) as math_avg, 
round(avg(reading_score),2) as read_avg, round(avg(writing_score),2) as write_avg
from student_analytics
group by gender;
````
Result 
|gender | math_avg | read_avg | write_avg |
|-----|-----|-----|-----|
| male | 68.73 | 65.47 | 63.31 |
| female | 63.63 | 72.61 | 72.47 |

13. How do the mean scores in each subject vary over different levels of parental education?
````sql
SELECT parental_level_of_education as parental_education, round(avg(math_score),2) as math_avg, 
round(avg(reading_score),2) as read_avg, round(avg(writing_score),2) as write_avg
from student_analytics
group by parental_education
order by math_avg, read_avg, write_avg;
````
Result:
| parental_education | math_avg | read_avg | write_avg |
|-----|-----|-----|-----|
| high school | 62.14 | 64.70 | 62.45 |
| some high school | 63.50 | 66.94 | 64.89 |
| some college | 67.13 | 69.46 | 68.84 |
| associate's degree | 67.88 | 70.93 | 69.90 |
| bachelor's degree | 69.39 | 73.00 | 73.38 |
| master's degree | 69.75 | 75.37 | 75.68 |

14. Is there a significant difference in scores between students who took test preparation classes and those who didn't?
````sql
SELECT test_preparation_course as test_prep,
round(avg(math_score),2) as math_avg, round(avg(reading_score),2) as read_avg,
round(avg(writing_score),2) as write_avg
from student_analytics
group by test_prep;
````
Result: 
| test_prep | math_avg | read_avg | write_avg |
|-----|-----|-----|-----|
| none | 64.08 | 66.53 | 64.50 |
| completed | 69.70 | 73.89 | 74.42 |

15. How many students fall into each category of parental education level or lunch type?
````sql
SELECT parental_level_of_education as parent_education, count(*)
from student_analytics
group by parent_education order by count(*);
````
Result:
| parent_education | count |
| -----| -----|
| master's degree | 59 |
| bachelor's degree | 118 |
| some high school | 179 |
| high school | 196 |
| associate's degree | 222 |
| some college | 226 |

````sql
SELECT lunch, count(*) from student_analytics group by lunch order by count(*);
````
Result:
| lunch | count |
|------| ------|
| free/reduced | 355 |
| standard | 645 |

16. How many students scored above average in math, reading, or writing?
````sql
SELECT 'Math' AS subject, COUNT(*) AS num_students_above_avg
FROM student_analytics WHERE math_score > (select avg(math_score) from student_analytics)
UNION ALL
SELECT 'Reading' AS subject, COUNT(*) AS num_students_above_avg FROM student_analytics
WHERE reading_score > (select avg(reading_score) from student_analytics)
UNION ALL
SELECT 'Writing' AS subject, COUNT(*) AS num_students_above_avg
FROM student_analytics WHERE writing_score > (select avg(writing_score) from student_analytics);
````
Result:
| subject | num_students_above_avg |
| -----| ------ |
| Math | 493 |
| Reading | 513 |
| Writing | 512 |

17. How many students took test preparation classes?
````sql
SELECT test_preparation_course as test_prep, COUNT(*) from student_analytics
group by test_preparation_course;
````
Result:
| test_prep | count |
| ----- | ----- |
| none | 642 |
| completed | 358 |

18. How do math, reading, and writing scores differ between genders?
````sql
SELECT gender, round(avg(math_score),2) as math_avg, 
round(avg(reading_score),2) as read_avg, round(avg(writing_score),2) as write_avg
from student_analytics
group by gender;
````
RESULT: 
| gender | math_avg | read_avg | write_avg |
| ----- | ----- | ----- | ----- |
| male | 68.73 | 65.47 | 63.31 |
| female | 63.63 | 72.61 | 72.47 |

20. How do math, reading, and writing scores differ between races/ethnicities?
````sql
SELECT race, round(avg(math_score),2) as math_avg, 
round(avg(reading_score),2) as read_avg, round(avg(writing_score),2) as write_avg
from student_analytics
group by race order by math_avg, read_avg, write_avg;
````
Result:
| race | math_avg | read_avg | write_avg |
| ----- |-----|-----|------|
| group A | 61.63 | 64.67 | 62.67 |
| group B | 63.45 | 67.35 | 65.60 |
| group C | 64.46 | 69.10 | 67.83 |
| group D | 67.36 | 70.03 | 70.15 |
| group E | 73.82 | 73.03 | 71.41 |

21. How do math, reading, and writing scores differ between parental education levels?
````sql
SELECT parental_level_of_education as parent_education, round(avg(math_score),2) as math_avg, 
round(avg(reading_score),2) as read_avg, round(avg(writing_score),2) as write_avg
from student_analytics
group by parent_education order by math_avg, read_avg, write_avg;
````
Result: 
| parent_education | math_avg | read_avg | write_avg |
| ----- | ----- | ----- | ----- |
| high school | 62.14 | 64.70 | 62.45 |
| some high school | 63.50 | 66.94 | 64.89 |
| some college | 67.13 | 69.46 | 68.84 |
| associate's degree | 67.88 | 70.93 | 69.90 |
| bachelor's degree | 69.39 | 73.00 | 73.38 |
| master's degree | 69.75 | 75.37 | 75.68 |

22. How do math, reading, and writing scores differ between lunch?
````sql
SELECT lunch, round(avg(math_score),2) as math_avg, 
round(avg(reading_score),2) as read_avg, round(avg(writing_score),2) as write_avg
from student_analytics
group by lunch;
````
Result: 
|lunch | math_avg | read_avg | write_avg| 
| ----- | ----- | ----- | ----- |
| free/reduced | 58.92 | 64.65 | 63.02 |
| standard | 70.03 | 71.65 | 70.82 |

23. How many students fall into each category of parental education level or lunch type?
````sql
SELECT parental_level_of_education, lunch, COUNT(*) as count from student_analytics
group by parental_level_of_education, lunch order by parental_level_of_education, lunch;
````
Result: 
|parental_level_of_education | lunch | count |
| ----- | ----- | -----| 
| associate's degree | free/reduced | 77 |
| associate's degree | standard | 145 |
| bachelor's degree | free/reduced | 44 |
| bachelor's degree | standard | 74 |
| high school | free/reduced | 70 |
| high school | standard | 126 |
| master's degree | free/reduced | 24 |
| master's degree | standard | 35 |
| some college | free/reduced | 79 |
| some college | standard | 147 |
| some high school | free/reduced | 61 |
| some high school | standard | 118 |

````sql
SELECT parental_level_of_education as parent_education, count(*) from student_analytics 
group by parent_education;
````
Result: 
| parent_education | count | 
| ----- | ----- |
| master's degree | 59 |
| some college | 226 |
| bachelor's degree | 118 |
| high school | 196 |
| associate's degree | 222 |
| some high school | 179|

````sql
SELECT lunch, count(*) from student_analytics group by lunch;
````
Result:
| lunch | count |
| ----- | ----- |
| free/reduced | 355 |
| standard | 645 |

24. Number of Students who took test preparation classes, compared to lunch
````sql
SELECT test_preparation_course, lunch, count(*) from student_analytics
group by test_preparation_course, lunch;
````
Result:
| test_preparation_course | lunch | count |
| ----- | ----- | ---- |
| none | standard | 418 |
| completed | standard | 227 |
| none | free/reduced | 224 |
| completed | free/reduced | 131 |

25. Is the effect of test preparation classes on math scores the same for students with different parental education levels? (This involves analyzing subgroups within the data)
````sql
SELECT test_preparation_course as test_prep, parental_level_of_education as parent_education, 
round(AVG(math_score),2) from student_analytics
group by parent_education, test_prep;
````
Result:
| test_prep | parent_education | round |
| ----- | ----- | ------ |
| completed | bachelor's degree | 73.28 |
| none | high school | 60.99 |
| completed | some high school | 66.70 |
| completed | associate's degree | 71.83 |
| completed | master's degree | 70.60 |
| completed | high school | 65.00 |
| none | some college | 64.89 |
| none | master's degree | 69.31 |
| none | bachelor's degree | 66.90 |
| none | associate's degree| 65.57 |
| none | some high school | 61.08 |
| completed | some college | 71.45 |
