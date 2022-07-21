# Explore and analyze data with Python
<https://docs.microsoft.com/en-us/learn/modules/explore-analyze-data-with-python>

## Pandas
- DataFrame syntax
  - `df.loc[i]` search by index
    - ranges include lower and upper bound
  - `df.iloc[i]` search by row number
    - ranges include only lower bound
  - `df.query(...)`
  - `pf.read_csv(file, delimiter=',', header='infer')`
  - `df.isnull().sum()` to get no. nulls per column
  - `pd.concat(df1, df2, axis)` to union or join by index
  - `df.plot.bar(x,y,color=...,figsize=(6,4))` to call matplotlib
  - `df.describe()` for descriptive statistics
  - `df.boxplot(column=..., by=..., figsize=...)` for grouped boxplots

## Data issues
- skewness
  - right skew = more mass to the right = heavy-tailed to the right

# Train and evaluate regression models
<https://docs.microsoft.com/en-us/learn/modules/train-evaluate-regression-models/>

## Regression basics
- Root Mean Squared Error (RMSE) has same unit as predicted label

## Different regression models
- linear regression
- decision trees
- ensemble algorithms
  - large number of dec. trees
  - e.g. random forest
### Ensemble models
- bagging: aggregate over several models
- boosting: models build on each other

## Improving models
- hyperparameters for iterative models
  - tune by grid search
- preprocess data
- scale features
- categorical features as one-hot encoding

## Saving models
- `joblib.dump(model, filename)` to store as pickle (.pkl)
- load saved model to 'inference' or 'score' (i.e. predict)

# Train and evaluate classification models
<https://docs.microsoft.com/en-us/learn/modules/train-evaluate-classification-models/>

## Metrics
- `sklearn.metrics.classification_report(y_test, predictions)`
- precision (true positive rate)
  - proportion of correct predictions for class
  - of predicted diabetics, how many are actually diabetic?
  - tp / (tp + fp)
- recall (false positive rate)
  - proportion of class identified
  - of all diabetic patients, how many were identified?
  - tp / (tp + fn)
- F1-score
  - combination of precision and recall
  - 2 tp / (2 tp + fp + fn)

## Different algorithms
- log reg
- support vector machine
  - hyperplane separating classes
- tree-based
- ensemble
  - combines outputs of several algorithms

## Multi-class models
- One vs Rest (OVR)
  - classifier for each class value
    - square or not
    - circle or not
    - triangle or not
- One vs One (OVO)
  - classifier for each class pair
    - square or circle
    - square or triangle
    - circle or triangle
- with *m* classes, confusion matrix is (*m\*m*)
- ROC curve for each OVR class
  - aggregate area for AUC
# Train and evaluate clustering models
<https://docs.microsoft.com/en-us/learn/modules/train-evaluate-cluster-models/>

## Different clustering algorithms
- k-means
- hierarchical
  - divisive
  - agglomerative

## Metrics
- Within Cluster Sum of Squares (WCSS)
  - decreases with number of clusters
  - elbow plot
# Train and evaluate deep learning models
<https://docs.microsoft.com/en-us/learn/modules/train-evaluate-deep-learn-models/>

## Concepts
- optimizers (minimizer algos for loss function)
  - Stochastic Gradient Descent (SGD)
  - Adaptive Learning Rate (ADADELTA)
  - Adaptime Momentum Estimation (Adam)
- learning rate
  - how much the optimizer adjusts weights and biases

## Deep Learning with PyTorch
- save models as `.pt`

## CNNs
- convolution layer
  - moving weighted average
  - activation function
    - often Rectified Linear Unit (ReLU) to set negative values to 0
- pooling layer
  - downsample
    - max pooling (max value in filter area)
- dropping layers
  - prevent overfitting
  - randomly drop feature maps
    - randomness applied per epoch
- flattening layers
  - used after pooling layer
  - flattens feature map (matrix) to a vector
  - often used before fully connected layer
- fully connected layer
  - CNN usually ends with fully connected layer
  - basically a standard neural network

