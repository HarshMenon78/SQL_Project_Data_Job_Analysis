/*
Problem 6 : What are the latest job postings available in the dataset:
- Focus on retrieving the top 10 most recent 'Data Analyst' job postings based on the posting date-time.
- Focus on job_postings after feb 2023.
- Also in the same query mention the date-time of job postings according to America/New_York timezone,
  for the original timezone of UTC set for the original job posting date-time.
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
    AND job_posted_date :: DATE >= '2023-02-01' -- filtering for job postings DATE to show dates after feb 2023
    AND job_title_short = 'Data Analyst'
ORDER BY
    job_posted_date DESC
LIMIT 10; -- limiting to top 10 latest job postings after feb 2023 for Data Analyst roles with specified salaries.

/*
result explained:
- The latest Data Analyst postings are globally distributed, spanning the U.S., Europe, Asia, and fully remote (“Anywhere”) roles, indicating strong international demand.
- Remote roles (“Anywhere”) offer competitive salaries (≈$63K–$107K), showing that location flexibility does not necessarily reduce pay.
- U.S.-based roles dominate the highest salaries, with California postings reaching $149K–$222K, highlighting strong regional pay premiums.
- Most postings cluster around late December 2023, confirming active hiring even at year-end rather than seasonal slowdown.
- Salary ranges vary widely ($50K–$222K), suggesting significant differences in role scope, seniority, and company expectations within the same job title.
*/