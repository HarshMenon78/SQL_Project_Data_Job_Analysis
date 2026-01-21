/*
Find the top 10 skills by their demand (job count) from job postings :-
- the jobs should be of Data Analyst roles.
- the jobs should be also work from home.
*/
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
        AND jpf.job_work_from_home = true
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
    job_count DESC