## Transfer learning
- CNNs typically consist of two parts
  - set of layers from base model for feature extraction
  - fully connected layer that uses extracted features for class prediction
- transfer learning is to use an already trained set of feature extraction layers
  - very effective for e.g. image classification
    - features: edges, corners, shapes, etc.
    - train prediction layers on custom data
# Use automated machine learning in Azure Machine Learning
<https://docs.microsoft.com/en-us/learn/modules/use-automated-machine-learning/>

## Azure ML
- compute
  - compute instances
  - compute clusters
  - inference clusters
    - predictive services
  - attached compute
    - link to existing resources
    - VMs, Databricks clusters, etc.

## Auto ML
- prepare data
  - based on datasets (files, data stores etc.)
- train model
  - only supervised models
  - model types
    - regression
    - classification
    - time series forecasting
    - NLP
    - computer vision
  - config
    - primary metric
    - blocked/allowed models
    - exit criteria
    - concurrency limit
- evaluate performance
  - model chosen by cross-validation and primary metric
  - residual histogram
  - predicted vs true plot
- deploy a predictive service
  - Azure Container Instances (ACI)
    - suitable for testing
  - Azure Kubernetes Services (AKS)
    - recommended for production
    - must create inference cluster
# Create a Regression Model with Azure Machine Learning designer
<https://docs.microsoft.com/en-us/learn/modules/create-regression-model-azure-machine-learning-designer/1-introduction>

## Pipelines
- ML steps as drag-and-drop
- models from pipelines can be published
  - create inference pipeline first
  - Azure ML Studio -> Endpoints
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
- submit script: `experiment.submit(config=...).wait_for_completion(show_output=[T/F])`
- can also use MLFlow
# Train a machine learning model with Azure Machine Learning
<https://docs.microsoft.com/en-us/learn/modules/train-local-model-with-azure-mls/>

## Training scripts
- python script which logs metrics and output files
  - training itself can be separate from AML (e.g. pure sklearn)
- run script as experiment:
  - specify environment
  - `ScriptRunConfig` referencing folder and script file
### Script parameters
- e.g. `argparse` library
- pass with `arguments = ['--reg-rate', 0.1]` in ScriptRunConfig

## Registering models
- `Model.register(...)`
  - must specify local path, download `.pkl` first
  - alt. `run.register_model(...)`
- `Model.list(ws)` to get list of models
# Work with Data in Azure Machine Learning
< https://docs.microsoft.com/en-us/learn/modules/work-with-data-in-aml/>

## Datastores
- abstraction for cloud data source
  - e.g. Az Storage, ADL, Az SQL DB, Az DBFS
- built-in datastores
  - storage blob container (system storage)
  - storage file container (system storage)
  - sample datastore (only if you use sample datasets)
- register in AML Studio UX or SDK
  - `Datastore.register_azure_blob_container(...)`
- use in SDK:
  - list: `ws.datastores`
  - get: `Datastore.get(ws, datastore_name=...)`
    - `ws.get_default_datastore()`
- considerations
  - premium blob storage improve I/O, but is more expensive
  - parquet > csv
  - can change default datastore for easy access
    - `ws.set_default_datastore(...)`

## Datasets
- versioned data objects
- support data labeling and drift monitoring
- types
  - tabular (structured)
  - file (semi- or unstructured)
- create/register datasets
  - supports path globbing
  - register to make available for other experiments and pipelines
  - tabular:
    - `Dataset.Tabular.from_delimited_files(path=...).register(ws, name=...)`
      - `path` is list of tuples `(datastore, globbed path)`
  - file:
    - `Dataset.File.from_files(path=...).register(ws, name=...)`
- retrieve dataset (two ways)
  - `ws.datasets[name]`
  - `Dataset.get_by_name(ws, name)`
- versioning
  - `ds.register(ws, name=..., create_new_version=True)`
  - `Dataset.get_by_name(ws, name, version=...)`
