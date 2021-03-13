# data-modelling-template
Template solution of a data modelling problem.
Developed for the Data Architect Udacity Nanodegree.

The request is to develop:
- a business proposal 
- a physical implementation  
for a database migration in the context of an HR department

## Business Report
### Purpose
Migrate data from a flat excel file to a postgres database
### Current Solution
Data are stored in an excel file
### Current data available
206 rows, one for each contract signed by the company
### Additional requests
- optimized for writing
- possibility to query
- backup
- connect with payroll department
### Database admins
- Management
- HR
### Accessibility
- Public (except for salary)
### Estimated Size
max 250 rows
### Estimated Growth
max 1000 rows per year
### Sensitive Data
salary, accessible only to administrators

## Technical Report
### Technical motivation
- Integrity (duplicates)
- Security (Privacy)
### Database objects
- education_titles
- job_titles
- managers
- departments
- offices
- contracts
- employees
### Data ingestion
ETL (file to postgres)
### Data governance
- Ownership: HR Management
- User Access: Public
### Scalability
Negligible 
### Flexibility
Attendance and Time-off from calendar could be 
implemented as bi-columnar tables (day,employee_id).
They could be merged with the `employees` table
through the `employee_id` field
### Storage and Retention
- Storage: on disk, < 1Gb
- Retention:: 7 years
### Backup
- Weekly full backup
- Daily incremental backup

## ERD (Entity Relationship Diagram) 
### Conceptual
![Conceptual ERD](doc/erd/ERD_Conceptual.png)
### Logical
![Logical ERD](doc/erd/ERD_Logical.png)
### Physical
![Physical ERD](doc/erd/ERD_Physical.png)

## Additional notes:  
To forbid a user to access the salary field:
- restrict access on `contracts` table
- grant access to all fields but `salary`
e.g:
```
revoke SELECT on contracts FROM user;
grant SELECT (
    contract_id,
    employee_id,
    hire_date,
    start_date,
    end_date,
    job_id,
    manager_id,
    department_id,
    office_id
) on contracts to user;
```

## Usage
To run the sql scripts refer to [Usage.md](doc/Usage.md)