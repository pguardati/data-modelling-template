-- Q1 - query employee by name
WITH current_contracts AS (
    WITH current_and_past_contracts AS (
        SELECT
            c.*,
            e.employee_name,
            e.employee_email,
            e.title_id
        FROM
            contracts AS c
            JOIN employees AS e ON c.employee_id = e.employee_id
    )
    SELECT
        *
    FROM
        (
            SELECT
                *,
                row_number() over (
                    PARTITION by employee_id
                    ORDER BY
                        start_date DESC
                ) AS contract_number
            FROM
                current_and_past_contracts
        ) AS c
    WHERE
        contract_number = 1
)
SELECT
    c.employee_name,
    j.job_name,
    d.department_name
FROM
    current_contracts AS c
    JOIN departments AS d ON c.department_id = d.department_id
    JOIN job_titles AS j ON c.job_id = j.job_id;