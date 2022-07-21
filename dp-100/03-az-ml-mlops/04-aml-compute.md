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
```python
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