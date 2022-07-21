# Track Azure Databricks experiments in Azure Machine Learning
<https://docs.microsoft.com/en-us/learn/modules/track-azure-databricks-experiments-azure-machine-learning/>

## Log Databricks experiments in AML
- AML as backend for MLflow Tracking
- MLflow Tracking URI for AML
  - `mlflow.set_tracking_uri(ws.get_mlflow_tracking_uri())`
- MLflow experiment
  - `mlflow.set_experiment(experiment_name)`
- run using `with mlflow.start_run(): ...`
- log metrics by `mlflow.log_metric(key, value)`
- log artifacts by `mlflow.log_artifact([local path to artifact])`

## AML pipelines on Databricks compute
- attach Databricks Compute
  - get access token from Databricks
  - `db_config = azureml.core.compute.DatabricksCompute.attach_configuration(resource_group, workspace_name, access_token)`
  - `ComputeTarget.attach(ws, compute_name, db_config)`
    - `compute_name` is cluster name
- `DatabricksStep` in pipeline
  - `name`
  - `run_name`
  - `python_script_params`
  - `spark_version`
  - `node_type`
  - `spark_conf`
    - `{"spark.databricks.delta.preview.enabled": "true"}`
  - `num_workers`
  - `pypi_libraries`
  - `compute_target`
  - `allow_reuse = False`
  - cluster is created on the fly and deleted after step execution
