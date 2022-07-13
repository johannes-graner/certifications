# Introduction to Azure Data Lake storage
<https://docs.microsoft.com/en-us/learn/modules/introduction-to-azure-data-lake-storage>

## Azure Data Lake Storage Gen2 (ADL G2)
- builds on Azure Blob storage
- Hadoop compatible access
- Access Control Lists (ACL) and Portable Operating System Interface (POSIX) permissions

## ADL vs Azure Blob storage
- hierarchical namespace optimizes I/O of high-volume data
  - directories with metadata
  - atomic dir ops (delete, rename etc.), `O(1)`
- Blob Storage better for storage without analysis
  - e.g. archival storage

## Big Data processing
- ingest
- store
- prep and train
- model and serve
