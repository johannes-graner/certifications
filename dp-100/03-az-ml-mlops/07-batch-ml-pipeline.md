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

