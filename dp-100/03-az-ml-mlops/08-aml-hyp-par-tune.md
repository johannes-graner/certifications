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