# Analyze data with Apache Spark in Azure Synapse Analytics
[https://docs.microsoft.com/en-us/learn/modules/understand-big-data-engineering-with-apache-spark-azure-synapse-analytics]

## Spark
- cluster manager allocates resource on Hadoop YARN cluster

## Spark in Synapse
- pyspark, scala spark, JARs
- data access
  - data lake on primary storage account
  - data lake on linked service storage account
  - SQL pool in workspace
  - Azure SQL or SQL Server DB (Spark connector for SQL Server)
  - Cosmos DB linked service with Azure Synapse Link for Cosmos DB
  - Azure Data Explorer Kusto linked service
  - external Hive metastore linked service
# Use Delta Lake in Azure Synapse Analytics
[https://docs.microsoft.com/en-us/learn/modules/understand-big-data-engineering-with-apache-spark-azure-synapse-analytics]

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
# Monitor and manage data engineering workloads with Apache Spark in Azure Synapse Analytics
[https://docs.microsoft.com/en-us/learn/modules/understand-big-data-engineering-with-apache-spark-azure-synapse-analytics]

## Monitor Spark pools in Synapse
- Monitor tab in Synapse Studio
  - Activities -> Apache Spark Applications

## Optmize Spark jobs
- Kryo data serialization
- bucketing
  - like partitioning, but each bucket holds several values

