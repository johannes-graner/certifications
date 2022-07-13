# Optimize data warehouse query performance in Azure Synapse Analytics
<https://docs.microsoft.com/en-us/learn/modules/optimize-data-warehouse-query-performance-azure-synapse-analytics/>

## table distribution design
- round-robin
  - fast loading
  - slow query due to shuffling
- hash
  - fast query
  - need to hash based on a column
    - don't use column with many null
- replicated
  - fast query
  - only for small tables (< 2 GB)
  - rebuild on insert/update/delete

## Indexes
- clustered columnstore
  - good for big tables (> 60 M rows)
  - does not support arbitrarily large fields
    - e.g. varchar(max)
- clustered
  - only one per table
  - very efficient if used for range finding
- non-clustered (e.g. heap)
  - best for join columns, group by columns, or `where` with few results

## Statistics
- auto-created in Synapse
- used by optimization engine

## materialized views
- only in dedicated pools
- refreshes on change of underlying tables
- some restrictions, nothing severe

## committed snapshots
- locally cache data for faster read
  - breaks ACID, but mostly analytical anyway so no problem

## result-set caching
- caches result
- max 1 TB
- purged after 48 h

