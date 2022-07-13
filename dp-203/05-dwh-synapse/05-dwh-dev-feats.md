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
  - `OPERJSON` to convert JSON collection to rows and columns
    - `cross apply openjson (doc) with ( [col name] [col type] ['$.[field name] (only if col name != field name)] )`
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