# Explore security concepts in Azure Machine Learning
<https://docs.microsoft.com/en-us/learn/modules/azure-machine-learning-security/>

## RBAC
- custom roles can be defined in JSON
  - workspace, resource group, or subscription level
  - Actions: allowed
  - NotActions: not allowed
    - precedence over Actions
- Azure AD
  - interactive
  - service principal
    - for automated processes
  - Azure CLI session
  - managed identity
    - for e.g. AML SDK on Azure VM
    - system-assigned: tied to resource lifecycle
    - user-assigned: persisted on resource delete, not recommended

## Azure Key Vault
- max 25 kB per key
- AKV associated with workspace: `os.environ["KEY_VAULT_NAME"]`
- retrieve key: `azure.keyvault.secrets.SecretClient(vault_url, credential)`
  - `credential` can be `azure.identity.DefaultAzureCredential()`
- access from run: `run.get_secret(name)`

## AML network security
- VNet
  - use service and private endpoints to reach VNet
  - connect to on-prem through VPN
- VPN
  - Azure VPN gateway
    - private connection over public internet
    - point-to-site
      - each client has VPN client
    - site-to-site
      - VPN device connects entire network
  - ExpressRoute
    - private connection using connectivity provider
  - Azure Bastion
    - Azure VM (jump box) inside VNet
    - connect to VM using Bastion through RDP or SSH
- Network Security Groups (NSGs)
  - security rule to allow or deny traffic
  - control traffic flow between VM subnets or limit traffic out to public internet
  