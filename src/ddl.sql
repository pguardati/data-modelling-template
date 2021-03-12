-- drop tables
DROP TABLE IF EXISTS education_titles CASCADE;

DROP TABLE IF EXISTS job_titles CASCADE;

DROP TABLE IF EXISTS managers CASCADE;

DROP TABLE IF EXISTS departments CASCADE;

DROP TABLE IF EXISTS offices CASCADE;

DROP TABLE IF EXISTS contracts CASCADE;

DROP TABLE IF EXISTS employees CASCADE;

-- create tables
CREATE TABLE education_titles (
    title_id serial PRIMARY KEY,
    title_name varchar(100)
);

CREATE TABLE job_titles (
    job_id serial PRIMARY KEY,
    job_name varchar(100)
);

CREATE TABLE managers (
    manager_id serial PRIMARY KEY,
    manager_name varchar(100)
);

CREATE TABLE departments (
    department_id serial PRIMARY KEY,
    department_name varchar(100)
);

CREATE TABLE offices (
    office_id serial PRIMARY KEY,
    office_name varchar(50),
    address varchar(100),
    city varchar(50),
    state varchar(2)
);

CREATE TABLE contracts (
    contract_id serial PRIMARY KEY,
    employee_id varchar(50),
    hire_date date,
    start_date date,
    end_date date,
    salary int,
    job_id int REFERENCES job_titles(job_id),
    manager_id int REFERENCES managers(manager_id),
    department_id int REFERENCES departments(department_id),
    office_id int REFERENCES offices(office_id)
);

CREATE TABLE employees (
    employee_id varchar(8) PRIMARY KEY,
    employee_name varchar(50),
    employee_email varchar(100),
    title_id int REFERENCES education_titles(title_id),
    current_contract_id int REFERENCES contracts(contract_id)
);
