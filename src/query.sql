-- Q1 - query employee by name
with contracts_roles_and_departments as (
    select contract_id, j.job_name, d.department_name from contracts as c
    join job_titles as j
    on c.job_id = j.job_id
    join departments as d
    on c.department_id = d.department_id
)
select employee_name, job_name, department_name from employees as e
join contracts_roles_and_departments as c
on e.current_contract_id = c.contract_id
order by department_name

-- Q2 - Create Web programmer as title
insert into job_titles
values (default, 'Web Programmer')

-- Q3 - Correct from Web programmer to web developer
update job_titles
set job_name = 'Web Developer'
where job_name = 'Web Programmer'

-- Q4 - Delete Web Developer from database
delete from job_titles
where job_name = 'Web Developer'

-- Q5 - How many employees are in each department?
with employees_and_departments as (
    select contract_id, d.department_name from contracts as c
    join departments as d
    on c.department_id = d.department_id
)
select department_name, count(*) from employees_and_departments
group by department_name
order by count

-- Q6 - Current and past job of Toni Lembeck
with explicit_contracts as (
    select employee_id, job_name, department_name, manager_name, start_date, end_date from contracts as c
    join job_titles as j
    on c.job_id = j.job_id
    join departments as d
    on c.department_id = d.department_id
    join managers as m
    on c.manager_id = m.manager_id
)
select
employee_name, job_name, department_name, manager_name, start_date, end_date
from employees as e
join explicit_contracts as c
on e.employee_id =  c.employee_id
where employee_name = 'Toni Lembeck'