### Using datasets
#### Tabular
- directly cast tabular datasets to Pandas or Spark
- pass tab. ds to script
  - pass ds id as argument OR
  - named input: 
    - `ScriptRunConfig`: `arguments=['--ds', tab_ds.as_named_input('my_ds')]`
    - Script: `run.input_datasets['my_ds']`
      - still have to parse input argument
#### File
- `file_ds.to_path()` to list all file paths in dataset
- pass to script:
  - two modes: `.as_mount` or `.as_download`
    - `as_download`: most cases, copies to temp location on compute
    - `as_mount`: large dataset, stream files from source
  - can put `.as_named_input(...)` before mode
    - `args.dataset_folder()` to get dir for files

# Work with Compute in Azure Machine Learning
<https://docs.microsoft.com/en-us/learn/modules/use-compute-contexts-in-aml/>

## Environments
- usually Docker containers
### Create environment
- from specification file
  - `.yaml` file
  - name
  - dependencies
  - `Environment.from_conda_specification(name=..., file_path=...)`
- from existing environment
  - `Environment.from_existing_conda_environment(name=..., conda_environment_name=...)`
- by specifying packages
  - `env = Environment(name)`
  - `deps = conda_dependencies.CondaDependencies.create(conda_packages=..., pip_packages=...)`
  - `env.python.conda_dependencies = deps`
- custom environment cannot have `AzureML-` prefix
### Config env containers
- AML can auto-choose appropriate image
- custom pre-built image
  - `env.docker.base_image=...`
  - `env.docker.base_image_registry='myregistry.azurecr.io/myimage'`
- create from dockerfile
  - `env.docker.base_image=None`
  - `env.docker.base_dockerfile='./Dockerfile'`
- can use custom python installation
  - `env.python.user_managed_dependencies=True`
  - `env.python.interpretedpath='/opt/miniconda/bin/python'`
### Register environments
- create: `env.register(ws)`
- list: `Environment.list(ws)`
- get: `Environment.get(ws, name=...)`

## Compute targets
- create managed compute (instance/cluster)
  - `compute.AmlCompute.provisioning_configuration(vm_size, min_nodes, max_nodes, vm_priority)`
  - `compute.ComputeTarget.create(ws, name, config)`
- attach unmanaged compute (e.g. DBX cluster)
  - `compute.DatabricksCompute(...)`
  - `compute.ComputeTarget.attach(ws, name, config)`
- check existance:
```
from azureml.core.compute import ComputeTarget, AmlCompute
from azureml.core.compute_target import ComputeTargetException

compute_name = "aml-cluster"

try:
    aml_cluster = ComputeTarget(workspace=ws, name=compute_name)
    print('Found existing cluster.')
except ComputeTargetException:
    # If not, create it
    compute_config = AmlCompute.provisioning_configuration(vm_size='STANDARD_DS11_V2',
                                                           max_nodes=4)
    aml_cluster = ComputeTarget.create(ws, compute_name, compute_config)
```
### Use compute targets
- specify `compute_target=name` in `ScriptRunConfig`
  - can also create `compute.ComputeTarget` and reference that
# Orchestrate machine learning with pipelines
<https://docs.microsoft.com/en-us/learn/modules/create-pipelines-in-aml/>

## Pipeline steps
- common steps
  - `PythonScriptStep`
  - `DataTransferStep`: copy data between Datastores using ADF
  - `DatabricksStep`: notebook, script, or jar on dbx cluster
  - `AdlaStep`: U-SQL job in Azure Data Lake Analytics
  - `ParallelRunStep`: python script as distributed task on multiple nodes
- syntax
  - pipeline module: `azureml.pipeline`
  - create step: `step1 = steps.PythonScriptStep(name, source_directory, script_name, compute_target)`
  - compose steps into pipeline: `train_pipeline = core.Pipeline(ws, steps = [step1,...])`
  - run pipeline: `experiment.submit(train_pipeline)`

## Pass data between steps
- `OutputFileDatasetConfig` object
  - reference datastore location for interim storage
  - creates data dependency between steps
