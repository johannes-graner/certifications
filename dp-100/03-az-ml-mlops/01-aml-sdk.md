# Introduction to the Azure Machine Learning SDK
<https://docs.microsoft.com/en-us/learn/modules/intro-to-azure-machine-learning-service/1-introduction>

## Azure Machine Learning (AML) workspaces
### In workspace
- compute
  - dev, train, deploy
- data
- notebooks
- experiments
  - run history
    - logged metrics
    - outputs
- pipelines
- models
### Outside workspace
- storage account
  - workspace files
  - data
- Application Insights
  - monitor predictive services
- Azure Key Vault
  - auth keys, credentials
- container registry
  - manage containers for deployed models
### RBAC
- different permissions for IT Ops and DSs

## AML SDK
- run ml-ops
- automate asset creation and config
- consistency for multiple environments
  - dev, test, prod
- ML asset config in DevOps
  - CI/CD for ML
- SDKs available for Python and R
  - Python SDK is more mature
### Best practices
- connection details in config file
  - load config by `azureml.core.Workspace.from_config(file)`
    - default arg is `config.json` in same folder
### CLI extension
- there is an AML extension for Azure CLI
### VS Code
- Microsoft Python extension
- Azure Machine Learning Extension
  - work with AML workspace assets

## AML experiments
- named process, e.g. script or pipeline
### Running
- `run = azureml.core.Experiment(workspace = ..., name = ...).start_logging()` to run experiment stored in AML 
- `run.complete()` to end experiment
### Logging
- `run.log('no_obs', row_count)`
- different log types:
  - `log`: single named value
  - `log_list`: named list of values
  - `log_row`: row w/ multiple cols
  - `log_table`: dict as table
  - `log_image`: image or plot
- retrieve logs by `azureml.widgets.RunDetails(run).show()`
  - `run.get_metrics()`
### Output files
- trained models
- `run.upload_file(name=..., path_or_stream=...)`
- `run.get_file_names()` to get output files
### Scripts
- use `azureml.core.Run.get_context()` in script
- script config: `azureml.core.ScriptRunConfig(source_directory=..., script=...)`
- submit script: `experiment.submit(config=...).wait_for_completion(show_output=[T|F])`
- can also use MLFlow