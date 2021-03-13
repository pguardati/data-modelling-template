-- Q2 - Create Web programmer as title
INSERT INTO
    job_titles
VALUES
    (DEFAULT, 'Web Programmer');

SELECT * FROM job_titles;

-- Q3 - Correct from Web programmer to web developer
UPDATE
    job_titles
SET
    job_name = 'Web Developer'
WHERE
    job_name = 'Web Programmer';

SELECT * FROM job_titles;

-- Q4 - Delete Web Developer from database
DELETE FROM
    job_titles
WHERE
    job_name = 'Web Developer';

SELECT * FROM job_titles;
