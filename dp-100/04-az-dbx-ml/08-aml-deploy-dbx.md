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