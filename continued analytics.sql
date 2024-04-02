/* What is the average math, reading, and writing score? */
SELECT round(avg(math_score),2) as avg_math_score, 
round(avg(reading_score),2) as avg_reading_score,
round(avg(writing_score),2) as avg_writing_score 
FROM student_analytics;

/*What is the distribution of scores across gender, race/ethnicity, parental level of education, and lunch type? */
SELECT gender, round(avg(math_score + reading_score + writing_score),2) as avg_score
from student_analytics
group by gender;

/* Distribution of scores across race/ethnicity */
SELECT race, round(avg(math_score + reading_score + writing_score),2) as avg_score
from student_analytics
group by race
order by avg_score;

/* Distribution of scores across parental level of education*/
SELECT parental_level_of_education as "parental education", round(avg(math_score + reading_score + writing_score),2) as avg_score
from student_analytics
group by "parental education"
order by avg_score;

/*distribution across lunch type */
SELECT lunch, round(avg(math_score + reading_score + writing_score),2) as avg_score
from student_analytics
group by lunch
order by avg_score;

/* test preparation */
SELECT test_preparation_course as test_prep, round(avg(math_score+reading_score+writing_score),2) as avg_score
from student_analytics 
group by test_prep order by avg_score;

/* How does the type of lunch (free/reduced vs. standard) affect student scores in each subject? */
SELECT lunch, round(avg(math_score),2) as math, round(avg(reading_score),2) as reading, 
round(avg(writing_score),2) as writing
from student_analytics 
group by lunch;

/*Are there any gender differences in participation in test preparation classes? */
SELECT gender, test_preparation_course, count(test_preparation_course) from student_analytics
group by gender, test_preparation_course
order by count(test_preparation_course);

/* Is there an interaction effect between gender and parental level of education on student performance? */
SELECT parental_level_of_education as parent_education, gender, round(avg(math_score + reading_score + writing_score),2) as avg_score
from student_analytics
group by parent_education, gender
order by avg_score;

/* Are there any significant differences in performance between different racial/ethnic groups when controlling for parental level of education? */
SELECT parental_level_of_education as parent_education, race, round(avg(math_score + reading_score + writing_score),2) as avg_score
from student_analytics
group by race, parent_education
order by parent_education, race;

/* Are there any correlations between socioeconomic factors (such as parental level of education or lunch type) and student performance across subjects? */
SELECT parental_level_of_education as parent_education, lunch, round(avg(math_score + reading_score + writing_score),2) as avg_score
from student_analytics
group by parent_education, lunch
order by parent_education, lunch;

/* Are there any notable differences in performance between genders in specific subject areas (math, reading, writing)? */
SELECT gender, round(avg(math_score),2) as math_avg, 
round(avg(reading_score),2) as read_avg, round(avg(writing_score),2) as write_avg
from student_analytics
group by gender;

/*How do the mean scores in each subject vary over different levels of parental education? */
SELECT parental_level_of_education as parental_education, round(avg(math_score),2) as math_avg, 
round(avg(reading_score),2) as read_avg, round(avg(writing_score),2) as write_avg
from student_analytics
group by parental_education
order by math_avg, read_avg, write_avg;

/* Is there a significant difference in scores between students who took test preparation classes and those who didn't? */
SELECT test_preparation_course as test_prep,
round(avg(math_score),2) as math_avg, round(avg(reading_score),2) as read_avg,
round(avg(writing_score),2) as write_avg
from student_analytics
group by test_prep;

/* How many students fall into each category of parental education level or lunch type? */
SELECT parental_level_of_education as parent_education, count(*)
from student_analytics
group by parent_education order by count(*);

SELECT lunch, count(*) from student_analytics group by lunch order by count(*);

/* How many students scored above average in math, reading, or writing? */
SELECT 'Math' AS subject, COUNT(*) AS num_students_above_avg
FROM student_analytics WHERE math_score > (select avg(math_score) from student_analytics)
UNION ALL
SELECT 'Reading' AS subject, COUNT(*) AS num_students_above_avg FROM student_analytics
WHERE reading_score > (select avg(reading_score) from student_analytics)
UNION ALL
SELECT 'Writing' AS subject, COUNT(*) AS num_students_above_avg
FROM student_analytics WHERE writing_score > (select avg(writing_score) from student_analytics);

/* How many students took test preparation classes? */
SELECT test_preparation_course as test_prep, COUNT(*) from student_analytics
group by test_preparation_course;

/* How do math, reading, and writing scores differ between genders, races/ethnicities, parental education levels, and lunch types? */
/* Across genders */
SELECT gender, round(avg(math_score),2) as math_avg, 
round(avg(reading_score),2) as read_avg, round(avg(writing_score),2) as write_avg
from student_analytics
group by gender;

/* Across races/ethnicities */
SELECT race, round(avg(math_score),2) as math_avg, 
round(avg(reading_score),2) as read_avg, round(avg(writing_score),2) as write_avg
from student_analytics
group by race order by math_avg, read_avg, write_avg;

/* Across parental education levels */
SELECT parental_level_of_education as parent_education, round(avg(math_score),2) as math_avg, 
round(avg(reading_score),2) as read_avg, round(avg(writing_score),2) as write_avg
from student_analytics
group by parent_education order by math_avg, read_avg, write_avg;

/* Across Lunch Types */
SELECT lunch, round(avg(math_score),2) as math_avg, 
round(avg(reading_score),2) as read_avg, round(avg(writing_score),2) as write_avg
from student_analytics
group by lunch;

/* How many students fall into each category of parental education level or lunch type? */
SELECT parental_level_of_education, lunch, COUNT(*) as count from student_analytics
group by parental_level_of_education, lunch order by parental_level_of_education, lunch;

SELECT parental_level_of_education as parent_education, count(*) from student_analytics 
group by parent_education;

SELECT lunch, count(*) from student_analytics group by lunch;

/* Number of Students who took test preparation classes, compared to lunch */
SELECT test_preparation_course, lunch, count(*) from student_analytics
group by test_preparation_course, lunch;

/* Is the effect of test preparation classes on math scores the same for students with different parental education levels? (This involves analyzing subgroups within the data) */
SELECT test_preparation_course as test_prep, parental_level_of_education as parent_education, 
round(AVG(math_score),2) from student_analytics
group by parent_education, test_prep;