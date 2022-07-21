# Use MLflow to track experiments in Azure Databricks
<https://docs.microsoft.com/en-us/learn/modules/use-mlflow-to-track-experiments-azure-databricks/>

## MLflow
- open source ML development lifecycle manager
  - train, register, deploy, update
- tightly integrated in Databricks
  - works outside Databricks as well
### Components
- Tracking
  - logging utility
    - parameters
    - library versions
    - metrics
    - output files
- Projects
  - package code for deployment
    - Conda
    - Docker
    - directly on system
  - at least one entry point (`.py` or `.sh`)
- Models
  - standardized model packaging format
  - can include other files as well (e.g. images)
  - allows MLflow to work with models from many frameworks (flavors)
    - scikit-learn
    - Keras
    - MLlib
    - ONNX
    - [etc.](https://mlflow.org/docs/latest/models.html#built-in-model-flavors)
- Model Registry
  - register models for use in Projects and Models
  - serve models through REST or Databricks
  - staging
    - staging, production, archive
- syntax
  - `with mlflow.start_run():`
    - `mlflow.log_param(key, value)`
    - train model
    - `mlflow.log_metric(key, value)`