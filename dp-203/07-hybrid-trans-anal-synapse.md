# Work with Hybrid Transactional and Analytical Processing Solutions using Azure Synapse Analytics
[https://docs.microsoft.com/en-us/learn/modules/design-hybrid-transactional-analytical-processing-using-azure-synapse-analytics]

## Hybrid Transactional / Analytical Processing (HTAP)
- trans. data is replicated automatically to analytical store
- in Synapse, provided by Azure Synapse Link services
- OLTP optimized for latency and throughput of writes
- OLAP optimized for complex queries (reads)

## Synapse Link
- Cosmos DB
  - near-real-time analytics on data in Cosmos DB container
  - Cosmos has auto-synced row-based (r/w) and column-based (analysis) versions of the store
    - analytical store available in Synapse
- SQL Server
  - rel. db as tables in SQL Server
  - Synapse replicates table data to dedicated SQL pool
- Microsoft Dataverse
  - stores business table for Power Apps, Power BI, etc. (MS 365, Dynamics 365, Azure)
  - Synapse replicates table data to Data Lake Storage
    - accessed through SQL or Spark pool
# Implement Azure Synapse Link with Azure Cosmos DB
[https://docs.microsoft.com/en-us/learn/modules/configure-azure-synapse-link-with-azure-cosmos-db/]

## Enabling Synapse Link
- supported for Core (SQL) and MongoDB APIs
- enable in Cosmos DB -> Features
- considerations
  - cannot disable once enabled
  - must create analytical store enabled container in CDB
  - when enabling through Azure CLI or PowerShell, can specify WellDefined (default) or FullFidelity schema for SQL API
    - for MongoDB, only FullFidelity
  - schema type cannot be changed later

## Create analytical store enabled container
- container with column-based and row-based stores within the same container
  - auto-sync pulls changes to row-based into col-based
### Schema type
- well-defined
  - first non-null occurrence of field determines column data type
    - non-matching subsequent occurrences are ignored and not ingested
- full fidelity
  - data type is appended to column name
  - same column name can have different data types (e.g. `productID.int32` and `productID.string`)
### Enabling analytical store
- Portal
  - turn on when creating container
  - for existing containers: Cosmos DB -> Integration -> Azure Synapse Link 
- Azure CLI
- Azure PowerShell
### Considerations
- cannot disable analytical store support without deleting container
- can set analytical store TTL value to 0 or `null`, disabling sync
  - cannot re-enable afterwards

## Cosmos DB linked service
- linked CDB and containers in Data page in Synapse Studio
- different icon for analytical store enabled

## Query CDB with Spark
- read: `spark.read.format("cosmos.olap").option("spark.synapse.linkedService", "<service name>").option("spark.cosmos.container", "<container name>").load()`
- write syntax similar to read
  - updates operational (row-based) store, changes are synced to analytical store
- data loaded from analytical store

## Query CDB with Synapse SQL
- `OPENROWSET('CosmosDB', 'Account=<acc name>;Database=<db name>;Key=...==', [container name])`
  - key in Cosmos DB -> Keys
  - can also use credential (SAS)
- can specify schema as `OPENROWSET(...) WITH ([col1] [type1], [col2] [type2], ...)`
  - can be used to extract nested JSON fields
- for views, create a new database
  - used-def. views not supported in master db
  - database should use UTF-8 based collation
- considerations for serverless SQL pools
  - use same region for pool and CDB (CDB can be geo-replicated)
  - when using string cols, use explicit `WITH` clause with appropriate data length for strings
# Implement Azure Synapse Link for SQL
[https://docs.microsoft.com/en-us/learn/modules/implement-synapse-link-for-sql]

## Synapse Link for SQL
- Azure SQL DB or SQL Server 2022 with trans. rel. db
  - !NOT! SQL Managed Instance
- Synapse Link replicates table data to dedicated SQL pool
  - query without affecting trans. db
- uses *change feed* in SQL DB/Server
  - monitors trans. log
  - SQL DB: changes applied directly to SQL pool
  - SQL Server: changes staged in Data Lake Gen2 before applied to SQL pool

## Config SQL DB
- *link connection* maps tables in DB to pool
  - copies snapshot, applies subsequent changes directly
- config in SQL DB
  - managed identity on SQL DB
    - workspace identity must have db_owner role
  - firewall rules so Azure services can access SQL DB
- config in Synapse
  - dedicated SQL pool
    - needs same schema name (e.g. dbo)
- create link
  - Synapse Studio -> Integrate -> linked connection
  - linked service for SQL DB
  - specify tables
  - specify resources for sync
    - 4 extra driver cores are added
- configure index and distribution

## Config SQL Server 2022
- *link connection* maps tables in Server to pool
  - copies parquet for tables to DL G2, then imports to pool
  - changes copied as csv to DL G2 and applied to pool
- sync. by self-hosted IR installed on Windows computer with direct access to SQL Server
- create landing zone
  - can't use default storage account in Synapse
- need master key in SQL Server and SQL pool
- linked service for SQL Server
  - specify self-hosted IR
- linked service for DL G2
  - Synapse workspace must have Storage Blob Data Contributor on storage account