- syntax
  - `prepped_data = azureml.data.OutputFileDatasetConfig('prepped')`
  - `['--out_folder', prepped_data]` as argument in step 1 (output into `prepped_data`)
    - in step 1: 
    ```
    parser.add_argument('--out_folder', type=str, dest='folder')
    args = parser.parse_args()
    output_folder = args.folder
    ...
    prepped_df = ...
    ...
    output_path = os.path.join(output_folder, 'prepped_data.csv')
    prepped_df.to_csv(output_path)
    ```
  - `['--training-data', prepped_data.as_input()]` as argument in step 2 (use `prepped_data`)

## Step reuse
- cache long-running steps
- on by default
  - can lead to stale results
- set `allow_reuse = False` in e.g. `PythonScriptStep` to disable
- can force all steps to run by `experiment.submit(pipeline, regenerate_outputs=True)`

## Publish pipeline
- create REST endpoint through which pipeline can be run
- `pipeline.publish(name, description, version)`
  - or `run.publish_pipeline(...)`
- REST endpoint: `published_pl.endpoint`
- using endpoint
  - auth header
    - token for service principal
  - JSON payload with `ExperimentName`
  - run async
  - responds with run ID

## Pipeline parameters
- `reg_param = azureml.pipeline.core.graph.PipelineParameter(name='reg_rate', default_value=0.01)`
- parameter as argument in steps that use it
- run parametrized pl through rest
  - add `ParameterAssignments` field to JSON payload
    - e.g. `"ParameterAssignments": {"reg_rate": 0.1}`

## Schedule pipelines
- periodic intervals
  - `daily = core.ScheduleRecurrence(frequency='Day', interval=1)`
  - `core.Schedule.create(ws, name, description, pipeline_id, experiment_name, recurrence=daily)`
- on data change
  - `Schedule.create(..., datastore, path_on_datastore)` (without `recurrence`)
# Deploy real-time machine learning services with Azure Machine Learning
<https://docs.microsoft.com/en-us/learn/modules/register-and-deploy-model-with-amls/>

## Deploy model
- real time web service
  - local compute
  - Azure Machine Learning compute instance
  - Azure Container Instance (ACI)
  - Azure Kubernetes Service (AKS) cluster
  - Azure Function
  - IoT module
- model is packaged as container and deployed in compute target
### Register model
- register a trained model in AML workspace
### Define inference config
- model service needs entry script and environment
- entry script
  - `init()` to initialize
    - load model (often into global variable, declared as `global model`)
  - `run(raw_data)` to predict with new data
- environment
  - use `azureml.core.Environment`
- `InferenceConfig` combines script and env
  - `azureml.core.model.InferenceConfig(source_directory, entry_script, environment)`
### Define deploy config
- e.g. AKS
  - create compute target (not needed for ACI)
    - `compute_config`: `azureml.core.compute.AksCompute.provisioning_configuration(location)`
    - `production_cluster`: `ComputeTarget.create(ws, cluster_name, compute_config)`
  - define deploy config (not needed for Azure Function)
    - `azureml.core.webservice.AksWebservice.deploy_configuration(cpu_cores, memory_gb)`
### Deploy model
- `azureml.core.model.Model.deploy(ws, models=[model], inference_config, deployment_config, deployment_target)`

## Consume model
- JSON: `{"data": [ [0.1,2.3], [0.2,1.8], ... ]}`
- SDK:
  - convert data to JSON with `json.dumps`
  - run service: `service.run(input_data=json_data)`
  - get predictions from JSON response: `json.loads(response)`
- REST:
  - HTTP POST request to endpoint URI
    - header: `{ 'Content-Type':'application/json' }`
    - payload: JSON as above
- authentication
  - key
  - token (JSON Web Token (JWT))
    - client application must verify through Azure AD
  - defaults
    - auth disabled for ACI
    - key-based for AKS
  - retrieve keys to authenticated workspace by `service.get_keys()`
  - add `"Authorization":"Bearer " + key_or_token` to request header

## Troubleshooting
- check service state
  - `AksWebservice(name, ws).state` should be Healthy
- review logs
  - `service.get_logs()`
