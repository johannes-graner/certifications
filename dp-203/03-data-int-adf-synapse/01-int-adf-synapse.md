# Integrate data with Azure Data Factory or Azure Synapse Pipeline
<https://docs.microsoft.com/en-us/learn/modules/data-integration-azure-data-factory/>

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
  - public: Data Flow, Data movement, Activity dispatch
  - private: N/A
- Self-hosted
  - pub/priv: Data movement, Activity dispatch
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