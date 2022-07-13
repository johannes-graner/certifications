# Implement Azure Synapse Link for SQL
<https://docs.microsoft.com/en-us/learn/modules/implement-synapse-link-for-sql>

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