- deploy to local contaainer
  - deploy config: `azureml.core.webservice.LocalWebservice.deploy_configuration(port)`
  - deploy: `Model.deploy(ws, name, [model], inference_config, deployment_config)`
  - make changes to scoring file referenced in infer_config
    - reload local service: `service.reload()`
# Deploy batch inference pipelines with Azure Machine Learning
<https://docs.microsoft.com/en-us/learn/modules/deploy-batch-inference-pipelines-with-azure-machine-learning/>

## Create batch inference pipeline
- register model
- scoring script
  - `init()`
  - `run(mini_batch)`
- create pipeline with ParallelRunStep
  - `ParallelRunConfig`
    - `source_directory`
    - `entry_script` (scoring script)
    - `mini_batch_size`
    - `error_threshold`
    - `output_action` (e.g. `"append_row"`, puts output as new row in `parallel_run_step.txt`)
    - `environment`
    - `compute_target`
    - `node_count`
  - `ParallelRunStep`
    - `name`
    - `parallel_run_config`
    - `inputs` (e.g. `[batch_data_set.as_named_input('batch_data')]`)
- run pipeline and retrieve output
  - get step: `prediction_run = next(pipeline_run.get_children())`
  - get output: `prediction_run.get_output_data('inferences').download(local_path)`

## Publish batch inference pipeline
- same as before


# Tune hyperparameters with Azure Machine Learning
<https://docs.microsoft.com/en-us/learn/modules/tune-hyperparameters-with-azure-machine-learning/>
- `azureml.train.hyperdrive`

## Define search space
- discrete hyperparameters
  - `choice(...)`
    - python list
    - range
    - comma-separated values (`choice(30,50,100)`)
  - from discrete distribution:
    - qnormal
    - quniform
    - qlognormal
    - qloguniform
- cont. hyperparameters
  - normal
  - uniform
  - lognormal
  - loguniform
- define search space
  - `param_space = { '--batch_size': choice(16, 32, 64), '--learning_rate': normal(10, 3) }`

## Sampling
- set max no. iterations
- grid sampling
  - all discrete
  - try every combination in search space
  - `GridParamSampling(param_space)`
- random sampling
  - can be mix of disc. and cont.
  - `RandomParameterSampling(param_space)`
- Bayesian sampling
  - `choice`, `uniform`, `quniform` only
  - tries to select better combinations each time
  - `BayesianParameterSampling(param_space)`

## Early termination
- abandon runs that seem worse than completed runs
  - especially useful for deep neural networks. Terminate if underperforming based on no. epochs
- evaluate at `evaluation_interval` (every n-th logging time)
- `delay_evaluation` to set min no. iterations
### Policies
- bandit policy
  - stop if underperforming best run by margin
  - `BanditPolicy(slack_amount, evaluation_interval, delay_evaluation)`
    - `slack_amount` is max diff. between metric this run and best after same no. intervals
    - can use `slack_factor` instead to compare as ratio instead of absolute
- median stopping policy
  - stop if metric is worse than median of the running average of all runs
  - `MedianStoppingPolicy(evaluation_interval, delay_evaluation)`
- truncation selection policy
  - cancel lowest performing x% of runs
  - `TruncationSelectionPolicy(truncation_percentage, evaluation_interval, delay_evaluation)`

## Hyperparameter tuning in experiment
- requirements
  - include argument for each hyperparam
  - log target performance metric (`run.log(...)`)
- config
  - `HyperDriveConfig` (config arg to `experiment.submit(...)`)
    - `run_config`
    - `hyperparameter_sampling`
    - `policy`
    - `primary_metric_name`
    - `primary_metric_goal` (e.g. `PrimaryMetricGoal.MAXIMIZE`)
    - `max_total_runs`
    - `max_concurrent_runs`
- monitor and review
  - `run.get_children()` to get all runs
  - `run.get_children_sorted_by_primary_metric()`
  - `run.get_best_run_by_primary_metric()`
# Automate machine learning model selection with Azure Machine Learning
<https://docs.microsoft.com/en-us/learn/modules/automate-model-selection-with-azure-automl/>

