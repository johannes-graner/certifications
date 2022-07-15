# Analyze data in a relational data warehouse
<https://docs.microsoft.com/en-us/learn/modules/design-multidimensional-schema-to-optimize-analytical-workloads/>

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
# Optimize data warehouse query performance in Azure Synapse Analytics
<https://docs.microsoft.com/en-us/learn/modules/optimize-data-warehouse-query-performance-azure-synapse-analytics/>

## table distribution design
- round-robin
  - fast loading
  - slow query due to shuffling
- hash
  - fast query
  - need to hash based on a column
    - don't use column with many null
- replicated
  - fast query
  - only for small tables (< 2 GB)
  - rebuild on insert/update/delete

## Indexes
- clustered columnstore
  - good for big tables (> 60 M rows)
  - does not support arbitrarily large fields
    - e.g. varchar(max)
- clustered
  - only one per table
  - very efficient if used for range finding
- non-clustered (e.g. heap)
  - best for join columns, group by columns, or `where` with few results

## Statistics
- auto-created in Synapse
- used by optimization engine

## materialized views
- only in dedicated pools
- refreshes on change of underlying tables
- some restrictions, nothing severe

## committed snapshots
- locally cache data for faster read
  - breaks ACID, but mostly analytical anyway so no problem

## result-set caching
- caches result
- max 1 TB
- purged after 48 h


# Integrate SQL and Apache Spark pools in Azure Synapse Analytics
<https://docs.microsoft.com/en-us/learn/modules/integrate-sql-apache-spark-pools-azure-synapse-analytics/>

## connection methods
- dedicated pool only
- JavaDataBaseConnectivity (JDBC)
  - filters and projects
  - gives data to spark serially (bad)
- JDBC + PolyBase
  - JDBC sends filters and projections to PolyBase
  - Create External Tables As Select (CETAS)
  - parallel read for spark

## Authentication
- Token Service with Azure AD
### without Azure AD
```
val df = spark.read.
option(Constants.SERVER, "samplews.database.windows.net").
option(Constants.USER, <SQLServer Login UserName>).
option(Constants.PASSWORD, <SQLServer Login Password>).
sqlanalytics("<DBName>.<Schema>.<TableName>")
```

## transfer data
- `spark.read.sqlanalytics("<DBName>.<Schema>.<TableName>")`
- `df.write.sqlanalytics("<DBName>.<Schema>.<TableName>", <TableType>)`
  - TableType is external or internal
  - if external, must specify data source and file format (created before in SQL)
- only with scala
  - connect to pyspark with temp table views 
# Understand data warehouse developer features of Azure Synapse Analytics
<https://docs.microsoft.com/en-us/learn/modules/understand-data-warehouse-developer-features-of-azure-synapse-analytics>

## Explore dev tools for Synapse
### Synapse Studio
- SQL scripts
- notebooks
- Synapse Pipelines
- Power BI reports
- Spark jobs
  - pyspark, scala, .NET
### Visual Studio (VS)
- VS 2019 SQL Server Data Tools (SSDT)
  - dedicated SQL pools
  - version control with Azure DevOps
  - CI/CD
  - View -> SQL Server Object Explorer -> Add SQL Server
### Azure Data Studio
- connect and query on-prem and cloud
  - serverless or dedicated
- Windows, macOS, Linux
### SQL Server Management Studio (SSMS)
- serverless or dedicated

## Transact-SQL (T-SQL)
- ANSI-compliant
- different features for dedicated or serverless
  - both: `SELECT`, transactions, data export (CETAS), built-in functions, aggregates, operators, control flow, DDL
  - dedicated only: `INSERT`, `UPDATE`, `DELETE`, labels, data load
  - serverless only: cross database queries
  - none: `MERGE`
- inspect execution plans (dedicated only)

## Windowing functions
- `OVER` to group
- aggregate (e.g. `COUNT`, `STDEV` etc.)
  - many-to-one rows
- analytical functions (e.g. `LAG`, `FIRST_VALUE` etc.)
  - many-to-many rows
