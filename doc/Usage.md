## Usage
Load the mockup data in the staging table:
```
psql -f src/StageTableLoad.sql
```

Create the tables:
```
psql -f src/ddl.sql
```

Move data from Staging to 3NF database:
```
psql -f src/etl.sql
```

A set of queries are available in 
```
src/queries
```
