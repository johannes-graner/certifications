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