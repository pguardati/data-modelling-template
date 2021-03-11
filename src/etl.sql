-- drop tables
drop table if exists job_titles cascade;
drop table if exists education_titles cascade;
drop table if exists managers cascade;
drop table if exists departments cascade;
drop table if exists offices cascade;
drop table if exists contracts cascade;
drop table if exists employees cascade;

-- create tables
create table job_titles (
    job_id serial primary key,
    job_name varchar(100)
);

create table education_titles (
    title_id serial primary key,
    title_name varchar(100)
);

create table managers (
    manager_id serial primary key,
    manager_name varchar(100)
);

create table departments (
    department_id serial primary key,
    department_name varchar(100)
);

create table offices (
    office_id serial primary key,
    office_name varchar(50),
    address varchar(100),
    city varchar(50),
    state varchar(2)
);

create table contracts (
    contract_id serial primary key,
    employee_id varchar(50),
    hire_date date,
    start_date date,
    end_date date,
    salary int
);

create table employees (
    employee_id varchar(8) primary key,
    employee_name varchar(50),
    employee_email varchar(100),
    job_id int references job_titles(job_id),
    title_id int references education_titles(title_id),
    manager_id int references managers(manager_id),
    department_id int references departments(department_id),
    office_id int references offices(office_id),
    contract_id int references contracts(contract_id)
);

-- job_titles
insert into job_titles (job_name)
select distinct job_title from proj_stg;

-- education_titles
insert into education_titles (title_name)
select distinct education_lvl from proj_stg;

-- managers
insert into managers (manager_name)
select distinct manager from proj_stg;

-- departments
insert into departments (department_name)
select distinct department_nm from proj_stg;

-- offices
insert into offices (office_name, address, city, state)
select distinct location, address, city, state from proj_stg;

-- contracts
insert into contracts (employee_id, hire_date, start_date, end_date, salary)
select distinct emp_id, hire_dt, start_dt, end_dt, salary from proj_stg;

-- employees
select distinct Emp_ID, Emp_NM, Email, j.job_id, e.title_id, m.manager_id, d.department_id, o.office_id, c.contract_id
from proj_stg as staging
join job_titles as j
on staging.job_title = j.job_name
join education_titles as e
on staging.education_lvl = e.title_name
join managers as m
on staging.manager = m.manager_name
join departments as d
on staging.department_nm = d.department_name
join offices as o
on staging."location" = o.office_name
join contracts as c
on staging.emp_id = c.employee_id

