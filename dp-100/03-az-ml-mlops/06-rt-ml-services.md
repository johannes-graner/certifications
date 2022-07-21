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