# Analyze and optimize data warehouse storage in Azure Synapse Analytics
<https://docs.microsoft.com/en-us/learn/modules/analyze-optimize-data-warehouse-storage-azure-synapse-analytics>

## Skewed data usage
- `DBCC PDW_SHOWSPACEUSED` shows number of table rows in each of the 60 distributions
- Synapse SQL pools have System Dynamic Managed Views (DMVs), sys.[view]
  - schemas
  - tables
  - indexes
  - columns
  - pdw_table_mappings
    - maps tables to local tables on nodes and distros
  - pdw_nodes_tables
    - info on local tables in distros
  - pdw_table_distribution_properties
    - distro info for table
  - pdw_column_distribution_properties
    - distro info for columns, only cols used to distribute tables
  - pdw_distributions
    - info on distros
  - dm_pdw_nodes
    - info on nodes, only compute nodes
  - dw_pdw_nodes_db_partition_stats
    - page and row-count for each partition

## Column store details
- should maximize no. rows in rowgroups
  - max is 1,047,576, good perf above 100k
- on bulk load or index rebuild, rowgroups can get trimmed for memory reasons
  - sys.dm_pdw_nodes_db_column_store_row_group_physical_stats has info on trimmings
    - `state_desc` column has useful info on rowgroup state
      - INVISIBLE: being compressed
      - OPEN: accepting new rows, not compressed
      - CLOSED: max no. rows, waiting for compression
      - COMPRESSED
      - TOMBSTONE: no longer used
    - `trim_reason_desc` col. describes trim reason
      - UNKNOWN_UPGRADED_FROM_PREVIOUS_VERSION: upgrading SQL Server version
      - NO_TRIM: compressed with max, can be less due to deletes
      - BULKLOAD: memory limited by batch size, red flag
      - REORG: forced compression from REORG command
      - DICTIONARY_SIZE: dict size too large to compress rows together
      - MEMORY_LIMITATION: not enough memory to compress rows together
      - RESIDUAL_ROW_GROUP: last row group with < 1 M rows

## Column data type impact
- row length shortened by small data types
  - `VARCHAR(25)` if longest string is 25 chars
  - only use `NVARCHAR` for Unicode
  - `NVARCHAR(4000)` or `VARCHAR(8000)` instead of e.g. `NVARCHAR(MAX)`
  - smallest int type is `tinyint` (0-255) (e.g. age)
  - `DATETIME` instead of string or int, conversion overhead is expensive
  - use `DATE` instead of `DATETIME` if time of day is unnecessary
- PolyBase load only works with < 1 MB rows, BCP always works
- [workarounds for unsupported types in dedicated SQL pools](https://docs.microsoft.com/en-us/learn/modules/analyze-optimize-data-warehouse-storage-azure-synapse-analytics/6-understand-impact-of-wrong-choices-for-column-data-types)

## Materialized views impact
- view that is stored in SQL pool, auto-updated when underlying tables change
- faster than regular views for repeated queries
- best with expensive query + small result
- optimizer looks at materialized views
- can have different distribution from base tables
- to get the most benefit, a thorough understanding of actual DB workloads and usage is required

## Rules for minimally logged operations
- logs extent allocations and meta-data changes
  - fully logged = transaction log with every row change
- only what's required for rollback
- cannot recover DB if damaged
- faster operations, more I/O efficient
- only some ops can be minimally logged:
  - `CREATE TABLE AS SELECT` (CTAS)
  - `INSERT..SELECT`
  - `CREATE INDEX`
  - `ALTER INDEX REBUILD`
  - `DROP INDEX`
  - `TRUNCATE TABLE`
  - `DROP TABLE`
  - `ALTER TABLE SWITCH PARTITION`
### Bulk load
- CTAS and `INSERT..SELECT` are bulk load
- logging mode depends on index type and load scenario:
  - heap index:
    - always minimal
  - clustered index:
    - empty target table: minimal
    - no overlap of loaded rows and existing pages: minimal
    - overlap of loaded rows and existing pages: full
  - clustered columnstore index:
    - batch size >= 102,400 per partition aligned distro: minimal
    - batch size < 102,400 per partition aligned distro: full
      - Synapse SQL pool has 60 distros, i.e. cut-off is 6,144,000 rows with even distribution
- updates to secondary or non-clustered indexes are always fully logged
### Delete with minimal logging
- `DELETE` is fully logged
- CTAS + `RENAME` to select the kept rows