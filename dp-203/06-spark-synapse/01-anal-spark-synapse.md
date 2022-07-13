# Analyze data with Apache Spark in Azure Synapse Analytics
<https://docs.microsoft.com/en-us/learn/modules/understand-big-data-engineering-with-apache-spark-azure-synapse-analytics>

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