- `ROWS` and `RANGE` to limit rows (e.g. `UNBOUNDED_PRECEDING` etc.)
- ranking (e.g. `RANK` etc.)

## Approximate execution
- for exploratory data analysis
- `APPROX_COUNT_DISTINCT`

## JSON in SQL pools
- dedicated pools
- stored as `NVARCHAR` columns
- good for JSON array -> table
- optimized with columnstore indices, mem. opt. tables
- insert
  - `INSERT`
- read
  - `ISJSON` to check validity
  - `JSON_VALUE` to get scalar value from JSON string
    - `JSON_VALUE(doc, '$.[field name]') AS [column name]`
  - `JSON_QUERY` to get JSON object or array from JSON string
- modify
  - `JSON_MODIFY` to modify a value in JSON string
  - `OPENJSON` to convert JSON collection to rows and columns
    - `CROSS APPLY OPENJSON (doc) WITH ( [col name] [col type] ['$.[field name] (only if col name != field name)] )`
- query on serverless
  - `OPENROWSET`
 - either JSON array or line-delimited JSON files (e.g. jsonl)
### Load with `OPENROWSET`
- options
  - format = 'csv'
  - fieldterminator = '0x0b'
  - fieldquote = '0x0b'
  - rowterminator = '0x0b' (JSON array only)
- can use full path or create external data source
 
## Stored procedures
- `CREATE EXTERNAL TABLE AS SELECT` (CETAS)
- reduces network traffic
  - long procedures can be stored and only execution call is sent over network
- security boundary
  - can grant permission to use procedure without granting permissions for underlying db objects
- eases maintenance
- improved performance
  - compiled on first execution, then cached
# Manage and monitor data warehouse activities in Azure Synapse Analytics
<https://docs.microsoft.com/en-us/learn/modules/manage-monitor-data-warehouse-activities-azure-synapse-analytics>

## Scale compute resources
- SQL pools
  - Portal, Synapse Studio, T-SQL, PowerShell
- Spark pools
  - always autoscales
  - set node type, min, and max no. nodes

## Pause compute resources
- pause SQL pools in Portal or Synapse Studio
- autopause available

## Manage workloads
- SQL pools have three concepts
  - workload classification
  - workload importance
  - workload isolation
### Workload classification
- e.g. load and query
- subclassifications
  - query: e.g. cube refresh, dashboard query, ad-hoc query
  - load: e.g. key sales, weather data, social media feeds
### Workload importance
- five levels: low, below_normal, normal, above_normal, high
- can set default on user basis (e.g. executives always have high to refresh their dashboards)
### Workload isolation
- reserve resources for a workload group

## Azure Advisor
- analyzes resource configs and usage
- recommends solutions for cost effectiveness, performance, reliability, and security
- Synapse
  - data skew + replicated table info
  - column stats
  - tempDB utilization
  - adaptive cache
  - checked every 24 hours

## Dynamic management views
- monitor SQL pools programmatically with T-SQL
- \> 90 views available in following areas
  - connection info and activity
    - `sys.dm_pdw_exec_sessions`
  - SQL execution requests and queries
    - `sys.dm_pdw_exec_requests`
  - index and stats
  - resource blocking and locking
  - data movement service activity
    - `sys.dm_pdw_dms_workers`
  - errors
- 10k rows of data
  - if this is too little, use Query Store
- monitor Synapse SQL pools
  - waits
  - tempdb
  - memory
  - transaction log
  - PolyBase

# Analyze and optimize data warehouse storage in Azure Synapse Analytics
<https://docs.microsoft.com/en-us/learn/modules/analyze-optimize-data-warehouse-storage-azure-synapse-analytics>