## Algorithms
- can block inidiviual algos
  - useful if you know problem is unsuitable
### Classification
- log reg
- Light Gradient Boosting Machine (GBM)
- decision tree
- random forest
- naive bayes
- Linear Support Vector Machine (SVM)
- XGBoost
- DNN
- others...
### Regression
- lin reg
- GBM
- decision tree
- random forest
- elastic net
- LARS lasso
- XGBoost
- others...
### Forecasting
- lin reg
- GBM
- decision tree
- random forest
- elastic net
- LARS lasso
- XGBoost
- others...

## Preprocessing and featurization
- tries several transformations automatically
- scaling and normalization
- optional featurization
  - missing value imputation
  - categorical encoding
  - drop high-cardinality features (e.g. ID)
  - feature engineering
    - e.g. individual date parts from DateTime

## Running AutoML
- `azure.train.automl.AutoMLConfig`
  - `name`
  - `task` (e.g. `'classification'`)
  - `primary_metric`
  - `training_data`
  - `validation_data`
    - optional, cross-validation if left out
  - `label_column_name`
  - `featurization`
  - `iterations`
  - `max_concurrent_iterations`
- get best run:
  - `best_run, fitted_model = automl_run.get_output()`
    - `fitted_model.named_steps` to get steps in best pipeline
# Explore differential privacy
<https://docs.microsoft.com/en-us/learn/modules/explore-differential-privacy/>

## Differential privacy
- protect inidividual data by adding noise
- statistically consistent aggregations
- different noise for each analysis
- e.g. library SmartNoise

## Data privacy parameters
- alternatives to opt-out
- noise parameter $\epsilon$
  - low $\epsilon$ -> more privacy, less accuracy
# Explain machine learning models with Azure Machine Learning
<https://docs.microsoft.com/en-us/learn/modules/explain-machine-learning-models-with-azure-machine-learning/>

## Feature importance
- global feature importance
  - relative importance of each feature in test dataset
- local feature importance
  - influence of each feature value for individual prediction
  - sum of local importance values over all classes is 0

## Using explainers
- `azureml-interpret` package
- explainers in `interpret.ext.blackbox` module
- MimicExplainer
  - global surrogate model approximates trained model
    - used to generate explanations
  - same architecture as trained model
  - `MimicExplainer`
    - `model`
    - `initialization_examples` (X_test)
    - `explainable_model` (e.g. `DecisionTreeExplainableModel`)
    - `features`
    - `classes`
- TabularExplainer
  - wrapper around SHAP explainer algos
  - `TabularExplainer`
    - `model`
    - `initialization_examples` (X_test)
    - `features`
    - `classes`
- PFIExplainer
  - Permutation Feature Importance explainer
  - shuffles feature values to measure impact on pred.
  - `PFIExplainer`
    - `model`
    - `features`
    - `classes`
- explain global feat. imp.
  - `explainer.explain_global(X_train).get_feature_importance_dict()`
    - both `X_train` and `y_train` for PFI
- explain local feat. imp.
  - only for Mimic and Tabular
  - `explainer.explain_local(X_test[0:5]).get_ranked_local_[names|values]()`
    - `get_ranked_local_names()` for feature names
    - `get_ranked_local_values()` for feature values

## Explanations in scripts
- `azureml.contrib.interpret.explanation.explanation_client.ExplanationClient.from_run(run)`
  - for attaching explanation to current run
  - `explain_client.upload_model_explanation(explanation, comment)` to upload explanation
- `ExplanationClient.from_run_id(ws, experiment_name, run_id).download_model_explanation().get_feature_importance_dict()` to view explanation

## Visualize explanations
- Explanations tab on experiment view
  - first is global feat. imp.
  - Summary Importance shows distribution of individual imp. values for features
    - swarm, box, or violin plot
    - select individual data point to view local feat. imp.
  - can create cohorts
    - e.g. age below 25 years
    - useful for seeing difference of importances across different groups
