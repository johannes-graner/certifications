# Automate machine learning model selection with Azure Machine Learning
<https://docs.microsoft.com/en-us/learn/modules/automate-model-selection-with-azure-automl/>

## Algorithms
- can block inidiviual algos
  - useful if you know problem is unsuitable
### Classification
- log reg
- Light Gradient Boosting Machine (GBM)
- decision tree
- random forest
- naive bayes
- Linear Support Vector Machine (SVM)
- XGBoost
- DNN
- others...
### Regression
- lin reg
- GBM
- decision tree
- random forest
- elastic net
- LARS lasso
- XGBoost
- others...
### Forecasting
- lin reg
- GBM
- decision tree
- random forest
- elastic net
- LARS lasso
- XGBoost
- others...

## Preprocessing and featurization
- tries several transformations automatically
- scaling and normalization
- optional featurization
  - missing value imputation
  - categorical encoding
  - drop high-cardinality features (e.g. ID)
  - feature engineering
    - e.g. individual date parts from DateTime

## Running AutoML
- `azure.train.automl.AutoMLConfig`
  - `name`
  - `task` (e.g. `'classification'`)
  - `primary_metric`
  - `training_data`
  - `validation_data`
    - optional, cross-validation if left out
  - `label_column_name`
  - `featurization`
  - `iterations`
  - `max_concurrent_iterations`
- get best run:
  - `best_run, fitted_model = automl_run.get_output()`
    - `fitted_model.named_steps` to get steps in best pipeline