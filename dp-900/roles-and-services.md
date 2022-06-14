# Roles and services
## Roles
- DB admin: manage DBs and access, backup and restore
	-	security, policies
- DE: manage infra for data, cleaning, pipelines
	-	privacy, performance
- DA: explore and analyze data for visualizations and reports

## Services
-	Azure SQL: 
	-	A SQL DB: PaaS, fully managed
	- A SQL managed instance: instance with SQL server, more flexible than DB, but more admin
	- A SQL VM: VM with SQL service, max flexibility
- Azure DBs for open-source rel. DBs:
	- MySQL
	- MariaDB: rewritten and optimized MySQL
	- PostgreSQL: allows non-rel. properties
- Azure Cosmos DB
	- NoSQL: JSON, k-v pairs, etc. (semi-structured)
	- Usually managed as part of application by developers
- Azure Storage
	- Blob containers
	- File shares: basically a NAS
	- Tables: k-v stores for fast read and write
- Azure Data Factory
	- Pipelines, ETL
- Azure Synapse Analytics
	- Unified DA solution
	- Pipelines as in ADF
	- SQL
	- Spark
	- Synapse Data Explorer: query logs and telemetry with Kusto QL (KQL)
	- Azure's answer to Databricks
- Azure Databricks
- Azure HDInsight
	- Azure-hosted clusters for Spark, Hadoop, HBase, Kafka, and Storm.
		- HBase: open-source large-scale NoSQL
		- Storm: real-time data processing
- Azure Stream Analytics
	- Stream processing
- Azure Data Explorer
	- Standalone Synapse Data Explorer
- Microsoft Purview
	-	data governance and discoverability
	- track data lineage
- Microsoft Power BI

