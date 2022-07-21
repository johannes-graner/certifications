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