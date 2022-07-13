# Use Delta Lake in Azure Synapse Analytics
<https://docs.microsoft.com/en-us/learn/modules/understand-big-data-engineering-with-apache-spark-azure-synapse-analytics>

## Catalog tables
- managed table
  - no specified location
    - full table in metastore
  - dropping deletes data
- external
  - custom file location (e.g. Data Lake Gen2)
    - only metadata in metastore
  - dropping does not delete data 

## Delta Lake in SQL pool
- `OPENROWSET` with `FORMAT = 'DELTA'`
- shared access to databases in Spark metastore