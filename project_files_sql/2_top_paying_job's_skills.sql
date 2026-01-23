/*
Problem 2 : What are the skills required for top paying data analyst jobs posted:
- Use the top 10 highest paying remote data analyst job postings from first query.
- Add specific skill names for each of these skills.
- Why? It provides a comprehensive view of the technical skill requirements for highest-paying data analyst roles in our job postings.
*/
WITH top_pay_jobs AS (
    SELECT
        job_id,
        job_title_short,
        jpf.company_id,
        c.name AS company_name,
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
    LIMIT 10
    )
SELECT 
    tpj.*, -- selecting all columns from the CTE top_pay_jobs
    s.skill_id,
    s.skills -- selecting skill names from skills_dim table
FROM
    top_pay_jobs AS tpj 
JOIN
    skills_job_dim AS sj ON sj.job_id = tpj.job_id
JOIN 
    skills_dim AS s ON sj.skill_id = s.skill_id
ORDER BY -- we have to mention this again cuz in the CTE it only gives us info about top 10 jobs , but the result retrieved from this cte in the main query might result the skills for these job_ids in any order , so we mention ORDER BY salary again...
    salary_year_avg DESC;

/* solution explanation:
-- Top-paying Data Analyst roles require SQL + Python as core skills.
-- Highest salaries favor hybrid profiles with cloud (AWS/Azure) and big-data tools (Databricks, PySpark).
-- BI tools add value only when combined with programming and data platform expertise.
-- Premium pay reflects analyst roles embedded in modern, engineering-driven data stacks.
*/