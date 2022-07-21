# Manage machine learning models in Azure Databricks
<https://docs.microsoft.com/en-us/learn/modules/manage-machine-learning-models-azure-databricks/>

## Model registration
- model can be registered in UI or programmatically
- Databricks UI
  - run details -> select model folder -> Register Model
- through code
  - directly from experiment
    - `mlflow.register_model(model_uri, name)`
  - during a run
    - `mlflow.sklearn.log_model(sk_model, artifact_path, registered_model_name)`
      - load by `mlflow.sklearn.load_model(model_uri)`

## Model versioning
- in UI: same as registering
### Staging
- models start without a stage
  - can move to Staging, Production, Archived
    - all model versions must be archived before deleting model
  - users with Read permission can request stage transition, Write permission to actually transition
- in UI: select model version -> Stage
- through code:
  - `client.transition_model_version_stage(name, version, stage)`
    - load by `mlflow.pyfunc.load_model("models:/[model_name]/[model_stage]")`