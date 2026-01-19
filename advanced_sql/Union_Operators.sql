-- Using UNION operator to combine results from multiple tables of job postings for each month jan-march:-
SELECT 
    job_title_short,
    company_id,
    job_location
FROM january_jobs

UNION -- to combine the results of both the select statements mentioned (after ensuring both our SELECT statements have same no. of columns and same datatypes for each)

SELECT 
    job_title_short,
    company_id,
    job_location
FROM february_jobs

UNION -- to combine the result of all three select statements mentioned (after ensuring all 3 of our SELECT statements have same no. of columns and same datatypes for each)

SELECT 
    job_title_short,
    company_id,
    job_location
FROM march_jobs;

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--UNION ALL can also be used to include duplicate records in the final result set:-
SELECT 
    job_title_short,
    company_id,
    job_location
FROM january_jobs

UNION ALL -- to combine the results of both the select statements mentioned (after ensuring both our SELECT statements have same no. of columns and same datatypes for each)

SELECT 
    job_title_short,
    company_id,
    job_location
FROM february_jobs

UNION ALL-- to combine the result of all three select statements mentioned (after ensuring all 3 of our SELECT statements have same no. of columns and same datatypes for each)

SELECT 
    job_title_short,
    company_id,
    job_location
FROM march_jobs;

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
/* PQ8:-
Find job postings from the first quarter that have a salary greater than $70,000
- Combine job postings table for each month mentioned in the first quarter with already made up tables (January, February, March).
- Make sure that the job postings includejobs with annual salary of more than $70,000.
- Make sure no duplicate jobs are removed.
*/
SELECT *
FROM january_jobs
WHERE salary_year_avg >= 70000

UNION ALL -- to combine the results of both the select statements mentioned (after ensuring both our SELECT statements have same no. of columns and same datatypes for each)

SELECT *
FROM february_jobs
WHERE salary_year_avg >= 70000


UNION ALL -- to combine the result of all three select statements mentioned (after ensuring all 3 of our SELECT statements have same no. of columns and same datatypes for each)

SELECT *
FROM march_jobs
WHERE salary_year_avg >= 70000;

-- Same answer using a subquery approach , for columns of interest:-
SELECT  
    qtr1_job_postings.job_title_short,
    qtr1_job_postings.company_id,
    qtr1_job_postings.job_location,
    qtr1_job_postings.salary_year_avg
FROM (
    SELECT *
    FROM january_jobs

    UNION ALL -- to combine the results of both the select statements mentioned (after ensuring both our SELECT statements have same no. of columns and same datatypes for each)

    SELECT *
    FROM february_jobs

    UNION ALL -- to combine the result of all three select statements mentioned (after ensuring all 3 of our SELECT statements have same no. of columns and same datatypes for each)

    SELECT *
    FROM march_jobs

) AS qtr1_job_postings
WHERE
    qtr1_job_postings.salary_year_avg >= 70000;

-- cte approach:-
WITH qtr1_job_postings AS (

    SELECT *
    FROM january_jobs

    UNION ALL -- to combine results of both the SELECT row values mentioned for both the tables i.e jan & feb

    SELECT * 
    FROM february_jobs

    UNION ALL -- to combine the results of all 3 tables' SELECT row values jan, feb & mar

    SELECT *
    FROM march_jobs
)
SELECT  
    job_title_short,
    company_id,
    job_location,
    salary_year_avg
FROM 
    qtr1_job_postings
WHERE
    salary_year_avg >= 70000;

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Extending the previous query to include company name from company_dim table by joining it with the subquery result:-
SELECT  
    qtr1_job_postings.job_title_short,
    qtr1_job_postings.company_id,
    c.name AS company_name,
    qtr1_job_postings.job_location,
    qtr1_job_postings.salary_year_avg
FROM (
    SELECT *
    FROM january_jobs

    UNION ALL -- to combine the results of both the select statements mentioned (after ensuring both our SELECT statements have same no. of columns and same datatypes for each)

    SELECT *
    FROM february_jobs

    UNION ALL -- to combine the result of all three select statements mentioned (after ensuring all 3 of our SELECT statements have same no. of columns and same datatypes for each)

    SELECT *
    FROM march_jobs
) AS qtr1_job_postings
JOIN 
    company_dim AS c ON qtr1_job_postings.company_id = c.company_id
WHERE
    qtr1_job_postings.salary_year_avg >= 70000
ORDER BY
    qtr1_job_postings.salary_year_avg DESC;
