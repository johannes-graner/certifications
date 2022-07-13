# Use data loading best practices in Azure Synapse Analytics
<https://docs.microsoft.com/en-us/learn/modules/use-data-loading-best-practices-azure-synapse-analytics/>

## design goals
- balance load and query
### considerations
- source of data?
- new entities or updates?
- data velocity?
- data formats?
- are transformations needed?
- ETL or ELT?
- simplicity vs robustness
- load vs query

## loading methods
- directly from storage
  - T-SQL `COPY`
- Synapse pipeline/Data Flows
- PolyBase
  - external data source
- note: T-SQL `COPY` is the most flexible

## managing source files
- SQL pools have storage in 60 segmented parts
  - align number of data files with this

## singleton updates
- massively parallel system
  - don't do many small updates
  - do one big batch

## deicated load accounts
- don't use admin account for loads
  - only uses smallrc resource class (3-25%)
### creating loading user
```
CREATE LOGIN loader WITH PASSWORD = '...';
```
```
-- Connect to the SQL pool
CREATE USER loader FOR LOGIN loader;
GRANT ADMINISTER DATABASE BULK OPERATIONS TO loader;
GRANT INSERT ON <yourtablename> TO loader;
GRANT SELECT ON <yourtablename> TO loader;
GRANT CREATE TABLE TO loader;
GRANT ALTER ON SCHEMA::dbo TO loader;

CREATE WORKLOAD GROUP DataLoads
WITH ( 
    MIN_PERCENTAGE_RESOURCE = 100
    ,CAP_PERCENTAGE_RESOURCE = 100
    ,REQUEST_MIN_RESOURCE_GRANT_PERCENT = 100
    );

CREATE WORKLOAD CLASSIFIER [wgcELTLogin]
WITH (
        WORKLOAD_GROUP = 'DataLoads'
    ,MEMBERNAME = 'loader'
);
```

## workload management
- classification
  - load: insert, update, delete
  - query: select
- importance
  - high importance -> first in request queue
- isolation
  - reserve resources