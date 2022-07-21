# Explain machine learning models with Azure Machine Learning
<https://docs.microsoft.com/en-us/learn/modules/explain-machine-learning-models-with-azure-machine-learning/>

## Feature importance
- global feature importance
  - relative importance of each feature in test dataset
- local feature importance
  - influence of each feature value for individual prediction
  - sum of local importance values over all classes is 0

## Using explainers
- `azureml-interpret` package
- explainers in `interpret.ext.blackbox` module
- MimicExplainer
  - global surrogate model approximates trained model
    - used to generate explanations
  - same architecture as trained model
  - `MimicExplainer`
    - `model`
    - `initialization_examples` (X_test)
    - `explainable_model` (e.g. `DecisionTreeExplainableModel`)
    - `features`
    - `classes`
- TabularExplainer
  - wrapper around SHAP explainer algos
  - `TabularExplainer`
    - `model`
    - `initialization_examples` (X_test)
    - `features`
    - `classes`
- PFIExplainer
  - Permutation Feature Importance explainer
  - shuffles feature values to measure impact on pred.
  - `PFIExplainer`
    - `model`
    - `features`
    - `classes`
- explain global feat. imp.
  - `explainer.explain_global(X_train).get_feature_importance_dict()`
    - both `X_train` and `y_train` for PFI
- explain local feat. imp.
  - only for Mimic and Tabular
  - `explainer.explain_local(X_test[0:5]).get_ranked_local_[names|values]()`
    - `get_ranked_local_names()` for feature names
    - `get_ranked_local_values()` for feature values

## Explanations in scripts
- `azureml.contrib.interpret.explanation.explanation_client.ExplanationClient.from_run(run)`
  - for attaching explanation to current run
  - `explain_client.upload_model_explanation(explanation, comment)` to upload explanation
- `ExplanationClient.from_run_id(ws, experiment_name, run_id).download_model_explanation().get_feature_importance_dict()` to view explanation

## Visualize explanations
- Explanations tab on experiment view
  - first is global feat. imp.
  - Summary Importance shows distribution of individual imp. values for features
    - swarm, box, or violin plot
    - select individual data point to view local feat. imp.
  - can create cohorts
    - e.g. age below 25 years
    - useful for seeing difference of importances across different groups