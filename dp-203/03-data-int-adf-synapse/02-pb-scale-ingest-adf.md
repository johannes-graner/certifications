# Petabyte-scale ingestion with Azure Data Factory or Azure Synapse Pipeline
<https://docs.microsoft.com/en-us/learn/modules/petabyte-scale-ingestion-azure-data-factory/>

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