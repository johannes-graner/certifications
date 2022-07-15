# Best practices for Azure Databricks
<https://docs.microsoft.com/en-us/learn/modules/describe-azure-databricks-best-practices>

## Admin
- when managing many workspaces, use ARM templates
- Databricks limits
  - 1000 jobs / workspace / hour
  - 150 running jobs / workspace
  - 150 notebooks or execution contexts / cluster
  - 1500 Databricks API calls / hour
- Azure subscription limits
  - 250 storage accs / region / subscription
  - 50 Gbps total egress for storage account
  - 25 000 VMs / region / subscription
  - 980 rgs / subscription
- High Availability / Disaster Recovery (HA/DR)
  - Databricks in two paired Azure regions with different control planes
    - Azure Traffic Manager for load balance and API request distribution
- one workspace / environment / data tier / business team / department
- workspace level tags

## Security
- isolate workspace VNets
- no prod data in DBFS
- secrets in key vault
  - Databricks or Azure Key Vault
- ADLS passthrough
  - requires premium Databricks

## Usage
- audit logs and utilization metrics
  - stream VM metrics to Azure Log Analytics Workspace
    - needs Log Analytics Agent on each cluster node

## Tools and integration
- don't use init scripts unless necessary
  - if you do, use cluster scoped scripts (not global)
- logs to blob storage via Cluster Log Delivery
  - DBFS logs are purged every 30 days
  - cannot read DBFS from outside Databricks workspace

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
