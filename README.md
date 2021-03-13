# data-modelling-template
Template solution of a data modelling problem.
Developed for the Data Architect Udacity Nanodegree.

The request is to develop:
- a business proposal 
- a physical implementation  
for a database migration in the context of an HR department

## Business Report
### Purpose
HR data are increasing.
Hence the company wants to ensure security and integrity of the stored data.
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
### Estimated Growth
Estimated yearly growth = 0.2%  
### Estimated Size
Minimum Duration of storage = 7 years
Expected minimum dimension = initial number of employees * (1 + yearly growth)^(number of years) = 
200*(1+20%)^7=700
Hence, a database of maximum 1500 rows is expected to be sufficient.
### Sensitive Data
salary, accessible only to HR and Management

## Technical Report
### Technical motivation
An increment in the size of data, as the one experienced by the HR department,
requires methods to :
- guarantee the access to multiple users
- maintain the integrity of the data
- enforce access restrictions to certain data
A SQL database as postgres could be a solution since:
- operations in an SQL database are treated as ACID transactions
- role based access is provided
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
The database allows the retrieval of data through queries.
Data are guaranteed to maintain integrity - thanks to ACID transactions - 
despite multiple users perform read and write operations.
### Flexibility
Data are stored in a Snowflake model.
New fields can be added to the fact table without the need of updating the existing queries.
In fact, for instance, Attendance and Time-off from the company calendar could be 
implemented as tables with two columns (day, employee_id) and
they could be merged with the `employees` table
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