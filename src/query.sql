-- Q1 - query employee by name
select employee_id, employee_name, j.job_name, d.department_name
from employees as e
join job_titles as j
on e.job_id = j.job_id
join departments as d
on e.department_id = d.department_id
order by e.employee_name

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
    select employee_id, department_name from employees as e
    join departments as d
    on e.department_id = d.department_id
)
select department_name, count(*) from employees_and_departments
group by department_name
order by count

-- Q6 - Current and past job of Toni Lembeck
select
employee_name, job_name, department_name, manager_name, start_date, end_date
from employees as e
join contracts as c
on e.employee_id =  c.employee_id
join job_titles as j
on e.job_id = j.job_id
join departments as d
on e.department_id = d.department_id
join managers as m
on e.manager_id = m.manager_id
where employee_name = 'Toni Lembeck'

-- FIX: job , department, manager depends from the contract