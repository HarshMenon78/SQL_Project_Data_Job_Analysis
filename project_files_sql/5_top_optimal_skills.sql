/*
Question : What are the most optimal skills to learn on the basis of both job demand as well as average salary:
- The jobs should be of Data Analyst roles with a specific salary which is not null.
- Find the top 10 skills by job count as well as average salary for Data Analyst jobs.
- Use 2 CTEs for this purpose, one for job count per skill and another for average salary per skill.
- in the SELECT statement join both CTEs on skill_id to get the final result.
- Why? This combined analysis helps identify skills that are not only in high demand but 
  also command competitive salaries, guiding job seekers towards the most rewarding skill sets.
*/
WITH skills_demand AS ( -- CTE to calculate job counts per skill for Data Analyst jobs with specified salaries.
    SELECT
        sj.skill_id,
        s.skills,
        COUNT(*) AS job_count
    FROM
        job_postings_fact AS jpf
    JOIN
        skills_job_dim AS sj ON jpf.job_id = sj.job_id
    JOIN
        skills_dim AS s ON sj.skill_id = s.skill_id
    WHERE
        job_title_short = 'Data Analyst'
        AND salary_year_avg IS NOT NULL
    GROUP BY
        sj.skill_id,
        s.skills
    ), -- end of first CTE, now starting second CTE
    skills_salary AS ( -- CTE to calculate average salary per skill for Data Analyst jobs with specified salaries.
    SELECT
        sj.skill_id,
        s.skills,
        AVG(salary_year_avg) AS avg_salary 
    FROM
        job_postings_fact AS jpf
    JOIN
        skills_job_dim AS sj ON jpf.job_id = sj.job_id
    JOIN
        skills_dim AS s ON sj.skill_id = s.skill_id
    WHERE
        job_title_short = 'Data Analyst'
        AND salary_year_avg IS NOT NULL
    GROUP BY
        sj.skill_id,
        s.skills
    )
SELECT
    sd.skill_id,
    sd.skills,
    sd.job_count,
    ss.avg_salary
FROM
    skills_demand AS sd
JOIN
    skills_salary AS ss ON sd.skill_id = ss.skill_id
ORDER BY -- ordering by both job count and average salary in descending order to get top 10 optimal skills, firstly according to job_count , and secondly for avg salaries (i.e if job counts are same , then avg_salary will decide the order).
    sd.job_count DESC,
    ss.avg_salary DESC
LIMIT 10;