# Security in Azure Databricks
<https://docs.microsoft.com/en-us/learn/modules/describe-platform-architecture-security-data-protection-azure-databricks>

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