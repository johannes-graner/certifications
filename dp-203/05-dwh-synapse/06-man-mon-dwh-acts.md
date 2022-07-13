# Manage and monitor data warehouse activities in Azure Synapse Analytics
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
