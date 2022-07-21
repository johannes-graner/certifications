# Get started with Azure Databricks
<https://docs.microsoft.com/en-us/learn/modules/get-started-azure-databricks/>

## Mount to DBFS
- `dbutils.fs.mount(source, mount_point, extra_configs)`
  - put storage account key in `extra_configs`
# Prepare data for machine learning with Azure Databricks
<https://docs.microsoft.com/en-us/learn/modules/prepare-data-for-machine-learning-azure-databricks/>

## Data cleaning
- imputation options
  - drop row
  - placeholder value 
    - e.g. -1 for age
  - basic imputing 
    - e.g. mean, median or mode
  - advanced imputing
    - clustering algorithm 
    - oversampling techniques like Synthetic Minority Over-sampling TEchnique (SMOTE)

## Feature engineering
- different types
  - aggregation
  - part-of
    - e.g. year of date
  - binning
    - grouped aggregations
  - flagging
    - boolean conditions
  - frequency-based
    - freq. of cat. vars
  - embedding
    - transform cat. or text vars to set of possibly different cardinality
    - e.g. word-2-vec
  - deriving by example

## Data encoding
- encode categorical variables
- ordinal encoding
  - implies ordering of categories
- one-hot encoding
  - pivots column with flag
# Train a machine learning model with Azure Databricks
<https://docs.microsoft.com/en-us/learn/modules/train-machine-learning-model-azure-databricks/>

## Spark ML
- MLLib
  - legacy approach
  - builds on RDDs
  - maintanence mode since Spark 2.0
- Spark ML
  - supports DataFrames
  - technically the same library as MLLib, just in a different package (and being updated)
- split data
  - `df.randomSplit()`
- train model
  - transformer
    - have `.transform()` method
  - estimator
    - input: df, output: `Model`
    - have `.fit()` method
  - pipeline
    - combine transformers and estimators
    - have `.fit()` method
- validate model
  - `Model.summary`
  - `Model.transform(test_data)`
    - use e.g. `RegressionEvaluator` for metrics

## Other ML frameworks
- ML runtime includes TensorFlow, PyTorch, Keras, and XGBoost
  - also includes libraries for distributed training
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

# Deploy Azure Databricks models in Azure Machine Learning
<https://docs.microsoft.com/en-us/learn/modules/deploy-azure-databricks-models-azure-machine-learning/>

## AML endpoints
- local web service
  - testing/debug
- AKS
  - real-time inference
  - autoscaling, low latency
- ACI
  - testing
  - low-scale, CPU-based
- AML Compute Clusters
  - batch inference
  - serverless compute
    - normal or low-prio VMs
- Azure IoT Edge
  - IoT module
  - deploy and serve ML models on IoT devices

## Deploying model
- same as through AML notebook
  - except for need to connect to AML workspace
# Tune hyperparameters with Azure Databricks
<https://docs.microsoft.com/en-us/learn/modules/tune-hyperparameters-azure-databricks/>

## Automated MLflow
- automatically logs hyperparams and metrics
  - creates hierarchy for runs with different models
- requirements
  - code in python notebook
  - Databricks Runtime (with or without ML)
  - hyperparam tuning with `CrossValidator` or `TrainValidationSplit`
- parent run with metadata about method
  - child run for each model
### Run tuning code
- list hyperparams
  - `model.explainParams()`
    - name, description, default
- set up search space
  - `ParamGridBuilder()`
  - serial training by default
    - can train in parallel
- run with auto MLflow
  - `pyspark.ml.tuning.CrossValidator`
    - `estimator` (pipeline)
    - `estimatorParamMaps` (param grid)
    - `evaluator`
    - `numFolds` (k)
    - `seed`
  - `cv.fit(trainDF).bestModel`

## Hyperparam tuning with Hyperopt
- open-source
- flexible, can optimize any python model
- included in DBR ML
- steps
  - define objective function to minimize
    - usually training or validation loss
  - define hyperparam search space
    - `hp.choice(label, options)`: exhaustive list
    - `hp.randint(label, upper)`
    - `hp.uniform(label, low, high)`
    - `hp.normal(label, mu, sigma)`
  - select search algo
    - `hyperopt.tpe.suggest`
      - Tree of Parzen Estimators
      - Bayesian
    - `hyperopt.rand.suggest`
      - random search
      - non-adaptive
  - start run with `fmin`
    - `fn`: objective function
    - `space`
    - `algo`
    - `max_evals`
    - `max_queue_len`
      - no. hyperparams generated ahead of time
      - can save time with TPE
    - `trials`
      - `SparkTrials` for single-machine
      - `Trials` for distributed (e.g. MLlib or Horovod)
# Distributed deep learning with Horovod and Azure Databricks
<https://docs.microsoft.com/en-us/learn/modules/distributed-deep-learning-horovod-azure-databricks/>

## Horovod
- open-source distributed training framework
  - builds on MPI
    - Spark compatibility through `HorovodRunner` in Databricks
    - uses worker-to-worker communication to avoid bottleneck at driver
  - APIs for TensorFlow, PyTorch, and Keras
### Horovod process
- explore models on single node using TF, PT, or Keras
- migrate code to Horovod
  - initalize Horovod: `hvd.init()`
  - pin one GPU per process (if using GPUs)
  - specify partitioning/sampling
    - all subsets should have equal size
    - Petastorm for parquet
  - scale learning rate by no. workers
    - makes sure weights are adjusted properly at end of epoch
  - Horovod distribution optimizer handles worker-to-worker communication
  - broadcast initial params
  - checkpoint only on worker 0 to avoid conflicts
- distribute with HorovodRunner