## Skewed data usage
- `DBCC PDW_SHOWSPACEUSED` shows number of table rows in each of the 60 distributions
- Synapse SQL pools have System Dynamic Managed Views (DMVs), sys.[view]
  - schemas
  - tables
  - indexes
  - columns
  - pdw_table_mappings
    - maps tables to local tables on nodes and distros
  - pdw_nodes_tables
    - info on local tables in distros
  - pdw_table_distribution_properties
    - distro info for table
  - pdw_column_distribution_properties
    - distro info for columns, only cols used to distribute tables
  - pdw_distributions
    - info on distros
  - dm_pdw_nodes
    - info on nodes, only compute nodes
  - dw_pdw_nodes_db_partition_stats
    - page and row-count for each partition

## Column store details
- should maximize no. rows in rowgroups
  - max is 1,047,576, good perf above 100k
- on bulk load or index rebuild, rowgroups can get trimmed for memory reasons
  - sys.dm_pdw_nodes_db_column_store_row_group_physical_stats has info on trimmings
    - `state_desc` column has useful info on rowgroup state
      - INVISIBLE: being compressed
      - OPEN: accepting new rows, not compressed
      - CLOSED: max no. rows, waiting for compression
      - COMPRESSED
      - TOMBSTONE: no longer used
    - `trim_reason_desc` col. describes trim reason
      - UNKNOWN_UPGRADED_FROM_PREVIOUS_VERSION: upgrading SQL Server version
      - NO_TRIM: compressed with max, can be less due to deletes
      - BULKLOAD: memory limited by batch size, red flag
      - REORG: forced compression from REORG command
      - DICTIONARY_SIZE: dict size too large to compress rows together
      - MEMORY_LIMITATION: not enough memory to compress rows together
      - RESIDUAL_ROW_GROUP: last row group with < 1 M rows

## Column data type impact
- row length shortened by small data types
  - `VARCHAR(25)` if longest string is 25 chars
  - only use `NVARCHAR` for Unicode
  - `NVARCHAR(4000)` or `VARCHAR(8000)` instead of e.g. `NVARCHAR(MAX)`
  - smallest int type is `tinyint` (0-255) (e.g. age)
  - `DATETIME` instead of string or int, conversion overhead is expensive
  - use `DATE` instead of `DATETIME` if time of day is unnecessary
