-- education_titles
INSERT INTO
    education_titles (title_name)
SELECT
    DISTINCT education_lvl
FROM
    proj_stg;

-- job_titles
INSERT INTO
    job_titles (job_name)
SELECT
    DISTINCT job_title
FROM
    proj_stg;

-- managers
INSERT INTO
    managers (manager_name)
SELECT
    DISTINCT manager
FROM
    proj_stg;

-- departments
INSERT INTO
    departments (department_name)
SELECT
    DISTINCT department_nm
FROM
    proj_stg;

-- offices
INSERT INTO
    offices (office_name, address, city, state)
SELECT
    DISTINCT location,
    address,
    city,
    state
FROM
    proj_stg;

-- employees
INSERT INTO
    employees (
        employee_id,
        employee_name,
        employee_email,
        title_id
    ) WITH employees_updated AS (
        -- select most recent record of each employee
        SELECT
            *
        FROM
            (
                SELECT
                    *,
                    row_number() over (
                        PARTITION by emp_id
                        ORDER BY
                            start_dt DESC
                    ) AS contract_number
                FROM
                    proj_stg
            ) AS staging
        WHERE
            contract_number = 1
    )
SELECT
    DISTINCT Emp_ID,
    Emp_NM,
    Email,
    e.title_id
FROM
    employees_updated AS staging
    JOIN education_titles AS e ON staging.education_lvl = e.title_name;

-- contracts
INSERT INTO
    contracts (
        employee_id,
        hire_date,
        start_date,
        end_date,
        salary,
        job_id,
        manager_id,
        department_id,
        office_id
    )
SELECT
    DISTINCT emp_id,
    hire_dt,
    start_dt,
    end_dt,
    salary,
    j.job_id,
    m.manager_id,
    d.department_id,
    o.office_id
FROM
    proj_stg AS staging
    JOIN employees AS e ON staging.emp_id = e.employee_id
    JOIN job_titles AS j ON staging.job_title = j.job_name
    JOIN managers AS m ON staging.manager = m.manager_name
    JOIN departments AS d ON staging.department_nm = d.department_name
    JOIN offices AS o ON staging."location" = o.office_name;