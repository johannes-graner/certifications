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