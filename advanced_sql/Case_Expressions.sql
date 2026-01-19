/* CASE EXPRESSIONS :-
   Here we will use CASE expressions to categorize the job_postings_fact table on the 
   basis of their job_location in a new column named/alliased as 'location_category':
   - If job_location is 'Anywhere', then categorize as 'Remote'.
   - If job_location is 'New York', then categorize as 'Local'.
*/
SELECT
    job_id,
    job_location,
    CASE
        WHEN job_location = 'Anywhere' THEN 'Remote'
        WHEN job_location = 'New York, NY' THEN 'Local'
        ELSE 'Onsite'
    END AS location_category
FROM 
    job_postings_fact
LIMIT 10;

--New query to find the count of Data Analyst jobs posted on the basis of the location category:
SELECT
    COUNT(job_id) AS job_count,
    CASE
        WHEN job_location = 'Anywhere' THEN 'Remote'
        WHEN job_location = 'New York, NY' THEN 'Local'
        ELSE 'Onsite'
    END AS location_category
FROM
    job_postings_fact
WHERE
    job_title_short = 'Data Analyst'
GROUP BY
    location_category
ORDER BY
    job_count DESC;