# Detect and mitigate unfairness in models with Azure Machine Learning
<https://docs.microsoft.com/en-us/learn/modules/detect-mitigate-unfairness-models-with-azure-machine-learning/>

## Model fairness
- predicition disparity
  - compare predictions for each group in a sensitive feature
    - e.g. 36% in under 25s, 54% in 25 and over -> 54-36=18% disparity
  - not immediate red flag, but can point to areas in need of investigation
- prediction performance disparity
  - compare performance (e.g. acc./prec./rec.)
  - potentially worse than just disparity
    - disparity + performance disparity = biased model
- potential causes
  - data imbalance
  - indirect correlation
    - e.g. age and credit history, and credit history and loan defaults
  - societal biases
    - can be subconscious
    - biased data collection, preparation, or modeling
- mitigating bias
  - balance training and validation data
    - over-/under-sampling
    - stratified splitting
  - feature selection/engineering analysis
    - explore interconnected correlations
  - evaluate for disparity
    - can't address bias if you don't quantify it
  - trade off predictive performance for lower disparity (bias/variance)
    - 99.5% accurate model without significant bias is better than 99.9% accurate model with such bias

## Fairlearn package
- calculates group metrics for sensitive features
- `MetricFrame` creates dataframe of metrics by group
- interactive dashboard with visualizations
  - displayed in notebook
  - can upload evaluation/mitigation analysis and view in AML Studio
### Mitigate unfairness with Fairlearn
- algos for alt. models with parity constraints
  - exponentiated gradient
    - binary class. and regression
    - cost-minimization approach
    - tries to find optimal trade-off
  - grid search
    - binary class. and regression
    - simplified exp. grad.
    - good for small no. constraints
  - threshold optimizer
    - binary class. only
    - post-processing for existing classifier
- constraints
  - demographic parity
    - equal number of pos. pred. in each group
  - true positive rate parity
    - each group has comparable tpr
  - false positive rate parity
  - equalized odds
    - ratio of tpr to fpr
  - error rate parity
    - exp. grad. or grid search only
    - error in group does not deviate greatly from overall error
  - bounded group loss
    - exp. grad. or grid search only
    - restrict loss for groups in regression model
- usually, several models are trained and compared
  - models can be compared in Fairlearn dashboard
# Monitor models with Azure Machine Learning
<https://docs.microsoft.com/en-us/learn/modules/monitor-models-with-azure-machine-learning/>

## Application Insights
- resource for telemetry logging
- associate workspace with existing App. Ins. or a new one will be created
  - check associated resource: `ws.get_details()['applicationInsights']`
- enable App. Ins. when deploying service: `[...].deploy_configuration(..., enable_app_insights=True)`
  - enable on existing service:
    - modify deployment config for AKS in Azure Portal
    - `service.update(enable_app_insights=True)`
### Capture and view telemetry
- write log data
  - just write to standard output with `print`
    - custom dimension in App. Ins. for such output
- query logs
  - SQL-like syntax (looks like KQL...)
# Monitor data drift with Azure Machine Learning
<https://docs.microsoft.com/en-us/learn/modules/monitor-data-drift-with-azure-machine-learning/>

## Data drift
- data profile changes over time
  - makes models less accurate
### Monitoring
- compare datasets
  - baseline
  - target (new data)
    - needs timestamp to measure rate of drift
- dataset monitor
  - `azureml.datadrift.DataDriftDetector`
    - `workspace`
    - `name`
    - `baseline_data_set` (`train_ds`)
    - `target_data_set`
    - `compute_target`
    - `frequency`
      - `Day`, `Week`, or `Month`
    - `feature_list`
      - list of feature column names
    - `latency`
      - no. hours for new data to be collected and added to target
  - compare all in target to baseline: `monitor.backfill(start, end)`
    - `start` and `end` are datetimes between which to compare to baseline
- alerts
  - data drift measured by magnitude
  - magnitude has natural variation, but large changes should be investigated
    - define `AlertConfiguration(email)` and add `drift_threshold` and `alert_configuration` to monitor
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
