/*
Problem 1 : What are the top paying data analyst jobs posted:
- Identify the top 10 highest paying data analyst job postings , which are available remotely.
- Focuses on jobs with specific salaries , which are not NULL.
- Also mention the company name and location for each job posting.
*/
SELECT
    job_id,
    job_title_short,
    jpf.company_id,
    c.name AS company_name,
    job_location,
    job_posted_date,
    salary_year_avg
FROM
    job_postings_fact AS jpf
LEFT JOIN 
    company_dim AS c ON jpf.company_id = c.company_id
WHERE
    job_title_short = 'Data Analyst'
    AND job_location = 'Anywhere'-- job_location set to 'Anywhere' specifies remote-job/wfh
    AND salary_year_avg IS NOT NULL
ORDER BY
    salary_year_avg DESC
LIMIT 10;