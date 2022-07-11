# Operationalize your Azure Data Factory or Azure Synapse Pipeline
[https://docs.microsoft.com/en-us/learn/modules/operationalize-azure-data-factory-pipelines/]

## Language support
- ADF available in SDKs
  - `azure-mgmt-datafactory` for python
  - .NET, REST, PowerShell, ARM templates, Data flow scripts

## Source Control
- git via Azure Repos or GitHub
  - when enabled, cannot do changes in UI
  - PowerShell or SDK changes are not reflected in git
- advantages
  - source control
  - partial saves
    - can save partial features that do not yet pass validation
  - collaboration
  - CI/CD
    - trigger pipeline on commits
  - performance
    - ~10x faster load
- publishing
  - can only publish from main
  - ARM templates from published factory are saved in `adf_publish` branch
    - can change this in `publish_config.json` in root of main
  - main MUST be published manually after merge
- permissions
  - all should have read
  - to publish, set Data Factory Contributor on Resource Group
- put secrets into Azure Key Vault

## CI/CD
### environments: dev/test/prod
- Automated deployment via Azure Pipelines
- manually upload ARM template via DF UX and Azure Resource Manager
### lifecycle
- create dev DF with git
- feature branch
- pr to main
- publish changes to dev DF
- deploy to test DF
  - Azure Pipelines and ARM template for config
- deploy to prod DF

only dev DF has git
  - test and prod updated via Azure DevOps Pipeline or ARM template
### automate via Azure DevOps Pipelines
- reqs. 
  - subscription linked to VS Team Foundation Server or Azure Repos with ARM endpoint
  - DF with Azure Repos git
  - Azure Key Vault with secrets for each environment
- secrets
  - param. file
  - key vault task
    - get and list permissions
- stop and restart active triggers
### linked templates
- necessary for large factories (max no. resources in ARM template)
- folder in `adf_publish` called `linkedTemplates`
  - point to `ArmTemplate_master.json`
### hotfixes
- create hotfix branch and fix bug
- export ARM template
- manually check in to publish
- release and deploy to test and prod
- commit fix to dev
### best practices
- only git in dev DF
- pre- and post-deployment scripts
  - e.g. stop and start triggers
- IR and sharing
  - ternary DF for shared IRs
- managed private endpoint deployment
- key vault
- resource naming
  - use '_' or '-' instead of spaces

## Monitor ADF pipelines
- can monitor directly in DF
  - saves logs for 45 days
- Azure Monitor
  - saves logs to storage account
  - stream to event hub
  - analyze with Log Analytics

## Rerun pipelines
- whole pipeline
- from activity
- from failed activity
