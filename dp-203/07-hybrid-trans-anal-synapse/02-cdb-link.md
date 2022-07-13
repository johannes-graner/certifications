# Implement Azure Synapse Link with Azure Cosmos DB
<https://docs.microsoft.com/en-us/learn/modules/configure-azure-synapse-link-with-azure-cosmos-db/>

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