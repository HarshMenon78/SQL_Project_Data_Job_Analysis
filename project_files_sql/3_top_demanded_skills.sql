/*
Question : Find the most in demand skills by their job count from job postings :-
- the jobs should be of Data Analyst roles.
- focus on all jobs postings for this role.
- Find the top 10 skills by job count for Data Analyst work from home jobs.
- Why? Retrieves the most sought-after skills for Data Analyst positions,
  helping job seekers and employers understand key tech stack in demand.
*/
--Normal way:-
SELECT
    sj.skill_id,
    s.skills,
    COUNT(*) AS job_count
FROM
    job_Postings_fact AS jpf
JOIN
    skills_job_dim AS sj ON jpf.job_id = sj.job_id
JOIN
    skills_dim AS s ON sj.skill_id = s.skill_id
WHERE
    salary_year_avg IS NOT NULL
GROUP BY
    sj.skill_id,
    s.skills
ORDER BY
    job_count DESC
LIMIT 10;

--cte way:-
WITH skills_job_count AS( -- CTE to calculate job counts per skill for Data Analyst work from home jobs.
    SELECT
        sj.skill_id,
        COUNT(*) AS job_count,
        RANK() OVER(ORDER BY COUNT(*) DESC) AS rnk
    FROM
        job_postings_fact AS jpf
    JOIN
        skills_job_dim AS sj ON jpf.job_id = sj.job_id
    WHERE -- filters out only Data Analyst work from home jobs.
        jpf.job_title_short IN ('Data Analyst')
    GROUP BY
        sj.skill_id
)
SELECT
    sjc.skill_id,
    s.skills,
    sjc.job_count
FROM
    skills_job_count AS sjc
JOIN
    skills_dim AS s ON sjc.skill_id = s.skill_id
WHERE -- filters out the previously set ranks by desc order of job count for each skills , to give top 10 skills by job count (but in random order).
    sjc.rnk <= 10
ORDER BY -- the randomly ordered top 10 skills returned from WHERE clause will be ordered in descending order by job count in the final result.
    job_count DESC;

/* solution explanation:
- SQL is the most in-demand skill, confirming its central role in data extraction and database querying.
- Excel remains highly relevant, showing that spreadsheet-based analysis is still widely used in business environments.
- Python is the top programming language, reflecting demand for automation, data manipulation, and advanced analysis.
- BI tools like Tableau and Power BI are essential, highlighting the importance of data visualization and storytelling.
- Statistical tools (R, SAS) are still valued, especially in data-intensive and research-driven industries.
- Employers seek end-to-end analysts, combining data querying, analysis, visualization, and communication skills.
*/