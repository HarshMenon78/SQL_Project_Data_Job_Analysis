/*
Question : What are the top 10 skills based on their job's salary:
- For this purpose look at the average salaries asociated with each skill's corresponding jobs.
- Focus on jobs with specified salaries (i.e., non-null salary values).
- Why? Because it reveals which skills are linked to higher-paying roles,
  providing insights into valuable competencies in the job market.
*/

--Subquery based method:-
SELECT
    sjs.skill_id,
    s.skills,
    sjs.avg_salary
FROM ( -- subquery to calculate average salary per skill , where salary is not null.
    SELECT
        sj.skill_id,
        AVG(salary_year_avg) AS avg_salary,
        RANK() OVER(ORDER BY AVG(salary_year_avg) DESC) AS rnk
    FROM
        job_postings_fact AS jpf
    JOIN
        skills_job_dim AS sj ON jpf.job_id = sj.job_id
    WHERE
        salary_year_avg IS NOT NULL
    GROUP BY
        sj.skill_id
) AS sjs -- skills job salary in short
JOIN
    skills_dim AS s ON sjs.skill_id = s.skill_id
WHERE
    sjs.rnk <= 10 -- gives out top 10 ranks of rows from the sjs subquery in random order , i.e top 10 skills with their avg_salary mentioned.
ORDER BY
    sjs.avg_salary DESC; -- final ordering of the randomly ordered top 10 skills by their avg_salary in descending order.

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

-- CTE based method:-
WITH skills_job_sal AS ( -- CTE to calculate average salary per skill , where salary is not null.
    SELECT
        sj.skill_id,
        AVG(salary_year_avg) AS avg_salary,
        RANK() OVER(ORDER BY AVG(salary_year_avg) DESC) AS rnk
    FROM
        job_postings_fact AS jpf
    JOIN
        skills_job_dim AS sj ON jpf.job_id = sj.job_id
    WHERE
        salary_year_avg IS NOT NULL
    GROUP BY
        sj.skill_id
)
SELECT
    sjs.skill_id,
    s.skills,
    sjs.avg_salary
FROM
    skills_job_sal AS sjs
JOIN
    skills_dim AS s ON sjs.skill_id = s.skill_id
WHERE
    sjs.rnk <= 10 -- gives out top 10 ranks of rows from the sjs subquery in random order , i.e top 10 skills with their avg_salary mentioned.
ORDER BY
    sjs.avg_salary DESC; -- final ordering of the randomly ordered top 10 skills by their avg_salary in descending order.

/*result explained:
- Top-paying skills are highly specialized, with tools like Debian, RingCentral, and Solidity indicating niche or infrastructure-heavy expertise.
- Database and big data technologies (MongoDB, Cassandra) are strongly associated with higher average salaries due to their role in scalable data systems.
- Programming languages outside the typical analyst stack (Lua, Haskell) command high pay, suggesting scarcity and specialized use cases.
- Data-focused libraries like dplyr rank high, showing that advanced data manipulation skills can significantly impact compensation.
- Backend and platform technologies (ASP.NET Core, Node.js) highlight that analysts with engineering-adjacent skills tend to earn more.
*/