# Introduction to Azure Synapse Analytics
[https://docs.microsoft.com/en-us/learn/modules/introduction-azure-synapse-analytics/]

## Overview
- distributed query system
- spark
- pipelines
- synapse link
  - operational data

## When to use
- data warehousing
- advanced analytics
- data exploration
- real time analytics
- data integration# Survey the Components of Azure Synapse Analytics
[https://docs.microsoft.com/en-us/learn/modules/survey-components-of-azure-synapse-analytics/]

## Synapse SQL
- DWH
  - permanent tables populated by ADF or Synapse pipelines
- Data virtualization
  - load into data lake and transform
  - allows analysis without knowledge of underlying data structure
### dedicated vs. serverless
- dedicated
  - predictable performance and cost
- serverless
  - ad hoc workloads
  - exploration, preparation for virtualization

## Synapse Spark
- cluster spins up in 2 min for < 60 nodes, 5 mins for > 60 nodes
  - spins down 5 min after last job (unless notebook)
- Data Lake Gen2 or Blob storage
- can integrate with e.g. Azure Databricks
- pre-installed libraries

## Synapse pipelines
- mostly the same as ADF pipelines
  - linked service
  - dataset
  - activity
  - pipeline

## Integrate with Power BI
- can use Power BI in Synapse Studio

## Hybrid transactional analytical processing with Synapse Link
- link e.g. Cosmos DB with Synapse
- must enable on target resource
- copies data from target to Synapse container
- enable analytical store on container# Explore Azure Synapse Studio
[https://docs.microsoft.com/en-us/learn/modules/explore-azure-synapse-studio/]

## Analytical processes
- DWH
  - ingest/prepare
  - make ready for analytical tools
  - provide access for visualization tools

## Data hub
- stored procedures
  - T-SQL or pipeline
- linked -> primary storage
  - data lake for synapse

## Develop hub
- SQL scripts
- Notebooks
  - spark
- Data flows
- Power BI

## Integrate hub
- basically ADF in Synapse

## Monitor hub
- pipeline runs
- trigger runs
  - triggered runs
- integration runtimes
- apache spark applications
  - running and finished
- SQL requests
- Data flow debug

## Manage hub
- SQL pools
  - pause, scale
- spark pools
  - auto-pause, auto-scale
- linked services
- Purview
- triggers
- IRs
- access control
  - workspace admin
  - SQL admin
  - Apache Spark for Azure Synapse Analytics admin
- credentials
- managed pritvate endpoints
  - private IP from VN
- workspace packages
  - spark packages
- git configuration# Design a Modern Data Warehouse using Azure Synapse Analytics
[https://docs.microsoft.com/en-us/learn/modules/design-modern-data-warehouse-using-azure-synapse-analytics/]

## Modern DWH
- 3 Vs
  - Volume
  - Variety
  - Velocity

## Storage for modern DWH
- load from source to staging area
  - reduce load on source (e.g. SQL Server)
  - different schedules for different sources
  - join from different sources
    - helped by mapping tables with metadata for different sources (e.g. column names)
  - rerun failed loads from staging area
  - Data Lake Gen2

## File formats and structure
### batch ingest
- native support
  - ORC
  - JSON
  - CSV
  - parquet
- spark for others
### streaming ingest
- Event/IoT Hub -> Stream Analytics -> DL G2 -> Synapse
  - can skip DL G2 by streaming directly into Synapse SQL pool
### recommended formats
- raw
  - native
  - relational: csv
  - web, NoSQL: JSON
- refined
  - parquet
### bz/ag/au
- bronze: raw
- silver: query ready
- gold: report ready\n
