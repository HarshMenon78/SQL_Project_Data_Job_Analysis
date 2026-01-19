/* PQ6:-
Here for our new tables to be created for 3 months of Jan, feb and march for displaying their own 
specific job postings we are using the special statement of 'CREATE TABLE...AS SELECT' , which 
will create table and immediately fill it with values as mentioned in the SELECT clause.
*/

--Creating a table for jobs posted in january:-
CREATE TABLE january_jobs AS
SELECT *
FROM job_postings_fact
WHERE EXTRACT(MONTH FROM job_posted_date) = 1;

--Creating a table for jobs posted in february:-
CREATE TABLE february_jobs AS
SELECT *
FROM job_postings_fact
WHERE EXTRACT(MONTH FROM job_posted_date) = 2;

--Creating a table for jobs posted in march:-
CREATE TABLE march_jobs AS
SELECT *
FROM job_postings_fact
WHERE EXTRACT(MONTH FROM job_posted_date) = 3;

--Verifying the created tables by displaying few records from each of them:-
SELECT * FROM january_jobs
LIMIT 5;

SELECT * FROM february_jobs
LIMIT 5;

SELECT * FROM march_jobs
LIMIT 5;