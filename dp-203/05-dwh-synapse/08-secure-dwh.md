# Secure a data warehouse in Azure Synapse Analytics
<https://docs.microsoft.com/en-us/learn/modules/secure-data-warehouse-azure-synapse-analytics>

## Network security options for Synapse
### firewall rules
- apply to all public endpoints
  - includes SQL pools (dedicated and serverless) and dev endpoint
  - Synapse studio uses TCP ports 80, 443, and 1443, UDP port 53
### virtual networks
- can create managed VNet when creating Synapse workspace
  - includes all resources except SQL pools
  - can have user-level isolation for Spark activities (Spark clusters have their own subnets)
  - SQL pools are multi-tenant, but have auto-created private links to managed VNet
### private endpoints
- only with managed VNet
- used to connect to other Azure services
- traffic never leaves Microsoft network

## Conditional access
- Conditional Access policies use signals, e.g.
  - user or group name
  - IP address
  - device platform or type
  - application access requests
  - real-time and calculated risk detection
  - Microsoft Cloud App Security (MCAS)
- If signal is detected:
  - block access completely
  - perform MFA
  - require specific device
- Available on dedicated SQL pools
  - requires Azure AD and compatible MFA

## Configure authentication
### Azure Active Directory
- centrally managed objects (users, services etc.)
- single sign-on
  - AD manages access to other resources
  - e.g. user and Synapse in same AD -> user can use Synapse
### Managed identities
- part of Azure AD
- gives service identity in AD
### SQL auth
- for accessing dedicated SQL pool
- for users outside Azure AD
- useful for external users or 3rd-party apps
### Keys
- e.g. access Azure Data Lake without AD
- storage account keys
  - full access to everything
  - use Azure Key Vault to manage keys
- shared access signatures
  - for external 3rd-party apps or untrusted clients
  - can be attached to URL
  - can give temporary access by setting timeout
  - service level 
    - specific resources in storage account
    - e.g. list files or read access
  - account level
    - everything at service level + more
    - e.g. create file systems

## Column and row level security
### Column level security
- access only certain columns in DB
  - e.g. only doctors and nurses can see medical records, not billing department
- `GRANT` T-SQL statement
### Row level security
- access only to specific rows
  - e.g. only access to customers in specific region
  -  only filter predicates can be used
- `CREATE SECURITY POLICY[!INCLUDEtsql]` statement
### Permissions
- to manage security policies, you need `ALTER ANY SECURITY POLICY` permission
- [some other permissions](https://docs.microsoft.com/en-us/learn/modules/secure-data-warehouse-azure-synapse-analytics/5-manage-authorization-through-column-row-level-security)
### Best practices
- create RLS objects (predicate functions, sec. policies)
  - separate permissions for for table and RLS objects
- `ALTER ANY SECURITY POLICY` only for highly privileged users
  - this user should not need `SELECT` on protected tables

## Sensitive data and Dynamic Data Masking
- limited data exposure to non-privved users
- policy-based
- e.g. mask all but last four digits of credit card number
- admins are never subjected to masks

## Encryption
### Transparent Data Encryption (TDE)
- encrypts data at rest
- real-time enc. and dec. of DB, backups, trans. logs
  - at page level
- manually enabled
- symmetric key, Database Encryption Key (DEK)
  - protected by Transparent Data Encryption Protector (TDEP)
    - set on server level
    - service-managed certificate or asymmetric key in Azure Key Vault
#### Service-managed TDE
- built-in certificate
- AES-256
- rotated automatically
- root key in Microsoft internal secret store
#### TDE with bring-your-own-key
- asymmetric key in Azure Key Vault
- full control over key management
#### Moving TDE protected DB
- within Azure
  - no decryption
  - settings inherited
- outside Azure (export)
  - delivered in unencrypted BACPAC file
### TokenLibrary for Spark
- for external data access (linked services)
- not needed for Data Lake Gen2
- `val connectionString = com.microsoft.azure.synapse.tokenlibrary.TokenLibrary.getConnectionString("<Linked service name>")`
  - or `.getConnectionStringAsMap(...)` to get e.g. account key