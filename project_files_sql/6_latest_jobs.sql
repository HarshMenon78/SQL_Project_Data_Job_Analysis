/*
Problem : What are the latest job postings available in the dataset:
- Focus on retrieving the top 10 most recent 'Data Analyst' job postings based on the posting date-time.
- Focus on job_postings after feb 2023.
- Also in a separate query mention the date-time of job postings according to America/New_York timezone,
  for the original timezone of UTC for the original posting date-time.
- Why? This helps job seekers identify the freshest opportunities in the job market.
*/

-- Query to get latest Data Analyst job postings after Feb 2023:-
SELECT
    job_id,
    job_title_short,
    job_location,
    salary_year_avg,
    job_posted_date, -- TIMESTAMP value
    job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'America/New_York' -- will show the EST time corresponding to the UTC set timestamp values of job_posted_date , will be shown in clock format (i.e no +/-hh:mm relating to UTC).
FROM
    job_postings_fact AS jpf
WHERE
    salary_year_avg IS NOT NULL
    AND job_posted_date :: DATE >= '2023-02-01' -- filtering for job postings after feb 2023
    AND job_title_short = 'Data Analyst'
ORDER BY
    job_posted_date DESC
LIMIT 10;