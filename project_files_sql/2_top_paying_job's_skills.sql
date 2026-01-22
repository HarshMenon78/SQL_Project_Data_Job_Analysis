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

/*
Result JSON:
[
  {
    "job_id": 552322,
    "job_title_short": "Data Analyst",
    "company_id": 5835,
    "company_name": "AT&T",
    "salary_year_avg": "255829.5",
    "skill_id": 0,
    "skills": "sql"
  },
  {
    "job_id": 552322,
    "job_title_short": "Data Analyst",
    "company_id": 5835,
    "company_name": "AT&T",
    "salary_year_avg": "255829.5",
    "skill_id": 1,
    "skills": "python"
  },
  {
    "job_id": 552322,
    "job_title_short": "Data Analyst",
    "company_id": 5835,
    "company_name": "AT&T",
    "salary_year_avg": "255829.5",
    "skill_id": 5,
    "skills": "r"
  },
  {
    "job_id": 552322,
    "job_title_short": "Data Analyst",
    "company_id": 5835,
    "company_name": "AT&T",
    "salary_year_avg": "255829.5",
    "skill_id": 74,
    "skills": "azure"
  },
  {
    "job_id": 552322,
    "job_title_short": "Data Analyst",
    "company_id": 5835,
    "company_name": "AT&T",
    "salary_year_avg": "255829.5",
    "skill_id": 75,
    "skills": "databricks"
  },
  {
    "job_id": 552322,
    "job_title_short": "Data Analyst",
    "company_id": 5835,
    "company_name": "AT&T",
    "salary_year_avg": "255829.5",
    "skill_id": 76,
    "skills": "aws"
  },
  {
    "job_id": 552322,
    "job_title_short": "Data Analyst",
    "company_id": 5835,
    "company_name": "AT&T",
    "salary_year_avg": "255829.5",
    "skill_id": 93,
    "skills": "pandas"
  },
  {
    "job_id": 552322,
    "job_title_short": "Data Analyst",
    "company_id": 5835,
    "company_name": "AT&T",
    "salary_year_avg": "255829.5",
    "skill_id": 95,
    "skills": "pyspark"
  },
  {
    "job_id": 552322,
    "job_title_short": "Data Analyst",
    "company_id": 5835,
    "company_name": "AT&T",
    "salary_year_avg": "255829.5",
    "skill_id": 102,
    "skills": "jupyter"
  },
  {
    "job_id": 552322,
    "job_title_short": "Data Analyst",
    "company_id": 5835,
    "company_name": "AT&T",
    "salary_year_avg": "255829.5",
    "skill_id": 181,
    "skills": "excel"
  },
  {
    "job_id": 552322,
    "job_title_short": "Data Analyst",
    "company_id": 5835,
    "company_name": "AT&T",
    "salary_year_avg": "255829.5",
    "skill_id": 182,
    "skills": "tableau"
  },
  {
    "job_id": 552322,
    "job_title_short": "Data Analyst",
    "company_id": 5835,
    "company_name": "AT&T",
    "salary_year_avg": "255829.5",
    "skill_id": 183,
    "skills": "power bi"
  },
  {
    "job_id": 552322,
    "job_title_short": "Data Analyst",
    "company_id": 5835,
    "company_name": "AT&T",
    "salary_year_avg": "255829.5",
    "skill_id": 196,
    "skills": "powerpoint"
  },
  {
    "job_id": 99305,
    "job_title_short": "Data Analyst",
    "company_id": 183972,
    "company_name": "Pinterest Job Advertisements",
    "salary_year_avg": "232423.0",
    "skill_id": 0,
    "skills": "sql"
  },
  {
    "job_id": 99305,
    "job_title_short": "Data Analyst",
    "company_id": 183972,
    "company_name": "Pinterest Job Advertisements",
    "salary_year_avg": "232423.0",
    "skill_id": 1,
    "skills": "python"
  },
  {
    "job_id": 99305,
    "job_title_short": "Data Analyst",
    "company_id": 183972,
    "company_name": "Pinterest Job Advertisements",
    "salary_year_avg": "232423.0",
    "skill_id": 5,
    "skills": "r"
  },
  {
    "job_id": 99305,
    "job_title_short": "Data Analyst",
    "company_id": 183972,
    "company_name": "Pinterest Job Advertisements",
    "salary_year_avg": "232423.0",
    "skill_id": 97,
    "skills": "hadoop"
  },
  {
    "job_id": 99305,
    "job_title_short": "Data Analyst",
    "company_id": 183972,
    "company_name": "Pinterest Job Advertisements",
    "salary_year_avg": "232423.0",
    "skill_id": 182,
    "skills": "tableau"
  },
  {
    "job_id": 1021647,
    "job_title_short": "Data Analyst",
    "company_id": 381287,
    "company_name": "Uclahealthcareers",
    "salary_year_avg": "217000.0",
    "skill_id": 0,
    "skills": "sql"
  },
  {
    "job_id": 1021647,
    "job_title_short": "Data Analyst",
    "company_id": 381287,
    "company_name": "Uclahealthcareers",
    "salary_year_avg": "217000.0",
    "skill_id": 23,
    "skills": "crystal"
  },
  {
    "job_id": 1021647,
    "job_title_short": "Data Analyst",
    "company_id": 381287,
    "company_name": "Uclahealthcareers",
    "salary_year_avg": "217000.0",
    "skill_id": 79,
    "skills": "oracle"
  },
  {
    "job_id": 1021647,
    "job_title_short": "Data Analyst",
    "company_id": 381287,
    "company_name": "Uclahealthcareers",
    "salary_year_avg": "217000.0",
    "skill_id": 182,
    "skills": "tableau"
  },
  {
    "job_id": 1021647,
    "job_title_short": "Data Analyst",
    "company_id": 381287,
    "company_name": "Uclahealthcareers",
    "salary_year_avg": "217000.0",
    "skill_id": 215,
    "skills": "flow"
  },
  {
    "job_id": 168310,
    "job_title_short": "Data Analyst",
    "company_id": 19724,
    "company_name": "SmartAsset",
    "salary_year_avg": "205000.0",
    "skill_id": 0,
    "skills": "sql"
  },
  {
    "job_id": 168310,
    "job_title_short": "Data Analyst",
    "company_id": 19724,
    "company_name": "SmartAsset",
    "salary_year_avg": "205000.0",
    "skill_id": 1,
    "skills": "python"
  },
  {
    "job_id": 168310,
    "job_title_short": "Data Analyst",
    "company_id": 19724,
    "company_name": "SmartAsset",
    "salary_year_avg": "205000.0",
    "skill_id": 8,
    "skills": "go"
  },
  {
    "job_id": 168310,
    "job_title_short": "Data Analyst",
    "company_id": 19724,
    "company_name": "SmartAsset",
    "salary_year_avg": "205000.0",
    "skill_id": 80,
    "skills": "snowflake"
  },
  {
    "job_id": 168310,
    "job_title_short": "Data Analyst",
    "company_id": 19724,
    "company_name": "SmartAsset",
    "salary_year_avg": "205000.0",
    "skill_id": 93,
    "skills": "pandas"
  },
  {
    "job_id": 168310,
    "job_title_short": "Data Analyst",
    "company_id": 19724,
    "company_name": "SmartAsset",
    "salary_year_avg": "205000.0",
    "skill_id": 94,
    "skills": "numpy"
  },
  {
    "job_id": 168310,
    "job_title_short": "Data Analyst",
    "company_id": 19724,
    "company_name": "SmartAsset",
    "salary_year_avg": "205000.0",
    "skill_id": 181,
    "skills": "excel"
  },
  {
    "job_id": 168310,
    "job_title_short": "Data Analyst",
    "company_id": 19724,
    "company_name": "SmartAsset",
    "salary_year_avg": "205000.0",
    "skill_id": 182,
    "skills": "tableau"
  },
  {
    "job_id": 168310,
    "job_title_short": "Data Analyst",
    "company_id": 19724,
    "company_name": "SmartAsset",
    "salary_year_avg": "205000.0",
    "skill_id": 220,
    "skills": "gitlab"
  },
  {
    "job_id": 731368,
    "job_title_short": "Data Analyst",
    "company_id": 1261,
    "company_name": "Inclusively",
    "salary_year_avg": "189309.0",
    "skill_id": 0,
    "skills": "sql"
  },
  {
    "job_id": 731368,
    "job_title_short": "Data Analyst",
    "company_id": 1261,
    "company_name": "Inclusively",
    "salary_year_avg": "189309.0",
    "skill_id": 1,
    "skills": "python"
  },
  {
    "job_id": 731368,
    "job_title_short": "Data Analyst",
    "company_id": 1261,
    "company_name": "Inclusively",
    "salary_year_avg": "189309.0",
    "skill_id": 74,
    "skills": "azure"
  },
  {
    "job_id": 731368,
    "job_title_short": "Data Analyst",
    "company_id": 1261,
    "company_name": "Inclusively",
    "salary_year_avg": "189309.0",
    "skill_id": 76,
    "skills": "aws"
  },
  {
    "job_id": 731368,
    "job_title_short": "Data Analyst",
    "company_id": 1261,
    "company_name": "Inclusively",
    "salary_year_avg": "189309.0",
    "skill_id": 79,
    "skills": "oracle"
  },
  {
    "job_id": 731368,
    "job_title_short": "Data Analyst",
    "company_id": 1261,
    "company_name": "Inclusively",
    "salary_year_avg": "189309.0",
    "skill_id": 80,
    "skills": "snowflake"
  },
  {
    "job_id": 731368,
    "job_title_short": "Data Analyst",
    "company_id": 1261,
    "company_name": "Inclusively",
    "salary_year_avg": "189309.0",
    "skill_id": 182,
    "skills": "tableau"
  },
  {
    "job_id": 731368,
    "job_title_short": "Data Analyst",
    "company_id": 1261,
    "company_name": "Inclusively",
    "salary_year_avg": "189309.0",
    "skill_id": 183,
    "skills": "power bi"
  },
  {
    "job_id": 731368,
    "job_title_short": "Data Analyst",
    "company_id": 1261,
    "company_name": "Inclusively",
    "salary_year_avg": "189309.0",
    "skill_id": 189,
    "skills": "sap"
  },
  {
    "job_id": 731368,
    "job_title_short": "Data Analyst",
    "company_id": 1261,
    "company_name": "Inclusively",
    "salary_year_avg": "189309.0",
    "skill_id": 211,
    "skills": "jenkins"
  },
  {
    "job_id": 731368,
    "job_title_short": "Data Analyst",
    "company_id": 1261,
    "company_name": "Inclusively",
    "salary_year_avg": "189309.0",
    "skill_id": 218,
    "skills": "bitbucket"
  },
  {
    "job_id": 731368,
    "job_title_short": "Data Analyst",
    "company_id": 1261,
    "company_name": "Inclusively",
    "salary_year_avg": "189309.0",
    "skill_id": 219,
    "skills": "atlassian"
  },
  {
    "job_id": 731368,
    "job_title_short": "Data Analyst",
    "company_id": 1261,
    "company_name": "Inclusively",
    "salary_year_avg": "189309.0",
    "skill_id": 233,
    "skills": "jira"
  },
  {
    "job_id": 731368,
    "job_title_short": "Data Analyst",
    "company_id": 1261,
    "company_name": "Inclusively",
    "salary_year_avg": "189309.0",
    "skill_id": 234,
    "skills": "confluence"
  },
  {
    "job_id": 310660,
    "job_title_short": "Data Analyst",
    "company_id": 4707,
    "company_name": "Motional",
    "salary_year_avg": "189000.0",
    "skill_id": 0,
    "skills": "sql"
  },
  {
    "job_id": 310660,
    "job_title_short": "Data Analyst",
    "company_id": 4707,
    "company_name": "Motional",
    "salary_year_avg": "189000.0",
    "skill_id": 1,
    "skills": "python"
  },
  {
    "job_id": 310660,
    "job_title_short": "Data Analyst",
    "company_id": 4707,
    "company_name": "Motional",
    "salary_year_avg": "189000.0",
    "skill_id": 5,
    "skills": "r"
  },
  {
    "job_id": 310660,
    "job_title_short": "Data Analyst",
    "company_id": 4707,
    "company_name": "Motional",
    "salary_year_avg": "189000.0",
    "skill_id": 210,
    "skills": "git"
  },
  {
    "job_id": 310660,
    "job_title_short": "Data Analyst",
    "company_id": 4707,
    "company_name": "Motional",
    "salary_year_avg": "189000.0",
    "skill_id": 218,
    "skills": "bitbucket"
  },
  {
    "job_id": 310660,
    "job_title_short": "Data Analyst",
    "company_id": 4707,
    "company_name": "Motional",
    "salary_year_avg": "189000.0",
    "skill_id": 219,
    "skills": "atlassian"
  },
  {
    "job_id": 310660,
    "job_title_short": "Data Analyst",
    "company_id": 4707,
    "company_name": "Motional",
    "salary_year_avg": "189000.0",
    "skill_id": 233,
    "skills": "jira"
  },
  {
    "job_id": 310660,
    "job_title_short": "Data Analyst",
    "company_id": 4707,
    "company_name": "Motional",
    "salary_year_avg": "189000.0",
    "skill_id": 234,
    "skills": "confluence"
  },
  {
    "job_id": 1749593,
    "job_title_short": "Data Analyst",
    "company_id": 19724,
    "company_name": "SmartAsset",
    "salary_year_avg": "186000.0",
    "skill_id": 0,
    "skills": "sql"
  },
  {
    "job_id": 1749593,
    "job_title_short": "Data Analyst",
    "company_id": 19724,
    "company_name": "SmartAsset",
    "salary_year_avg": "186000.0",
    "skill_id": 1,
    "skills": "python"
  },
  {
    "job_id": 1749593,
    "job_title_short": "Data Analyst",
    "company_id": 19724,
    "company_name": "SmartAsset",
    "salary_year_avg": "186000.0",
    "skill_id": 8,
    "skills": "go"
  },
  {
    "job_id": 1749593,
    "job_title_short": "Data Analyst",
    "company_id": 19724,
    "company_name": "SmartAsset",
    "salary_year_avg": "186000.0",
    "skill_id": 80,
    "skills": "snowflake"
  },
  {
    "job_id": 1749593,
    "job_title_short": "Data Analyst",
    "company_id": 19724,
    "company_name": "SmartAsset",
    "salary_year_avg": "186000.0",
    "skill_id": 93,
    "skills": "pandas"
  },
  {
    "job_id": 1749593,
    "job_title_short": "Data Analyst",
    "company_id": 19724,
    "company_name": "SmartAsset",
    "salary_year_avg": "186000.0",
    "skill_id": 94,
    "skills": "numpy"
  },
  {
    "job_id": 1749593,
    "job_title_short": "Data Analyst",
    "company_id": 19724,
    "company_name": "SmartAsset",
    "salary_year_avg": "186000.0",
    "skill_id": 181,
    "skills": "excel"
  },
  {
    "job_id": 1749593,
    "job_title_short": "Data Analyst",
    "company_id": 19724,
    "company_name": "SmartAsset",
    "salary_year_avg": "186000.0",
    "skill_id": 182,
    "skills": "tableau"
  },
  {
    "job_id": 1749593,
    "job_title_short": "Data Analyst",
    "company_id": 19724,
    "company_name": "SmartAsset",
    "salary_year_avg": "186000.0",
    "skill_id": 220,
    "skills": "gitlab"
  },
  {
    "job_id": 387860,
    "job_title_short": "Data Analyst",
    "company_id": 2686,
    "company_name": "Get It Recruit - Information Technology",
    "salary_year_avg": "184000.0",
    "skill_id": 0,
    "skills": "sql"
  },
  {
    "job_id": 387860,
    "job_title_short": "Data Analyst",
    "company_id": 2686,
    "company_name": "Get It Recruit - Information Technology",
    "salary_year_avg": "184000.0",
    "skill_id": 1,
    "skills": "python"
  },
  {
    "job_id": 387860,
    "job_title_short": "Data Analyst",
    "company_id": 2686,
    "company_name": "Get It Recruit - Information Technology",
    "salary_year_avg": "184000.0",
    "skill_id": 5,
    "skills": "r"
  }
]
*/