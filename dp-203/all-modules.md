# Identify the tasks of a Data Engineer in a cloud-hosted architecture
## Jobs roles
### Data Engineer
- set up platform tech
- make sure data integration works
- identify data requirements
### Data Scientist
- analytics
- exploratory data analysis
- develop ML models
### AI Engineer
- apply prebuilt models from frameworks and services
- more like a developer who uses AI in applications

## DE process
- design data solutions
- deploy said solutions
- secure solutions
- availability and disaster recovery
- moniter systems and solutions
### ETL
- monitor jobs through logging
### Example of full pipeline
- [Contoso Health Network](https://docs.microsoft.com/en-us/learn/modules/data-engineering-processes/4-architecturing-project)
# Choose a data storage approach in Azure
[https://docs.microsoft.com/en-us/learn/modules/choose-storage-approach-in-azure/]
## Classify your data
- structured, semi-structured, unstructured
### semi-structured
- serialization languages
  - XML, JSON, YAML, etc.

## Determine operational needs
- lookups
  - indexing/hashing
- latency
- complexity of queries
- volume of CRUD ops

## Group ops into transactions
- transaction = logical group of DB operations that execute together
- ACID
  - Atomicity: all or none succeed
  - Consistency: DB is consistent before and after trans.
  - Isolation: different transactions are independent
  - Durability: results of transactions are persisted

## Services
- Cosmos DB
  - NoSQL, semi-structured
  - indexes every property
- Blob storage
  - works with Az Content Delivery Network
    - caching
    - moves data to edge servers# Create an Azure storage account
[https://docs.microsoft.com/en-us/learn/modules/create-azure-storage-account/]
## No. accounts needed
### Storage account settings
- Subscription: billing unit
- Location: which datacenter
- Performance
  - standard: HDD
  - premium: SSD, more services
- Replication
  - local: disk failure
  - geo: data center failure
- Access tier: hot/cool/archive
- Secure transfer required: HTTPS vs HTTP
- Virtual networks: specify vn's to accept requests from
### How many accounts are needed?
- Can reuse accounts with exactly the same settings as required.
- Depends on data diversity, cost sensitivity, tolerance for management overhead
  - Data diversity: e.g. data by region, sensitivity level
  - Cost sensitivity: e.g. geo-redundant, premium tier
  - tol. for man. oh: each account needs admin time

## Choose account settings
- deployment model: use resource manager
- account kind
  - general v2: for most things, cheapest storage
  - general v1: slightly cheaper trans. than v2, less features
  - blob: don't choose this

## Notes
- Name must be globally unique (part of URI)# Connect an app to Azure Storage
[https://docs.microsoft.com/en-us/learn/modules/connect-an-app-to-azure-storage/]
## Azure storage services
- up to 250 accounts per subscription
- up to 5 PiB per account
### Types
- blobs
  - block, page, append
- Files
  - cloud NAS
- Queue
  - messages, up to 64 KB per message
  - async processing
- Table

## create acc
`
az storage account create \
  --resource-group learn-719c5238-a338-4029-a23f-78b2a0db9e0b \
  --location westus \
  --sku Standard_LRS \
  --name <name>
`

## Interact through APIs
- REST
  - need to manually parse XML
- client library
  - e.g. .NET, Java, Python, Node, Go
  - wrappers around REST API

## Connect to acc
- Access key
  - connection string
- REST API endpoint
  - e.g. ```https://[name].blob.core.windows.net/```# Secure you Azure Storage Account
[https://docs.microsoft.com/en-us/learn/modules/secure-azure-storage-account/]
## Security in Azure storage
- Encryption at rest
  - Storage Service Encryption (SSE)
    - 256-bit AES
    - FIPS 140-2 compliant
  - virtual disks (VHDs) for VMs
    - Azure Disk Encryption
    - BitLocker for Windows
    - dm-crypt for Linux
- Encryption in transit
  - can enforce HTTPS only by *secure transfer*
    - also enforces SMB 3.0 for file shares
- CORS support
  - Cross-Origin Resource Sharing
  - system for restricting GET requests
  - optional flag on storage accounts
- Role-Based Access Control (RBAC)
- Auditing
  - Storage Analytics Service
  - logs every operation

## Account keys
- Better to use Azure AD when possible
  - blob, queue
- control everything in account
  - use only for in-house apps

## Shared Access Signatures (SAS)
- instead of access keys for untrusted 3rd-party apps
- service-level: access to that service
- account-level: service-level + more (e.g. create file systems)
- can provision SAS programmatically for 3rd-party authentication

## Advanced Threat Protection
- Microsoft Defender for Storage
- monitoring, anomaly detection
  - sends alerts
- Blob, Files, Data Lake Gen2
- account types: general v2, block blob, blob storage

## Data Lake
- RBAC
- POSIX-compliant ACLs (read, write, execute)
- Azure AD OAuth 2.0# Store application data with Azure Blob Storage
[https://docs.microsoft.com/en-us/learn/modules/store-app-data-with-azure-blob-storage/]
- any number of containers in account
  - any number of blobs in container
- name-value metadata can be attached
  - cannot filter by this

## Designing a storage organization strategy
### Storage accounts
- Can use several accounts to separate costs and access
### Containers/Blobs
- Apps with other DB
  - GUID as blob name
    - referenced in internal DB in app
- Other apps
  - virtual directories
  - file extensions
- public access
  - off by default
  - turns off authentication on container level
  - good for public files
  - very scalable
    - no traffic in server-side app
- virtual directories
- blob types
  - block: most cases14
  - append: streaming or logs
  - page: random access# Integrate data with Azure Data Factory or Azure Synapse Pipeline
[https://docs.microsoft.com/en-us/learn/modules/data-integration-azure-data-factory/]

## Understanding ADF
- orchestrate movement and transformation of data
- ETL, data integration
- visually or through services (HDInsight Hadoop, Databricks etc.)
- most features available in Synapse as well (as Pipelines)
- visualizations with dependencies

## Data integration patterns
### ETL
- Extract
  - define data source
  - define the data
- Transform
  - define transformations
- Load
  - define destination
  - start job
  - monitor job
### ELT
- Land data in destination, then transform
- Great for unstructured data
- Can use same raw data in multiple systems and pipelines

## Data Factory process
- Four steps
  - Ingest
    - connectors to >100 services
  - Prepare (for transformation)
  - Transform and Analyze
    - Databricks, Azure ML
  - Publish
    - Azure DWH, Azure SQL DB, Cosmos DB, etc.
- Monitor pipeline
  - Azure Monitor, API, PowerShell, Azure Monitor logs, health panels in Azure Portal

## ADF components
- Linked Service
  - e.g. fire up compute on demand
  - define data sources
- Datasets
  - data structure in Linked Service
- Activities
  - transformation logic
  - e.g. Copy for ingest, Mapping for transf.
  - can be stored procedure
- Pipeline
  - group of activities
  - can schedule execution
  - triggers
  - Control flow: activity graph, looping, etc.
  - Parameters: read-only k-v pairs
    - can be specified by trigger
- integration runtime
  - bridge between Linked Service and Activity
  - provides compute environment
  - Azure, Self-hosted, Azure-SSIS (SQL Server Integration Services)

## ADF security
- to create ADF
  - *contributor*, *owner*, or *administrator* of subscription
- create and manage DF objects
  - Azure Portal: *Data Factory Contributor* of resource group
  - PowerShell/SDK: *Contributor* at resource level
### *Data Factory Contributor* Role
  - create, edit, delete DF and child resources (datasets, pipelines etc.)
  - deploy templates
  - manage App Insights alerts
  - create support tickets

## Set up ADF
- Necessary
  - Name
  - Subscription
  - Resource Group
  - Version: V2 for latest features
  - Location
- Optional
  - enable git: source control 
- can provision programmatically

## Create Linked Services
- similar to connection strings for e.g. containers
- over 100 connectors available
- can create with JSON
  - name: required
  - type: required
  - typeProperties: required
    - e.g. connection string
  - connectVia: optional
    - specifies integration runtime

## Create Datasets
- can create with JSON
  - name: required
  - type: required
  - typeProperties: required
  - schema: optional

## Create Activities and Pipelines
### three categories
- data movement
- data transformation
- control
  - e.g. execute pipeline, foreach, if, wait
- create Activity with JSON
  - name: required
  - type: required
  - linkedServiceName: depends
    - req. for HDInsigh, ML Batch Scoring, Stored Procedure
  - typeProperties: optional
  - description: optional
  - policy: optional
    - e.g. timeout/retry
  - dependsOn: optional
- create Control Activity with JSON
  - name: req.
  - description: req.
  - type: req.
  - typeProperties: opt.
  - dependsOn: opt.
- create Pipeline with JSON
  - name: req.
  - activities: req.
  - description: opt.
  - parameters: opt.

## Integration Runtimes
- Data Flow
  - execute data flow in managed Azure compute
- Data Movement
  - copy data from public/private network
  - connectors, conversion, mapping
- Activity Dispatch
  - dispatch and monitor transf. activities
- SSIS package execution
  - execute SSIS packages in managed Azure compute
### Types
- Azure
  - public: Data Flow Data movement Activity dispatch
  - private: N/A
- Self-hosted
  - pub/priv: Data movement Activity dispatch
- Azure-SSIS
  - pub/priv: SSIS package execution
### Determine correct runtime
- Copy
  - Azure-Azure: Azure IR
  - Azure-priv: self-hosted
  - priv-priv: self-hosted
- Lookup, GetMetadata: data store IR
- transf.: target IR
- Data Flow: associated IR# Petabyte-scale ingestion with Azure Data Factory or Azure Synapse Pipeline
[https://docs.microsoft.com/en-us/learn/modules/petabyte-scale-ingestion-azure-data-factory/]

## IR
- can set up on Azure VM via ARM template

## Security considerations
### Networks
Virtual Networks
- e.g. self-hosted IR on server in VN
- Network Security Group (NSG) can restrict access
- Azure-SSIS with VN has port 3389 open by default
  - close this

Network intrusions
- Azure Security Center Integrated Threat Intelligence

Network service tags
- groups IP addresses for admin purposes

### IAM
Admin accounts
- should be protected
- maybe even dedicated machines

Azure AD
- ADF can be associated with a managed identity

### Data protection
- RBAC
- sensitive info/data
  - maintain list of sensitive data stores
  - isolate them
  - monitor, block unauth access
  - encrypt

### Logging
- Azure Monitor
- NSG flow logs for IR deployments -> Azure Storage
- Activity Alerts, Log Analytics
- diagnostic logs
  - default 45 days# Perform code-free transformation at scaline with Azure Data Factory or Azure Synapse Pipeline
[https://docs.microsoft.com/en-us/learn/modules/code-free-transformation-scale/]

## Transformation methods
- Mapping Data Flow
  - visual transf. tool
  - spark clusters
- SSIS (SQL Server Integration Services)
  - usually custom packages for ingest/transfrom
  - lift and shift to Azure

## Transformation types
- schema modifier transf.
- row modifier transf.
  - e.g. sort
- multiple input/output transf.
  - generate or merge pipelines
  - e.g. union
### Expression builder
- visual helper for building SQL queries

## Power Query
- data preparation for people who don't know spark or SQL
- similar interface as Excel

## ADF and Databricks
Usual steps
- Storage account for ingest and transf.
- ADF
- Pipeline with copy: Extract, Load
- Databricks notebook in pipeline: Transform
- Analyze in Databricks

## SSIS
# Populate slowly changing dimensions in Azure Synapse Analytics pipelines
[https://docs.microsoft.com/en-us/learn/modules/populate-slowly-changing-dimensions-azure-synapse-analytics-pipelines]
- Slowly Changing Dimensions (SCD) are tables that handle changes to dimension valeus

## Describe SCD
- value of business entity changes without schedule
  - e.g. customers' contact details
- any SCD table should have column for mod. time

## SCD types
- Type 1
  - reflects latest values
  - dimension table is overwritten on update
  - use for supplementary values
- Type 2
  - supports versioning
  - add new row on update
  - isCurrent column
  - start and end date columns
- Type 3
  - old value kept in another column
  - keeps track of one change at a time
  - only for few versioned columns
- Type 6
  - combines 1,2,3
  - # Orchestrate data movement and transformation in Azure Data Factory or Azure Synapse Pipeline
[https://docs.microsoft.com/en-us/learn/modules/orchestrate-data-movement-transformation-azure-data-factory/]

## Control Flow
- chaining
  - dependsOn property in Activity
- branching
- parameters
  - can be defined by trigger
- state passing
  - access output of previous activites
- looping
- trigger-based flows
- invoke another pipeline
- delta flows
  - only load changed data
  - e.g. lookup
- web activity
  - call custom REST endpoints
- get metadata
  - metadata of anything in ADF

## Working with pipelines
- dependencies between activities
  - success
  - failure
  - skipped
  - completed
- If no dependencies are specified, stages are run in parallel

## Debugging a pipeline
- set breakpoints to avoid running whole pipeline
- best practices
  - use test folders for copy activity
  - debug first, then publish
- Data Flow debug session 
  - preview data flow stages
    - can set different e.g. row limits
  - spins up small Spark cluster
  - separate sessions are created for separate users
- debug run history clears after 15 days

## Parametrize linked services in ADF
- e.g. connect to several databases on same SQL server
- can be done in Portal or programmatically
- built-in parametrization for some services
- global parameters
  - under Manage
  - can be overridden by CI/CD
    - ARM templates (recommended)
    - PowerShell script

## Spark notebooks in Synapse
- Parameter cells
  - vars in this cell can be overwritten by pipeline parameters

## Azure-SSIS
- run packages in SSIS catalog (SSISDB)
  - paks hosted in SQL DB/SQL managed instance
- run packages in file system
- tools available
  - SQL Server Data Tools (SSDT)
  - SQL Server Management Studio (SSMS)
  - Azure Data Studio
  - cli# Execute existing SSIS packages in Azure Data Factory or Azure Synapse Pipeline
[https://docs.microsoft.com/en-us/learn/modules/execute-existing-ssis-packages-azure-data-factory/]

## SSIS
- platform for developing ETL since 2005
- component of SQL Server
- workflows in packages
  - grouped into projects
    - parameters

## Azure-SSIS IR
- Assumes SSISDB on SQL Server SSIS instance
- should be close to server with SSISDB
  - for on-prem, create server in VN connected to on-prem

## Migrate packages to ADF
- check compatibility
  - Data Migration Assistant (DMA)
    - migration blockers: issues with SSIS and IR
    - information issues: e.g. deprecated features
- migrate jobs
- store packages
  - SSISDB
  - file system
  - MSDB in SQL Server
  - SSIS Package Store
### DMA
- replaces SQL Server Upgrade Advisor
- sources
  - SQL Server 20-: 05, 08, 08 R2, 12, 14, 16, 17 on Windows
- targets
  - SQL Server 20-: 12, 14, 16, 17 on Windows and Linux
  - Azure SQL DB
  - Azure SQL Managed Instance
- best practices
  - don't run DMA directly on SQL Server host
  - run assessments during off-peak
  - perform compat. issues and new feat. rec. separately
  - migrate during off-peak
  - single share location for source and target server
    - bypasses copy activity
  - correct permissions in shared folder
  - encrypt connection# Operationalize your Azure Data Factory or Azure Synapse Pipeline
[https://docs.microsoft.com/en-us/learn/modules/operationalize-azure-data-factory-pipelines/]

## Language support
- ADF available in SDKs
  - `azure-mgmt-datafactory` for python
  - .NET, REST, PowerShell, ARM templates, Data flow scripts

## Source Control
- git via Azure Repos or GitHub
  - when enabled, cannot do changes in UI
  - PowerShell or SDK changes are not reflected in git
- advantages
  - source control
  - partial saves
    - can save partial features that do not yet pass validation
  - collaboration
  - CI/CD
    - trigger pipeline on commits
  - performance
    - ~10x faster load
- publishing
  - can only publish from main
  - ARM templates from published factory are saved in `adf_publish` branch
    - can change this in `publish_config.json` in root of main
  - main MUST be published manually after merge
- permissions
  - all should have read
  - to publish, set Data Factory Contributor on Resource Group
- put secrets into Azure Key Vault

## CI/CD
### environments: dev/test/prod
- Automated deployment via Azure Pipelines
- manually upload ARM template via DF UX and Azure Resource Manager
### lifecycle
- create dev DF with git
- feature branch
- pr to main
- publish changes to dev DF
- deploy to test DF
  - Azure Pipelines and ARM template for config
- deploy to prod DF

only dev DF has git
  - test and prod updated via Azure DevOps Pipeline or ARM template
### automate via Azure DevOps Pipelines
- reqs. 
  - subscription linked to VS Team Foundation Server or Azure Repos with ARM endpoint
  - DF with Azure Repos git
  - Azure Key Vault with secrets for each environment
- secrets
  - param. file
  - key vault task
    - get and list permissions
- stop and restart active triggers
### linked templates
- necessary for large factories (max no. resources in ARM template)
- folder in `adf_publish` called `linkedTemplates`
  - point to `ArmTemplate_master.json`
### hotfixes
- create hotfix branch and fix bug
- export ARM template
- manually check in to publish
- release and deploy to test and prod
- commit fix to dev
### best practices
- only git in dev DF
- pre- and post-deployment scripts
  - e.g. stop and start triggers
- IR and sharing
  - ternary DF for shared IRs
- managed private endpoint deployment
- key vault
- resource naming
  - use '_' or '-' instead of spaces

## Monitor ADF pipelines
- can monitor directly in DF
  - saves logs for 45 days
- Azure Monitor
  - saves logs to storage account
  - stream to event hub
  - analyze with Log Analytics

## Rerun pipelines
- whole pipeline
- from activity
- from failed activity
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
- gold: report ready# Analyze data in a relational data warehouse
[https://docs.microsoft.com/en-us/learn/modules/design-multidimensional-schema-to-optimize-analytical-workloads/]

- BI-centered

## Design rel. DWH schema
- star schema
- dimensions
  - alternate/natural/business key: original id
  - surrogate key: unique to dwh
    - usually increasing int
    - makes sure sources can integrate
    - cheaper joins
    - handle slowly changing dimensions as type 2
  - denormalized for fewer joins
    - can normalize some fields to create hierarchies (snowflake schema)
- time dimension
  - e.g. dayOfWeek, DayOfMonth, Month, Quarter, etc.
  - enables easy time-based aggregation
  - *grain* = lowest granularity = finest resolution 
- facts
  - center of star schema
  - e.g. orders
  - references dimension tables

## DWH in Synapse
- dedicated SQL pool
  - collation: specify sort order and string comparison rules
- staging tables for ETL into fact/dimension
### SQL DB vs. Synapse
- Synapse does not support *foreign key* and *unique* constraints
  - must keep these constraints manually (no help from tables)
- indexes
  - default *clustered columnstore*: good for big data
  - supports usual clustered as well
- distribution
  - hash
  - round-robin: divides data evenly to nodes
  - replicated: replicates table on all nodes
  - best practices
    - dimension: replicated if small, else hash
    - fact: hash with clustered columnstore
    - staging: round-robin

## creating tables
- `IDENTITY` to create surrogate keys
- snowflake schema: include parent key in child table
- time dimension: 
  - surrogate key: numeric YYYYMMDD
  - alternate key: `DATE` or `DATETIME` datatype
- external tables: use files directly instead of loading into SQL pool

## Load tables
- source -> lake -> staging
- staging tables
  - `COPY INTO [staging table, columns] FROM [lake path] WITH [file type etc.]`
- dimension tables
  - create: `CREATE TABLE [dim table] WITH [distribution, index] AS SELECT ... FROM [staging table]`
    - need `ROW_NUMBER` instead of `IDENTITY` here
  - insert: `INSERT INTO [dim] SELECT ... FROM [staging]`
    - auto-generates row number
- time dimension
  - loop to get grain column
    - rest of table built from grain
  - alt.: create in external system (e.g. Excel), `COPY` into SQL pool
- slowly changing dimensions
  - type 0: don't allow changes
  - type 1: overwrite changes
    - `UPDATE`
  - type 2: row versioning
    - `INSERT` + `UPDATE`
    - alt.: `MERGE` (subject to constraints)
- fact tables
  - load after dimensions
  - usually has alternate keys, must be changed to surrogate
- optimize
  - `ALTER INDEX ALL ON [table] REBUILD`
  - stats table: `CREATE STATISTICS [stat table] ON [table] ([column])`

## Querying
- `JOIN` and `GROUP BY`
  - join hierarchical (normalized): join children in order to get to parent
- ranking
  - `ROW_NUMBER`
  - `RANK`
    - e.g. (5,1), (5,1), (3,3)
    - number of entities with higher rank
  - `DENSE_RANK`
    - on ties, only increment once
    - e.g. (5,1), (5,1), (3,2)
    - number of higher ranks
  - `NTILE`
    - percentile of row
    - e.g. `NTILE(4)` is quartiles
- approximation
  - `APPROX_COUNT_DISTINCT`
    - hyperloglog
    - max error 2% with 97% prob.
  - faster, good for data exploration# Use data loading best practices in Azure Synapse Analytics
[https://docs.microsoft.com/en-us/learn/modules/use-data-loading-best-practices-azure-synapse-analytics/]

## design goals
- balance load and query
### considerations
- source of data?
- new entities or updates?
- data velocity?
- data formats?
- are transformations needed?
- ETL or ELT?
- simplicity vs robustness
- load vs query

## loading methods
- directly from storage
  - T-SQL `COPY`
- Synapse pipeline/Data Flows
- PolyBase
  - external data source
- note: T-SQL `COPY` is the most flexible

## managing source files
- SQL pools have storage in 60 segmented parts
  - align number of data files with this

## singleton updates
- massively parallel system
  - don't do many small updates
  - do one big batch

## deicated load accounts
- don't use admin account for loads
  - only uses smallrc resource class (3-25%)
### creating loading user
```
CREATE LOGIN loader WITH PASSWORD = '...';
```
```
-- Connect to the SQL pool
CREATE USER loader FOR LOGIN loader;
GRANT ADMINISTER DATABASE BULK OPERATIONS TO loader;
GRANT INSERT ON <yourtablename> TO loader;
GRANT SELECT ON <yourtablename> TO loader;
GRANT CREATE TABLE TO loader;
GRANT ALTER ON SCHEMA::dbo TO loader;

CREATE WORKLOAD GROUP DataLoads
WITH ( 
    MIN_PERCENTAGE_RESOURCE = 100
    ,CAP_PERCENTAGE_RESOURCE = 100
    ,REQUEST_MIN_RESOURCE_GRANT_PERCENT = 100
    );

CREATE WORKLOAD CLASSIFIER [wgcELTLogin]
WITH (
        WORKLOAD_GROUP = 'DataLoads'
    ,MEMBERNAME = 'loader'
);
```

## workload management
- classification
  - load: insert, update, delete
  - query: select
- importance
  - high importance -> first in request queue
- isolation
  - reserve resources# Optimize data warehouse query performance in Azure Synapse Analytics
[https://docs.microsoft.com/en-us/learn/modules/optimize-data-warehouse-query-performance-azure-synapse-analytics/]

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

# Integrate SQL and Apache Spark pools in Azure Synapse Analytics
[https://docs.microsoft.com/en-us/learn/modules/integrate-sql-apache-spark-pools-azure-synapse-analytics/]

## connection methods
- dedicated pool only
- JavaDataBaseConnectivity (JDBC)
  - filters and projects
  - gives data to spark serially (bad)
- JDBC + PolyBase
  - JDBC sends filters and projections to PolyBase
  - Create External Tables As Select (CETAS)
  - parallel read for spark

## Authentication
- Token Service with Azure AD
### without Azure Adf
```
val df = spark.read.
option(Constants.SERVER, "samplews.database.windows.net").
option(Constants.USER, <SQLServer Login UserName>).
option(Constants.PASSWORD, <SQLServer Login Password>).
sqlanalytics("<DBName>.<Schema>.<TableName>")
```

## transfer data
- `spark.read.sqlanalytics("<DBName>.<Schema>.<TableName>")`
- `df.write.sqlanalytics("<DBName>.<Schema>.<TableName>", <TableType>)`
  - TableType is external or internal
  - if external, must specify data source and file format (created before in SQL)
- only with scala
  - connect to pyspark with temp table views # Understand data warehouse developer features of Azure Synapse Analytics
[https://docs.microsoft.com/en-us/learn/modules/understand-data-warehouse-developer-features-of-azure-synapse-analytics]

## Explore dev tools for Synapse
### Synapse Studio
- SQL scripts
- notebooks
- Synapse Pipelines
- Power BI reports
- Spark jobs
  - pyspark, scala, .NET
### Visual Studio (VS)
- VS 2019 SQL Server Data Tools (SSDT)
  - dedicated SQL pools
  - version control with Azure DevOps
  - CI/CD
  - View -> SQL Server Object Explorer -> Add SQL Server
### Azure Data Studio
- connect and query on-prem and cloud
  - serverless or dedicated
- Windows, macOS, Linux
### SQL Server Management Studio (SSMS)
- serverless or dedicated

## Transact-SQL (T-SQL)
- ANSI-compliant
- different features for dedicated or serverless
  - both: `SELECT`, transactions, data export (CETAS), built-in functions, aggregates, operators, control flow, DDL
  - dedicated only: `INSERT`, `UPDATE`, `DELETE`, labels, data load
  - serverless only: cross database queries
  - none: `MERGE`
- inspect execution plans (dedicated only)

## Windowing functions
- `OVER` to group
- aggregate (e.g. `COUNT`, `STDEV` etc.)
  - many-to-one rows
- analytical functions (e.g. `LAG`, `FIRST_VALUE` etc.)
  - many-to-many rows
- `ROWS` and `RANGE` to limit rows (e.g. `UNBOUNDED_PRECEDING` etc.)
- ranking (e.g. `RANK` etc.)

## Approximate execution
- for exploratory data analysis
- `APPROX_COUNT_DISTINCT`

## JSON in SQL pools
- dedicated pools
- stored as `NVARCHAR` columns
- good for JSON array -> table
- optimized with columnstore indices, mem. opt. tables
- insert
  - `INSERT`
- read
  - `ISJSON` to check validity
  - `JSON_VALUE` to get scalar value from JSON string
    - `JSON_VALUE(doc, '$.[field name]') AS [column name]`
  - `JSON_QUERY` to get JSON object or array from JSON string
- modify
  - `JSON_MODIFY` to modify a value in JSON string
  - `OPERJSON` to convert JSON collection to rows and columns
    - `cross apply openjson (doc) with ( [col name] [col type] ['$.[field name] (only if col name != field name)] )`
- query on serverless
  - `OPENROWSET`
 - either JSON array or line-delimited JSON files (e.g. jsonl)
### Load with `OPENROWSET`
- options
  - format = 'csv'
  - fieldterminator = '0x0b'
  - fieldquote = '0x0b'
  - rowterminator = '0x0b' (JSON array only)
- can use full path or create external data source
 
## Stored procedures
- `CREATE EXTERNAL TABLE AS SELECT` (CETAS)
- reduces network traffic
  - long procedures can be stored and only execution call is sent over network
- security boundary
  - can grant permission to use procedure without granting permissions for underlying db objects
- eases maintenance
- improved performance
  - compiled on first execution, then cached# Manage and monitor data warehouse activities in Azure Synapse Analytics
[https://docs.microsoft.com/en-us/learn/modules/manage-monitor-data-warehouse-activities-azure-synapse-analytics]

## Scale compute resources
- SQL pools
  - Portal, Synapse Studio, T-SQL, PowerShell
- Spark pools
  - always autoscales
  - set node type, min, and max no. nodes

## Pause compute resources
- pause SQL pools in Portal or Synapse Studio
- autopause available

## Manage workloads
- SQL pools have three concepts
  - workload classification
  - workload importance
  - workload isolation
### Workload classification
- e.g. load and query
- subclassifications
  - query: e.g. cube refresh, dashboard query, ad-hoc query
  - load: e.g. key sales, weather data, social media feeds
### Workload importance
- five levels: low, below_normal, normal, above_normal, high
- can set default on user basis (e.g. executives always have high to refresh their dashboards)
### Workload isolation
- reserve resources for a workload group

## Azure Advisor
- analyzes resource configs and usage
- recommends solutions for cost effectiveness, performance, reliability, and security
- Synapse
  - data skew + replicated table info
  - column stats
  - tempDB utilization
  - adaptive cache
  - checked every 24 hours

## Dynamic management views
- monitor SQL pools programmatically with T-SQL
- > 90 views available in following areas
  - connection info and activity
    - `sys.dm_pdw_exec_sessions`
  - SQL execution requests and queries
    - `sys.dm_pdw_exec_requests`
  - index and stats
  - resource blocking and locking
  - data movement service activity
    - `sys.dm_pdw_dms_workers`
  - errors
- 10k rows of data
  - if this is too little, use Query Store
- monitor Synapse SQL pools
  - waits
  - tempdb
  - memory
  - transaction log
  - PolyBase
# Analyze and optimize data warehouse storage in Azure Synapse Analytics
[https://docs.microsoft.com/en-us/learn/modules/analyze-optimize-data-warehouse-storage-azure-synapse-analytics]

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
- CTAS + `RENAME` to select the kept rows# Secure a data warehouse in Azure Synapse Analytics
[https://docs.microsoft.com/en-us/learn/modules/secure-data-warehouse-azure-synapse-analytics]

## Network security options for Synapse
### firewall rules
- apply to all public endpoints
  - includes SQL pools (dedicated and serverless) and dev endpoint
  - Synapse studio uses TCP ports 80, 443, and 1443, UDP port 53
### virtual networks
- can create managed VNet when creating Synapse workspace
  - includes all resources except SQL pools
  - can have user-level isolation for Spark activities (Spark clusters have their own subnets)
  - SQL pools are multi-tenant, but have auto-created private links to managed VNet
### private endpoints
- only with managed VNet
- used to connect to other Azure services
- traffic never leaves Microsoft network

## Conditional access
- Conditional Access policies use signals, e.g.
  - user or group name
  - IP address
  - device platform or type
  - application access requests
  - real-time and calculated risk detection
  - Microsoft Cloud App Security (MCAS)
- If signal is detected:
  - block access completely
  - perform MFA
  - require specific device
- Available on dedicated SQL pools
  - requires Azure AD and compatible MFA

## Configure authentication
### Azure Active Directory
- centrally managed objects (users, services etc.)
- single sign-on
  - AD manages access to other resources
  - e.g. user and Synapse in same AD -> user can use Synapse
### Managed identities
- part of Azure AD
- gives service identity in AD
### SQL auth
- for accessing dedicated SQL pool
- for users outside Azure AD
- useful for external users or 3rd-party apps
### Keys
- e.g. access Azure Data Lake without AD
- storage account keys
  - full access to everything
  - use Azure Key Vault to manage keys
- shared access signatures
  - for external 3rd-party apps or untrusted clients
  - can be attached to URL
  - can give temporary access by setting timeout
  - service level 
    - specific resources in storage account
    - e.g. list files or read access
  - account level
    - everything at service level + more
    - e.g. create file systems

## Column and row level security
### Column level security
- access only certain columns in DB
  - e.g. only doctors and nurses can see medical records, not billing department
- `GRANT` T-SQL statement
### Row level security
- access only to specific rows
  - e.g. only access to customers in specific region
  -  only filter predicates can be used
- `CREATE SECURITY POLICY[!INCLUDEtsql]` statement
### Permissions
- to manage security policies, you need `ALTER ANY SECURITY POLICY` permission
- [some other permissions](https://docs.microsoft.com/en-us/learn/modules/secure-data-warehouse-azure-synapse-analytics/5-manage-authorization-through-column-row-level-security)
### Best practices
- create RLS objects (predicate functions, sec. policies)
  - separate permissions for for table and RLS objects
- `ALTER ANY SECURITY POLICY` only for highly privileged users
  - this user should not need `SELECT` on protected tables

## Sensitive data and Dynamic Data Masking
- limited data exposure to non-privved users
- policy-based
- e.g. mask all but last four digits of credit card number
- admins are never subjected to masks

## Encryption
### Transparent Data Encryption (TDE)
- encrypts data at rest
- real-time enc. and dec. of DB, backups, trans. logs
  - at page level
- manually enabled
- symmetric key, Database Encryption Key (DEK)
  - protected by Transparent Data Encryption Protector (TDEP)
    - set on server level
    - service-managed certificate or asymmetric key in Azure Key Vault
#### Service-managed TDE
- built-in certificate
- AES-256
- rotated automatically
- root key in Microsoft internal secret store
#### TDE with bring-your-own-key
- asymmetric key in Azure Key Vault
- full control over key management
#### Moving TDE protected DB
- within Azure
  - no decryption
  - settings inherited
- outside Azure (export)
  - delivered in unencrypted BACPAC file
### TokenLibrary for Spark
- for external data access (linked services)
- not needed for Data Lake Gen2
- `val connectionString = com.microsoft.azure.synapse.tokenlibrary.TokenLibrary.getConnectionString("<Linked service name>")`
  - or `.getConnectionStringAsMap(...)` to get e.g. account key# Analyze data with Apache Spark in Azure Synapse Analytics
[https://docs.microsoft.com/en-us/learn/modules/understand-big-data-engineering-with-apache-spark-azure-synapse-analytics]

## Spark
- cluster manager allocates resource on Hadoop YARN cluster

## Spark in Synapse
- pyspark, scala spark, JARs
- data access
  - data lake on primary storage account
  - data lake on linked service storage account
  - SQL pool in workspace
  - Azure SQL or SQL Server DB (Spark connector for SQL Server)
  - Cosmos DB linked service with Azure Synapse Link for Cosmos DB
  - Azure Data Explorer Kusto linked service
  - external Hive metastore linked service# Use Delta Lake in Azure Synapse Analytics
[https://docs.microsoft.com/en-us/learn/modules/understand-big-data-engineering-with-apache-spark-azure-synapse-analytics]

## Catalog tables
- managed table
  - no specified location
    - full table in metastore
  - dropping deletes data
- external
  - custom file location (e.g. Data Lake Gen2)
    - only metadata in metastore
  - dropping does not delete data 

## Delta Lake in SQL pool
- `OPENROWSET` with `FORMAT = 'DELTA'`
- shared access to databases in Spark metastore# Monitor and manage data engineering workloads with Apache Spark in Azure Synapse Analytics
[https://docs.microsoft.com/en-us/learn/modules/understand-big-data-engineering-with-apache-spark-azure-synapse-analytics]

## Monitor Spark pools in Synapse
- Monitor tab in Synapse Studio
  - Activities -> Apache Spark Applications

## Optmize Spark jobs
- Kryo data serialization
- bucketing
  - like partitioning, but each bucket holds several values
# Work with Hybrid Transactional and Analytical Processing Solutions using Azure Synapse Analytics
[https://docs.microsoft.com/en-us/learn/modules/design-hybrid-transactional-analytical-processing-using-azure-synapse-analytics]

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
    - accessed through SQL or Spark pool# Implement Azure Synapse Link with Azure Cosmos DB
[https://docs.microsoft.com/en-us/learn/modules/configure-azure-synapse-link-with-azure-cosmos-db/]

## Enabling Synapse Link
- supported for Core (SQL) and MongoDB APIs
- enable in Cosmos DB -> Features
- considerations
  - cannot disable once enabled
  - must create analytical store enabled container in CDB
  - when enabling through Azure CLI or PowerShell, can specify WellDefined (default) or FullFidelity schema for SQL API
    - for MongoDB, only FullFidelity
  - schema type cannot be changed later

## Create analytical store enabled container
- container with column-based and row-based stores within the same container
  - auto-sync pulls changes to row-based into col-based
### Schema type
- well-defined
  - first non-null occurrence of field determines column data type
    - non-matching subsequent occurrences are ignored and not ingested
- full fidelity
  - data type is appended to column name
  - same column name can have different data types (e.g. `productID.int32` and `productID.string`)
### Enabling analytical store
- Portal
  - turn on when creating container
  - for existing containers: Cosmos DB -> Integration -> Azure Synapse Link 
- Azure CLI
- Azure PowerShell
### Considerations
- cannot disable analytical store support without deleting container
- can set analytical store TTL value to 0 or `null`, disabling sync
  - cannot re-enable afterwards

## Cosmos DB linked service
- linked CDB and containers in Data page in Synapse Studio
- different icon for analytical store enabled

## Query CDB with Spark
- read: `spark.read.format("cosmos.olap").option("spark.synapse.linkedService", "<service name>").option("spark.cosmos.container", "<container name>").load()`
- write syntax similar to read
  - updates operational (row-based) store, changes are synced to analytical store
- data loaded from analytical store

## Query CDB with Synapse SQL
- `OPENROWSET('CosmosDB', 'Account=<acc name>;Database=<db name>;Key=...==', [container name])`
  - key in Cosmos DB -> Keys
  - can also use credential (SAS)
- can specify schema as `OPENROWSET(...) WITH ([col1] [type1], [col2] [type2], ...)`
  - can be used to extract nested JSON fields
- for views, create a new database
  - used-def. views not supported in master db
  - database should use UTF-8 based collation
- considerations for serverless SQL pools
  - use same region for pool and CDB (CDB can be geo-replicated)
  - when using string cols, use explicit `WITH` clause with appropriate data length for strings# Implement Azure Synapse Link for SQL
[https://docs.microsoft.com/en-us/learn/modules/implement-synapse-link-for-sql]

## Synapse Link for SQL
- Azure SQL DB or SQL Server 2022 with trans. rel. db
  - !NOT! SQL Managed Instance
- Synapse Link replicates table data to dedicated SQL pool
  - query without affecting trans. db
- uses *change feed* in SQL DB/Server
  - monitors trans. log
  - SQL DB: changes applied directly to SQL pool
  - SQL Server: changes staged in Data Lake Gen2 before applied to SQL pool

## Config SQL DB
- *link connection* maps tables in DB to pool
  - copies snapshot, applies subsequent changes directly
- config in SQL DB
  - managed identity on SQL DB
    - workspace identity must have db_owner role
  - firewall rules so Azure services can access SQL DB
- config in Synapse
  - dedicated SQL pool
    - needs same schema name (e.g. dbo)
- create link
  - Synapse Studio -> Integrate -> linked connection
  - linked service for SQL DB
  - specify tables
  - specify resources for sync
    - 4 extra driver cores are added
- configure index and distribution

## Config SQL Server 2022
- *link connection* maps tables in Server to pool
  - copies parquet for tables to DL G2, then imports to pool
  - changes copied as csv to DL G2 and applied to pool
- sync. by self-hosted IR installed on Windows computer with direct access to SQL Server
- create landing zone
  - can't use default storage account in Synapse
- need master key in SQL Server and SQL pool
- linked service for SQL Server
  - specify self-hosted IR
- linked service for DL G2
  - Synapse workspace must have Storage Blob Data Contributor on storage account# Databricks Architecture

## Cluster architecture
- workers have slots they can fill with tasks
  - slots are determined by number of cores
- managed resource group
- Azure Kubernetes Services (AKS) runs dbx control (e.g. cluster creation)
# Azure Databricks performance features
[https://docs.microsoft.com/en-us/learn/modules/describe-lazy-evaluation-performance-features-azure-databricks]

## Shuffles and Tungsten
- UnsafeRow = Tungsten Binary Format (TBF)
  - in-memory format for Spark SQL, DataFrames & Datasets
  - compact
  - Spark operates directly on TBF
- data is converted to TBF, written to disk, then shuffled
  - prevents serde
### Stages
- shuffling creates stage boundaries (sync points)
- shuffle files are temporarily cached on executors
  - allows stage skipping
  - manually caching makes sure files are persisted# Security in Azure Databricks
[https://docs.microsoft.com/en-us/learn/modules/describe-platform-architecture-security-data-protection-azure-databricks]

## Control and Data planes
- Azure manages dbx file system
  - customers can r/w, but cannot change settings etc.

## Data protection
- encryption at rest
  - managed keys
  - file/folder lvl ACL
- encryption in transit
  - all traffic encrypted with TLS
- access control
  - Azure AD
  - can limit who can use specific clusters
  - table permissions
- secrets
  - dbx backend or Azure Key Vault

## Security
### Network
- VNet peering
  - dbx VNet can peer with other Azure VNets
  - all traffic is through private IPs in Microsoft
- VNet injection
  - deploy data plane in custom VNet
  - on-prem data access
  - firewall-based filtering via custom routing
  - service endpoints
    - confine critical Azure resources to custom VNet only
  - customer-managed Network Security Groups (NSGs)
  - Azure Private Link
    - even more custom management
### Compliance
- Azure has compliance certifications:
  - HITRUST, AICPA, PCI DSS, ISO 27001, ISO 27018, HIPAA, SOC2 (Type 2)

## Key Vault secrets
- use Key Vault to register secrets in dbx
- `dbutils.secrets ...`# CI/CD in Databricks with Azure DevOps
[https://docs.microsoft.com/en-us/learn/modules/implement-ci-cd-azure-devops]

- use pipelines in Azure DevOps for CI/CD
  - build pipeline for CI
  - release pipeline for CD
- automates copying notebooks from dev to prod# Databricks/Synapse integration
[https://docs.microsoft.com/en-us/learn/modules/integrate-azure-databricks-other-azure-services]

## Synapse connector
- Azure blob storage as intermediary
- PolyBase
- most suited for ETL/ELT

## SQL DW connection
- spark driver connects to Synapse with JDBC
- spark driver and execs connect to Blob Storage
  - stores bulk data
  - `wasbs` URI scheme
  - must use storage account access key
- Synapse connects to Blob Storage
  - loading and unloading of temp data
  - set `forwardSparkAzureStorageCredentials` to `true`

## Best practices
- write changes to staging table, then update real tables# Best practices for Azure Databricks
[https://docs.microsoft.com/en-us/learn/modules/describe-azure-databricks-best-practices]

## Admin
- when managing many workspaces, use ARM templates
- DBX limits
  - 1000 jobs/workspace / hour
  - 150 running jobs / workspace
  - 150 notebooks or execution contexts / cluster
  - 1500 DBX API calls / hour
- Azure subscription limits
  - 250 storage accs / region / subscription
  - 50 Gbps total egress for storage account
  - 25 000 VMs / region / subscription
  - 980 rgs / subscription
- High Availability / Disaster Recovery (HA/DR)
  - DBX in two paired Azure regions with different control planes
    - Azure Traffic Manager for load balance and API request distribution
- one workspace / environment / data tier / business team / department
- workspace level tags

## Security
- isolate workspace VNets
- no prod data in DBFS
- secrets in key vault
  - DBX or Azure Key Vault
- ADLS passthrough
  - requires premium dbx

## Usage
- audit logs and utilization metrics
  - stream VM metrics to Azure Log Analytics Workspace
    - needs Log Analytics Agent on each cluster node

## Tools and integration
- don't use init scripts unless necessary
  - if you do, use cluster scoped scripts (not global)
- logs to blob storage via Cluster Log Delivery
  - DBFS logs are purged every 30 days
  - cannot read DBFS from outside dbx workspace

## Databricks runtime
- tune shuffle
  - `spark.sql.shuffle.partitions` set so partitions are MB - 1 GB
- evenly distribute data in partitions
  - 10 - 50 GB / partition
  - don't partition small datasets
- Delta Lake

## Cluster
- node number and type depends on job type
  - Memory optimized for ML
  - Compute optimized for Streaming
  - General Purpose for ETL/ELT (depends)
  - autoscaling for interactive
- interactive / jobs clusters
- standard / high concurrency mode#
### cluster size
- dev on medium-sized (2-8 nodes)
- end-to-end test on large representative data, monitoring utilization
- optimize for bottlenecks
  - cpu bound: more nodes/cores
  - network bound: fewer, bigger SSD backed nodes
  - disk I/O bound: higher memory nodes
    - avoid spilling to disk
- make sure that workloads scale linearly when scaling up
- few big nodes > many small nodes
- caching workloads (e.g. ML)
  - fully cached with extra room: fewer instances
  - partially cached
    - almost cached: more instances
    - not close: L or DSv2 mem-opt. nodes
  - check if caching is `MEMORY_ONLY` or `MEMORY_AND_DISK`
  - spill to disk is okay with SSDs
- ETL, analytic workloads
  - compute bound
    - check CPU usage first
    - more cores
  - network bound
    - high spikes before compute?
    - fewer big machines or SSDs for faster remote reads
  - spilling a lot
    - Spark SQL tab for spill
    - L-series or more memory
# Introduction to Azure Data Lake storage
[https://docs.microsoft.com/en-us/learn/modules/introduction-to-azure-data-lake-storage]

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
- model and serve# Work with data stream by using Azure Stream Analytics
[https://docs.microsoft.com/en-us/learn/modules/introduction-to-data-streaming]

## Stream processing approaches
- live 
  - more processing power
  - near-real-time insights
  - Event Hubs -> Azure Stream Analytics -> Power BI
- on-demand
  - data stored before processed
  - static batch processing
  - IoT/Event Hub -> ADLS G2 -> Stream Analytics -> Power BI

## Event processing
- event producer
  - Event Hubs, IoT Hub
- event processor
  - computes aggregations
  - Azure Stream Analytics
- event consumer
  - visualize or take action
  - Power BI

## Azure Stream Analytics
- PaaS
- producers
  - sensors, systems, applications
- ingestion
  - Event Hubs, IoT Hub, Blob storage
- Stream analytics engine
  - process, aggregate, transform
  - Stream Analytics Query Language (SAQL)
    - subset of T-SQL
- consumer
  - ADLS G2, Cosmos DB, SQL DB
  - Power BI
- *exactly once* event processing
- *at-least-once* event delivery# Enable reliable messaging for Big Data application using Azure Event Hubs
[https://docs.microsoft.com/en-us/learn/modules/enable-reliable-messaging-for-big-data-apps-using-event-hubs]

## Azure Event Hubs
- pub-sub model
- event is a packet of info (datagram) with notification
  - published individually or in batches
    - publication must be < 1 MB
- publishers
  - Advanced Message Queuing Protocol (AMQP) 1.0
    - for frequent data
    - high init overhead
  - HTTPS
    - more overhead per request
    - no init overhead
  - Kafka
- subscribers
  - EventHubReceiver
    - simple
    - limited management
  - EventProcessorHost
    - efficient
- consumer groups process stream independently from each other
- default 4 partitions

## Configuring applications to send and receive through Event Hubs
- sending
  - Event hub namespace name
  - Event hub name
  - Shared access policy name
  - Primary shared access key
- receiving
  - Event hub namespace name
  - Event hub name
  - Shared access policy name
  - Primary shared access key
  - If using Blob Storage for message storing
    - Storage acc. name, conn. string, container name

## Event Hub performance
- test resilience
  - received messages are transmitted and processed even if received during downtime
    - downtime due to backend service maintenance
  - client SDKs have built-in resilience
  - useful metrics
    - throttled requests: exceeded throughput limit
    - active connections
    - incoming/outgoing bytes# Ingest data streams with Azure Stream Analytics
[https://docs.microsoft.com/en-us/learn/modules/ingest-data-streams-with-azure-stream-analytics]

## Windowing
- tumbling (just standard windows)
  - contiguous series
  - fixed-size, non-overlapping
  - event belongs to exactly one window
  - `GROUP BY TumblingWindow(minute, 10)`
    - exclusive beginning, inclusive end
  - output at end of windows
- hopping
  - fixed-size, overlapping
  - basically overlapping tumbling
  - event belongs to at least one window
  - `GROUP BY HoppingWindow(minute, 10, 5)`
    - hops every 5 minutes
- sliding
  - fixed-size
  - new window every time event is created
    - window contains all points received less than <size> time ago
  - event belongs to at least one window
  - `GROUP BY SlidingWindow(minute, 10) HAVING COUNT(*) > 3`
    - windows are 10 min long, only windows with 4 or more events are considered
- session
  - variable-size, non-overlapping
  - clusters events received at similar times
  - timeout is max distance between neighboring events in window
  - maximum duration
  - can specify partitioning key
  - `GROUP BY Username, SessionWindow(minute, 2, 10) OVER (PARTITION BY Username)`
    - 2 min timeout, 10 min max duration
    - partitioned by Username
- snapshot
  - group by identical timestamp values
  - `GROUP BY System.Timestamp()`\n
