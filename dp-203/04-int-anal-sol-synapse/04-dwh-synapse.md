# Design a Modern Data Warehouse using Azure Synapse Analytics
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
- gold: report ready