# Databricks Architecture

## Cluster architecture
- workers have slots they can fill with tasks
  - slots are determined by number of cores
- managed resource group
- Azure Kubernetes Services (AKS) runs Databricks control (e.g. cluster creation)
