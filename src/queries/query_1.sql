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
    department_name;
