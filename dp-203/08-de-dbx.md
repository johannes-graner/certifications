# Databricks Architecture

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
  - manually caching makes sure files are persisted
# Security in Azure Databricks
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
- `dbutils.secrets ...`
# CI/CD in Databricks with Azure DevOps
[https://docs.microsoft.com/en-us/learn/modules/implement-ci-cd-azure-devops]

- use pipelines in Azure DevOps for CI/CD
  - build pipeline for CI
  - release pipeline for CD
- automates copying notebooks from dev to prod
# Databricks/Synapse integration
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
- write changes to staging table, then update real tables
# Best practices for Azure Databricks
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

