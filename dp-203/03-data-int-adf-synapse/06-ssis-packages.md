# Execute existing SSIS packages in Azure Data Factory or Azure Synapse Pipeline
<https://docs.microsoft.com/en-us/learn/modules/execute-existing-ssis-packages-azure-data-factory/>

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