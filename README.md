# data-modelling-template
Template solution of a data modelling problem.
Developed for the Data Architect Udacity Nanodegree.

The problem is to develop:
- a business proposal 
- a physical implementation  
for a database migration in the context of an HR department

## Business Report
### Purpose
Migrate data from a flat excel file to a postgres database
### Current Solution
Data are stored in an excel file
### Current data available
206 rows
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
salary, restricted for administrators

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
- Ownership: HR Managment
- User Access: Public
### Scalability
Negligible 
### Flexibility
Attendance and Time-off could be 
implemented as bi-columnar tables (day,employee_id)
an be synced through employee_id with the employee database
### Storage and Retention
- Storage: on disk, < 1Gb
- Retention:: 7 years
### Backup
Critical data:
- Weekly full backup
- Daily incremental backup

## ERD (Entity Relationship Diagram) 
# Conceptual
TODO <-------------------------------------------------------------
# Logical
TODO <-------------------------------------------------------------
# Physical
TODO <-------------------------------------------------------------

## Implementation

Load the mockup data in the staging table:
```
src/StageTableLoad.sql
```

Create the tables:
```
src/ddl.sql
```

Move data from Staging to 3NF database:
```
src/etl.sql
```

Test queries are available in `src/queries`

Additional notes:
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