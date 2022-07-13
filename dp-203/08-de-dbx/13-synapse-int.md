# Databricks/Synapse integration
<https://docs.microsoft.com/en-us/learn/modules/integrate-azure-databricks-other-azure-services>

## Synapse connector
- Azure blob storage as intermediary
- PolyBase
- most suited for ETL/ELT

## SQL DW connection
- spark driver connects to Synapse with JDBC
- spark driver and execs connect to Blob Storage
  - stores bulk data
  - `wasbs` URI scheme
  - must use storage account access key
- Synapse connects to Blob Storage
  - loading and unloading of temp data
  - set `forwardSparkAzureStorageCredentials` to `true`

## Best practices
- write changes to staging table, then update real tables