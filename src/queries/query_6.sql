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
    employee_name = 'Toni Lembeck';