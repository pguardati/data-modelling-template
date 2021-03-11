-- drop tables
drop table if exists education_titles cascade;
drop table if exists job_titles cascade;
drop table if exists managers cascade;
drop table if exists departments cascade;
drop table if exists offices cascade;
drop table if exists contracts cascade;
drop table if exists employees cascade;

-- create tables

create table education_titles (
    title_id serial primary key,
    title_name varchar(100)
);

create table job_titles (
    job_id serial primary key,
    job_name varchar(100)
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
    salary int,
    job_id int references job_titles(job_id),
    manager_id int references managers(manager_id),
    department_id int references departments(department_id),
    office_id int references offices(office_id)
);

create table employees (
    employee_id varchar(8) primary key,
    employee_name varchar(50),
    employee_email varchar(100),
    title_id int references education_titles(title_id),
    current_contract_id int references contracts(contract_id)
);

-- education_titles
insert into education_titles (title_name)
select distinct education_lvl from proj_stg;

-- job_titles
insert into job_titles (job_name)
select distinct job_title from proj_stg;

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
insert into contracts (employee_id, hire_date, start_date, end_date, salary, job_id, manager_id, department_id, office_id)
select distinct emp_id, hire_dt, start_dt, end_dt, salary, j.job_id, m.manager_id, d.department_id, o.office_id
from proj_stg as staging
join job_titles as j
on staging.job_title = j.job_name
join managers as m
on staging.manager = m.manager_name
join departments as d
on staging.department_nm = d.department_name
join offices as o
on staging."location" = o.office_name;

-- employees
insert into employees
(employee_id, employee_name, employee_email, title_id, current_contract_id)
with employees_updated as (
    -- select most recent record of each employee
    select *
    from (
        select *, row_number() over ( partition by emp_id order by start_dt desc) as contract_number
        from proj_stg
       )
    as staging
    where contract_number=1),
contracts_updated as (
    -- select most recent contract of each employee
    select *
    from (
        select *, row_number() over ( partition by employee_id order by start_date desc) as contract_number
        from contracts
       )
    as staging
    where contract_number=1
)
select distinct
    Emp_ID, Emp_NM, Email, e.title_id, c.contract_id as current_contract_id
from employees_updated as staging
join education_titles as e
on staging.education_lvl = e.title_name
join contracts_updated as c
on staging.emp_id = c.employee_id
