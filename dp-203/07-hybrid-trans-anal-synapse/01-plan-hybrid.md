# Work with Hybrid Transactional and Analytical Processing Solutions using Azure Synapse Analytics
<https://docs.microsoft.com/en-us/learn/modules/design-hybrid-transactional-analytical-processing-using-azure-synapse-analytics>

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