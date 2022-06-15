# Fundamentals of Modern Data Warehousing
- infra for large-scale analytics and BI

Usually four steps:
- ETL from trans. data stores, files, streams etc. -> data lake/wh
  - optimize for analytical queries
  - often distributed
- Analytical data store
  - rel. data wh, data lakes, or hybrid
- Analytical data model
  - pre-aggregated "cubes"
- Data visualization
  - reports, dashboards etc.
  - consumed by non-technical personnel

## Ingestion pipelines
- Can use Data Factory or Synapse Analytics
- Activities operate on data
- linked services load and process data
  - Linked service must be published in Synapse before use

## Analytical data stores
### Data warehouse
- rel. DB optimized for analytics
  - often denormalized
- Numeric values in central **fact** tables
  - one or more **dimension** tables with entities to aggregate over
  - e.g. fact = sales orders
    - dim1 = customer
    - dim2 = product
    - dim3 = store
    - dim4 = time
  - called a **star schema**
    - Extension to **snowflake schema** by adding tables to dimensions (e.g. product categories)
- Good choice for trans. data easily organized into rel. DB where we want to use SQL

### Data Lake
- General file store, often distributed for high-performance access
- schema-on-read for (semi-) structured data

### Hybrid approaches
- lake database / data lakehouse
  - raw data in lake
  - rel. storage layer abstracts underlying files 
  - e.g. Delta Lake
- PolyBase in Synapse Analytics

### Services for analytical stores
- Synapse Analytics
  - end-to-end
  - Synapse Studio interface
- Databricks
  - common on multiple clouds
- HDInsight
  - supports open-source cluster types
  - not as user-friendly

### Notes on Synapse
- Execute permissions must be set on all directories affected by a query, in addition to read permission on files.