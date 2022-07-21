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