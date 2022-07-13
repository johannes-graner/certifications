# Orchestrate data movement and transformation in Azure Data Factory or Azure Synapse Pipeline
<https://docs.microsoft.com/en-us/learn/modules/orchestrate-data-movement-transformation-azure-data-factory>

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