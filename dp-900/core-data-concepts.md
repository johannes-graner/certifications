# Core data concepts
## Optimized file formats
-	Avro: JSON header for each record in compressed binary
-	ORC (Optimized Row Columnar format): Optimized for Hive
	- Column-major format
	-	Stripes contain columns + stats (count, min, etc.)
-	Parquet: Chunks (partitions) of data with metadata with e.g. location for each row.

## Databases
-	Normalization reduces redundancy by referencing entities in other tables via primary keys.
### Non-relational
-	Key-value: record with unique key and some value
-	Document: Key-value with JSON value
-	Column-family: Rows and columns where columns can be grouped (e.g. nested schema in parquet)
- Graph: Nodes and edges

## Transactional systems
-	high-volume, low latency (e.g. retailer order database)
-	BOTH read and write optimized
- CRUD: Create, Read, Update, Delete
-	ACID:
	- Atomicity: Each transaction either succeeds in all steps or fails all steps
	-	Consistency: Only valid states, completed transactions are reflected in DB
	-	Isolation: Concurrent transactions don't interfere
	-	Durability: Transactions are persisted (e.g. written to disk, maybe backuped)

## Analytical data processing
- Mostly read optimized
- Data lake: raw data from e.g. transactional system
-	Data warehouse: optimized for read
	-	ETL takes Data lake -> Data warehouse (DW)
	-	fact: numerical value to analyze (target feature, e.g. sales)
	- dimension: table with entities related to fact (feature, e.g. customer, product)
- OLAP: OnLine Analytical Processing model (cube with rollup etc.)
	-	pre-aggregated data ready for very fast querying
- DS often uses DL directly to model data
-	DA often uses DW to create OLAP and reports
- Business users use OLAP to consume reports

