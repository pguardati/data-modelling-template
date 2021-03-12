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
    count;



