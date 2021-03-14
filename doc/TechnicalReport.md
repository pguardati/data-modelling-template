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
In fact, for instance, Attendance and Time-off from a company calendar could be 
implemented as tables with two columns (day, employee_id) and
they could be merged with the `employees` table
through the `employee_id` field
### Storage and Retention
- Storage: on disk, < 1Gb
- Retention:: 7 years
### Backup
- Weekly full backup
- Daily incremental backup

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
