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