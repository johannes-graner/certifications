# Analyze data in a relational data warehouse
[https://docs.microsoft.com/en-us/learn/modules/design-multidimensional-schema-to-optimize-analytical-workloads/]

- BI-centered

## Design rel. DWH schema
- star schema
- dimensions
  - alternate/natural/business key: original id
  - surrogate key: unique to dwh
    - usually increasing int
    - makes sure sources can integrate
    - cheaper joins
    - handle slowly changing dimensions as type 2
  - denormalized for fewer joins
    - can normalize some fields to create hierarchies (snowflake schema)
- time dimension
  - e.g. dayOfWeek, DayOfMonth, Month, Quarter, etc.
  - enables easy time-based aggregation
  - *grain* = lowest granularity = finest resolution 
- facts
  - center of star schema
  - e.g. orders
  - references dimension tables

## DWH in Synapse
- dedicated SQL pool
  - collation: specify sort order and string comparison rules
- staging tables for ETL into fact/dimension
### SQL DB vs. Synapse
- Synapse does not support *foreign key* and *unique* constraints
  - must keep these constraints manually (no help from tables)
- indexes
  - default *clustered columnstore*: good for big data
  - supports usual clustered as well
- distribution
  - hash
  - round-robin: divides data evenly to nodes
  - replicated: replicates table on all nodes
  - best practices
    - dimension: replicated if small, else hash
    - fact: hash with clustered columnstore
    - staging: round-robin

## creating tables
- `IDENTITY` to create surrogate keys
- snowflake schema: include parent key in child table
- time dimension: 
  - surrogate key: numeric YYYYMMDD
  - alternate key: `DATE` or `DATETIME` datatype
- external tables: use files directly instead of loading into SQL pool

## Load tables
- source -> lake -> staging
- staging tables
  - `COPY INTO [staging table, columns] FROM [lake path] WITH [file type etc.]`
- dimension tables
  - create: `CREATE TABLE [dim table] WITH [distribution, index] AS SELECT ... FROM [staging table]`
    - need `ROW_NUMBER` instead of `IDENTITY` here
  - insert: `INSERT INTO [dim] SELECT ... FROM [staging]`
    - auto-generates row number
- time dimension
  - loop to get grain column
    - rest of table built from grain
  - alt.: create in external system (e.g. Excel), `COPY` into SQL pool
- slowly changing dimensions
  - type 0: don't allow changes
  - type 1: overwrite changes
    - `UPDATE`
  - type 2: row versioning
    - `INSERT` + `UPDATE`
    - alt.: `MERGE` (subject to constraints)
- fact tables
  - load after dimensions
  - usually has alternate keys, must be changed to surrogate
- optimize
  - `ALTER INDEX ALL ON [table] REBUILD`
  - stats table: `CREATE STATISTICS [stat table] ON [table] ([column])`

## Querying
- `JOIN` and `GROUP BY`
  - join hierarchical (normalized): join children in order to get to parent
- ranking
  - `ROW_NUMBER`
  - `RANK`
    - e.g. (5,1), (5,1), (3,3)
    - number of entities with higher rank
  - `DENSE_RANK`
    - on ties, only increment once
    - e.g. (5,1), (5,1), (3,2)
    - number of higher ranks
  - `NTILE`
    - percentile of row
    - e.g. `NTILE(4)` is quartiles
- approximation
  - `APPROX_COUNT_DISTINCT`
    - hyperloglog
    - max error 2% with 97% prob.
  - faster, good for data exploration