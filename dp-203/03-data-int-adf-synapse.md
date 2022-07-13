# Integrate data with Azure Data Factory or Azure Synapse Pipeline
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
- Data Flow: associated IR
# Petabyte-scale ingestion with Azure Data Factory or Azure Synapse Pipeline
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
  - default 45 days
# Perform code-free transformation at scaline with Azure Data Factory or Azure Synapse Pipeline
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
  - 
# Orchestrate data movement and transformation in Azure Data Factory or Azure Synapse Pipeline
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
  - cli
# Execute existing SSIS packages in Azure Data Factory or Azure Synapse Pipeline
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
  - encrypt connection
# Operationalize your Azure Data Factory or Azure Synapse Pipeline
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