- PolyBase load only works with < 1 MB row size, BCP always works
- [workarounds for unsupported types in dedicated SQL pools](https://docs.microsoft.com/en-us/learn/modules/analyze-optimize-data-warehouse-storage-azure-synapse-analytics/6-understand-impact-of-wrong-choices-for-column-data-types)

## Materialized views impact
- view that is stored in SQL pool, auto-updated when underlying tables change
- faster than regular views for repeated queries
- best with expensive query + small result
- optimizer looks at materialized views
- can have different distribution from base tables
- to get the most benefit, a thorough understanding of actual DB workloads and usage is required

## Rules for minimally logged operations
- logs extent allocations and meta-data changes
  - fully logged = transaction log with every row change
- only what's required for rollback
- cannot recover DB if damaged
- faster operations, more I/O efficient
- only some ops can be minimally logged:
  - `CREATE TABLE AS SELECT` (CTAS)
  - `INSERT..SELECT`
  - `CREATE INDEX`
  - `ALTER INDEX REBUILD`
  - `DROP INDEX`
  - `TRUNCATE TABLE`
  - `DROP TABLE`
  - `ALTER TABLE SWITCH PARTITION`
### Bulk load
- CTAS and `INSERT..SELECT` are bulk load
- logging mode depends on index type and load scenario:
  - heap index:
    - always minimal
  - clustered index:
    - empty target table: minimal
    - no overlap of loaded rows and existing pages: minimal
    - overlap of loaded rows and existing pages: full
  - clustered columnstore index:
    - batch size >= 102,400 per partition aligned distro: minimal
    - batch size < 102,400 per partition aligned distro: full
      - Synapse SQL pool has 60 distros, i.e. cut-off is 6,144,000 rows with even distribution
- updates to secondary or non-clustered indexes are always fully logged
### Delete with minimal logging
- `DELETE` is fully logged
- CTAS + `RENAME` to select the kept rows
# Secure a data warehouse in Azure Synapse Analytics
<https://docs.microsoft.com/en-us/learn/modules/secure-data-warehouse-azure-synapse-analytics>

## Network security options for Synapse
### firewall rules
- apply to all public endpoints
  - includes SQL pools (dedicated and serverless) and dev endpoint
  - Synapse studio uses TCP ports 80, 443, and 1443, UDP port 53
### virtual networks
- can create managed VNet when creating Synapse workspace
  - includes all resources except SQL pools
  - can have user-level isolation for Spark activities (Spark clusters have their own subnets)
  - SQL pools are multi-tenant, but have auto-created private links to managed VNet
### private endpoints
- only with managed VNet
- used to connect to other Azure services
- traffic never leaves Microsoft network

## Conditional access
- Conditional Access policies use signals, e.g.
  - user or group name
  - IP address
  - device platform or type
  - application access requests
  - real-time and calculated risk detection
  - Microsoft Cloud App Security (MCAS)
- If signal is detected:
  - block access completely
  - perform MFA
  - require specific device
- Available on dedicated SQL pools
  - requires Azure AD and compatible MFA

## Configure authentication
### Azure Active Directory
- centrally managed objects (users, services etc.)
- single sign-on
  - AD manages access to other resources
  - e.g. user and Synapse in same AD -> user can use Synapse
### Managed identities
- part of Azure AD
- gives service identity in AD
### SQL auth
- for accessing dedicated SQL pool
- for users outside Azure AD
- useful for external users or 3rd-party apps
### Keys
- e.g. access Azure Data Lake without AD
- storage account keys
  - full access to everything
  - use Azure Key Vault to manage keys
- shared access signatures
  - for external 3rd-party apps or untrusted clients
  - can be attached to URL
  - can give temporary access by setting timeout
  - service level 
    - specific resources in storage account
    - e.g. list files or read access
  - account level
    - everything at service level + more
    - e.g. create file systems

## Column and row level security
### Column level security
- access only certain columns in DB
  - e.g. only doctors and nurses can see medical records, not billing department
- `GRANT` T-SQL statement
### Row level security
- access only to specific rows
  - e.g. only access to customers in specific region
  -  only filter predicates can be used
- `CREATE SECURITY POLICY[!INCLUDEtsql]` statement
### Permissions
- to manage security policies, you need `ALTER ANY SECURITY POLICY` permission
- [some other permissions](https://docs.microsoft.com/en-us/learn/modules/secure-data-warehouse-azure-synapse-analytics/5-manage-authorization-through-column-row-level-security)
### Best practices
- create RLS objects (predicate functions, sec. policies)
  - separate permissions for for table and RLS objects
- `ALTER ANY SECURITY POLICY` only for highly privileged users
  - this user should not need `SELECT` on protected tables

## Sensitive data and Dynamic Data Masking
- limited data exposure to non-privved users
- policy-based
- e.g. mask all but last four digits of credit card number
- admins are never subjected to masks

## Encryption
### Transparent Data Encryption (TDE)
- encrypts data at rest
- real-time enc. and dec. of DB, backups, trans. logs
  - at page level
- manually enabled
- symmetric key, Database Encryption Key (DEK)
  - protected by Transparent Data Encryption Protector (TDEP)
    - set on server level
    - service-managed certificate or asymmetric key in Azure Key Vault
#### Service-managed TDE
- built-in certificate
- AES-256
- rotated automatically
- root key in Microsoft internal secret store
#### TDE with bring-your-own-key
- asymmetric key in Azure Key Vault
- full control over key management
#### Moving TDE protected DB
- within Azure
  - no decryption
  - settings inherited
- outside Azure (export)
  - delivered in unencrypted BACPAC file
### TokenLibrary for Spark
- for external data access (linked services)
- not needed for Data Lake Gen2
- `val connectionString = com.microsoft.azure.synapse.tokenlibrary.TokenLibrary.getConnectionString("<Linked service name>")`
  - or `.getConnectionStringAsMap(...)` to get e.g. account key
