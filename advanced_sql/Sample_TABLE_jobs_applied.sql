--First we create the table called jobs_applied with the required columns:-
CREATE TABLE IF NOT EXISTS jobs_applied (
    job_id INT,
    application_sent_date TIMESTAMP,
    custom_resume_sent BOOLEAN,
    custom_resume_name VARCHAR(255),
    cover_letter_sent BOOLEAN,
    cover_letter_name VARCHAR(255),
    status VARCHAR(255)
);

SELECT * FROM jobs_applied;

--Now we add rows/column values to our data:-
INSERT INTO jobs_applied (
    job_id,
    application_sent_date,
    custom_resume_sent,
    custom_resume_name,
    cover_letter_sent,
    cover_letter_name,
    status
    )
VALUES (1,
       '2026-01-01 10:00:00',
       true,
       'resume_01.pdf',
       true,
       'cv_1.pdf',
       'submitted'
        ),
       (2,
       '2026-01-01 10:36:09',
       true,
       'resume_02.pdf',
       true,
       'cv_2.pdf',
       'submitted'
       ),
       (3,
       '2026-01-01 10:45:35',
       true,
       'resume_03.pdf',
       true,
       'cv_3.pdf',
       'submitted'
       ),
       (4,
       '2026-01-01 11:00:00',
       true,
       'resume_01.pdf',
       true,
       'cv_1.pdf',
       'submitted'
       ),
       (5,
       '2026-01-01 11:10:34',
       true,
       'resume_02.pdf',
       true,
       'cv_2.pdf',
       'submitted'
       ),
       (6,
       '2026-01-01 11:30:00',
       true,
       'resume_01.pdf',
       false,
       NULL,
       'submitted'
       );

SELECT * FROM jobs_applied;

--Now we will add a new column to the existing table using ALTER TABLE & ADD:-
ALTER TABLE jobs_applied 
ADD contact VARCHAR(255);

SELECT * FROM jobs_applied;

/*
For the new column we added above, we will now update the rows with contact names which cant be done using INSERT,
since it is used to add rows for pre existing columns which were there when they were made, so we use UPDATE:-
*/
UPDATE jobs_applied
SET contact = 'Tony Montana'
WHERE job_id = 1;

UPDATE jobs_applied
SET contact = 'Carl Johnson'
WHERE job_id = 2;

UPDATE jobs_applied
SET contact = 'Arthur Morgan'
WHERE job_id = 3;

UPDATE jobs_applied
SET contact = 'Delson Rowe'
WHERE job_id = 4;

UPDATE jobs_applied
SET contact = 'pgAdmin'
WHERE job_id = 5;

UPDATE jobs_applied
SET contact = 'Franklin Clinton'
WHERE job_id = 6;

SELECT * FROM jobs_applied;

--Now we will rename the column contact to contact_name using ALTER TABLE & RENAME COLUMN:-
ALTER TABLE jobs_applied
RENAME COLUMN contact TO contact_name;

SELECT * FROM jobs_applied;

--now if we need to change the type of data in contact_name column from VARCHAR to TEXT we can do that using ALTER TABLE & ALTER COLUMN:-
ALTER TABLE jobs_applied
ALTER COLUMN contact_name TYPE TEXT;

/*
Deleting rows from the table(similarly we can TRUNCATE [delete all the table rows] 
and DROP the table [remove all table contents with rows and structure i.e columns] inside our database we are connected to):-
*/
DELETE FROM jobs_applied --this means that DELETE the row from 'jobs_applied' table WHERE job_id = 6;
WHERE job_id = 6;

SELECT * FROM jobs_applied;

--Dropping COLUMNS of a table:-
ALTER TABLE jobs_applied
DROP cover_letter_name;

--Dropping a Table (since this operation is irreversible , we should be very careful while using this):-
DROP TABLE jobs_applied;