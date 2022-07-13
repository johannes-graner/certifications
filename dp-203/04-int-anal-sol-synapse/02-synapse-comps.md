# Survey the Components of Azure Synapse Analytics
<https://docs.microsoft.com/en-us/learn/modules/survey-components-of-azure-synapse-analytics/>

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
- enable analytical store on container