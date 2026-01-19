/* Subquery and CTE for creating temporary result sets containing job postings for the month of jan */
--Subquery:-
SELECT *
FROM (
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 1
);
--CTE:-(we'll have to create a temporary Table [result set] called january_jobs , and then select all from this temporary table created)
WITH january_jobs AS (
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 1
)
SELECT *
FROM january_jobs;

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

/*Subquery to find the company names(& ids) for the company_ids in job_postings_fact table where the teh job has no degree mentioned */
SELECT
    company_id,
    name AS company_name
FROM
    company_dim
WHERE
    company_id IN (
        SELECT company_id
        FROM job_postings_fact
        WHERE job_no_degree_mention = true
        ORDER BY company_id
    );

/*CTE to find the company_id and their names from the company_dim on the basis of the count of jobs posted in job_postings_fact table :-
  - first create a CTE result set(imaginary temp table) for all the company_ids with their job count.
  - then left join the table of job_postings_fact(right table) with company_dim(left table) , to display its name for the company_id mentioned. */
WITH company_job_count AS ( -- firstly created a CTE with the job counts for each of the company_id
    SELECT
        company_id,
        COUNT(*) AS job_count
    FROM
        job_postings_fact
    GROUP BY 
        company_id
)
SELECT
    company_dim.company_id,
    company_dim.name AS company_name,
    company_job_count.job_count
FROM
    company_dim -- left table
LEFT JOIN company_job_count ON company_dim.company_id = company_job_count.company_id;

--PQ1:-
/* Find top 5 skill_ids on the basis of their job counts from job_postings_fact & skills_job_dim 
tables which is also mentioned alongside the skill name from skills_dim_table using subqueries...*/
SELECT
    s.skill_id,
    s.skills,
    jc.job_count
FROM ( -- Subquery jc , specifying the job postings count of each skill_id , inner joining job_postings_fact & skills_job_dim
    SELECT
        sj.skill_id,
        COUNT(*) AS job_count,
        RANK() OVER(ORDER BY COUNT(*) DESC) AS rnk -- creating an entity of ranks by ORDER BY COUNT(*) to get top 5 in later part of query
    FROM
        job_postings_fact AS jpf
    JOIN 
        skills_job_dim AS sj ON jpf.job_id = sj.job_id 
    GROUP BY
        sj.skill_id
    ) AS jc
JOIN 
    skills_dim AS s ON jc.skill_id = s.skill_id -- inner joins the skills_dim with the subquery of jc(which contains job count of each skill)
WHERE 
    jc.rnk <= 5;

--CTE(the same query using CTE instead of subqueries)
WITH job_count_skill AS ( -- creating a cte where each skill_id in skills_job_dim is displayed along its corresponding job count in job_postings_fact , (where each job_id in jpf will be counted for the count of jobs, for each of the skill_id mentioned im sj table , which has a correspinding job_id and the no. of times these job_id appear which has a corresponding skill_id to them , their count will increment in the job_count corresponding to the skill_id)
    SELECT
        sj.skill_id,
        COUNT(*) AS job_count,
        RANK() OVER(ORDER BY COUNT(*) DESC) as rnk -- creating an entity of ranks by ORDER BY COUNT(*) to get top 5 in later part of query
    FROM
        job_postings_fact AS jpf
    JOIN
        skills_job_dim AS sj ON jpf.job_id = sj.job_id
    GROUP BY
        sj.skill_id
)
SELECT
    jcs.skill_id,
    s.skills,
    jcs.job_count
FROM
    skills_dim AS s
JOIN
    job_count_skill as jcs ON jcs.skill_id = s.skill_id
WHERE
    jcs.rnk <= 5;
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

/* Practice Problem 7:-
   Find the no. of remote jobs posted per skill:-
   - display top 5 skills on the basis of job counts
   - include skill_id, skill name & job count
   - use subqueries & CTEs both */

--Subquery:-
SELECT
    s.skill_id,
    s.skills,
    jc.job_count
FROM ( -- subquery jc which counts the job postings for each skill_id where location_category is 'Remote'
    SELECT
        sj.skill_id,
        COUNT(*) AS job_count,
        RANK() OVER(ORDER BY COUNT(*) DESC) AS rnk
    FROM
        job_postings_fact AS jpf
    JOIN
        skills_job_dim AS sj ON jpf.job_id = sj.job_id
    WHERE
        jpf.job_location IN ('Anywhere') -- filtering only remote jobs
    GROUP BY
        sj.skill_id
) AS jc
JOIN
    skills_dim AS s ON jc.skill_id = s.skill_id -- inner join skills_dim to get the skill names for each skill_id and its job count mentioned from jc subquery
WHERE
    jc.rnk <= 5
ORDER BY
    jc.job_count DESC; -- in the rnk even though we have mentioned ORDER BY COUNT(*) DESC, but if we dont use this ORDER BY statement it will return us the top 5 ranks in random order, to get it in correct order of their ranks we use this statement

--CTE:-
WITH skills_job_count AS ( -- cte for counting job postings for each skill_id where location_category is 'Remote'(Anywhere) , by joining tables job_postings_fact & skills_job_dim on job_id column
    SELECT
        sj.skill_id,
        COUNT(*) AS job_count,
        RANK() OVER(ORDER BY COUNT(*) DESC) AS rnk
    FROM
        job_postings_fact AS jpc
    JOIN
        skills_job_dim AS sj ON jpc.job_id = sj.job_id
    WHERE
        jpc.job_location = 'Anywhere'
    GROUP BY
        sj.skill_id
)
SELECT
    skills_job_count.skill_id,
    s.skills,
    skills_job_count.job_count
FROM
    skills_job_count
JOIN 
    skills_dim AS s ON skills_job_count.skill_id = s.skill_id --joining the sjc and skills_dim n the basis of skill_id common column to get their respective names from skills_dim table
WHERE
    skills_job_count.rnk <= 5
ORDER BY
    skills_job_count.job_count DESC;-- in the rnk even though we have mentioned ORDER BY COUNT(*) DESC, but if we dont use this ORDER BY statement it will return us the top 5 ranks in random order, to get it in correct order of their ranks we use this statement