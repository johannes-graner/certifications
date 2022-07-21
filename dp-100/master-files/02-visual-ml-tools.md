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
