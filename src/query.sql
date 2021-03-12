-- Q1 - query employee by name
WITH contracts_roles_and_departments AS (
    SELECT
        contract_id,
        j.job_name,
        d.department_name
    FROM
        contracts AS c
        JOIN job_titles AS j ON c.job_id = j.job_id
        JOIN departments AS d ON c.department_id = d.department_id
)
SELECT
    employee_name,
    job_name,
    department_name
FROM
    employees AS e
    JOIN contracts_roles_and_departments AS c ON e.current_contract_id = c.contract_id
ORDER BY
    department_name

-- Q2 - Create Web programmer as title
INSERT INTO
    job_titles
VALUES
    (DEFAULT, 'Web Programmer')

-- Q3 - Correct from Web programmer to web developer
UPDATE
    job_titles
SET
    job_name = 'Web Developer'
WHERE
    job_name = 'Web Programmer'

-- Q4 - Delete Web Developer from database
DELETE FROM
    job_titles
WHERE
    job_name = 'Web Developer'

-- Q5 - How many employees are in each department?
WITH employees_and_departments AS (
    SELECT
        contract_id,
        d.department_name
    FROM
        contracts AS c
        JOIN departments AS d ON c.department_id = d.department_id
)
SELECT
    department_name,
    count(*)
FROM
    employees_and_departments
GROUP BY
    department_name
ORDER BY
    count

-- Q6 - Current and past job of Toni Lembeck
    WITH explicit_contracts AS (
        SELECT
            employee_id,
            job_name,
            department_name,
            manager_name,
            start_date,
            end_date
        FROM
            contracts AS c
            JOIN job_titles AS j ON c.job_id = j.job_id
            JOIN departments AS d ON c.department_id = d.department_id
            JOIN managers AS m ON c.manager_id = m.manager_id
    )
SELECT
    employee_name,
    job_name,
    department_name,
    manager_name,
    start_date,
    end_date
FROM
    employees AS e
    JOIN explicit_contracts AS c ON e.employee_id = c.employee_id
WHERE
    employee_name = 'Toni Lembeck'