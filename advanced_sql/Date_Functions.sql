/* A query to convert a string type data to their
 permittable datatypes when removing their '' which 
 specifies their string data type */
SELECT 
    '2026-01-01' :: DATE,
    '123' :: INT,
    'true' :: BOOLEAN,
    '123.45' :: REAL;

/* now we try this on our actual database table of job_postings_fact table , using our 
specific column of 'job_posted_date' since it is a TIMESTAMP type value (date related) :-  */
SET TIME ZONE 'Asia/Kolkata'; -- setting the timezone to UTC , i.e the now resulting time will be resulted in an UTC set clock's format
SELECT
    job_id,
    job_title_short AS title,
    job_location AS location,   
    job_posted_date :: DATE as date,
    job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'UTC' AS date_time
FROM
    job_postings_fact
LIMIT 5;
RESET TIME ZONE; -- resetting the timezone to default database timezone

/* Now we use the EXTRACT() to extract the Date components like year/month/day in numeric format from the date value.
The significance of these values is that we can group a lot of rows on the basis of these date groups and perform analysis
on them. Eg :- Query to find no. of jobs posted  on the basis of Months */
SELECT
    COUNT(job_id) AS job_count,
    EXTRACT(MONTH FROM job_posted_date) AS job_month
FROM
    job_postings_fact
GROUP BY
    job_month
ORDER BY
    job_count DESC;

/* 
PQ1:- Query to find their job count, avg_annual_salary and avg_hourly_salary for job postings after 1 june 2023 :-
*/
SELECT
    COUNT(job_id) AS job_count,
    AVG(salary_year_avg) AS avg_annual_salary,
    AVG(salary_hour_avg) AS avg_hourly_salary
FROM
    job_postings_fact
WHERE
    job_posted_date > '2023-06-01';
/* 
PQ2:- Query to find their job count for each month in 2023 , finding the job_posted_Date in 'America/New_York'
 time value , while considering the timestamp value originally being in the UTC format :-
*/
--Query 1:-(job_count by month for 2023)
SELECT
    EXTRACT(MONTH FROM job_posted_date) AS job_month,
    COUNT(job_id) AS job_count
FROM
    job_postings_fact
WHERE
    EXTRACT(YEAR FROM job_posted_date) = '2023'
GROUP BY
    job_month
ORDER BY
    job_count DESC;

--Query 2:-(job_ids by their job_posted timestamp according to the specified format)
SET TIME ZONE 'America/New_York'; -- this will ensure our timestamptz (recently converted from timestamp) will be shown in America/New_York or EST clock format
SELECT
    job_id,
    job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'America/New_York'
FROM
    job_postings_fact
LIMIT 10;
/* 
PQ3:- job_ids which offer health insurance
 and which were posted in the 2nd quarter of 2023 
*/
SELECT 
    COUNT(job_id) AS job_count,
    EXTRACT(QUARTER FROM job_posted_date) AS job_quarter,
    EXTRACT(YEAR FROM job_posted_date) AS job_year
FROM
    job_postings_fact
WHERE
    job_health_insurance IS TRUE
    AND EXTRACT(QUARTER FROM job_posted_date) = 2
    AND EXTRACT(YEAR FROM job_posted_date) = 2023
GROUP BY
    job_quarter,
    job_year;

RESET TIME ZONE; -- resetting the timezone to default database timezone