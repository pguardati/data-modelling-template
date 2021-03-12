-- Q2 - Create Web programmer as title
INSERT INTO
    job_titles
VALUES
    (DEFAULT, 'Web Programmer');

-- Q3 - Correct from Web programmer to web developer
UPDATE
    job_titles
SET
    job_name = 'Web Developer'
WHERE
    job_name = 'Web Programmer';

-- Q4 - Delete Web Developer from database
DELETE FROM
    job_titles
WHERE
    job_name = 'Web Developer';
