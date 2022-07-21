# Detect and mitigate unfairness in models with Azure Machine Learning
<https://docs.microsoft.com/en-us/learn/modules/detect-mitigate-unfairness-models-with-azure-machine-learning/>

## Model fairness
- predicition disparity
  - compare predictions for each group in a sensitive feature
    - e.g. 36% in under 25s, 54% in 25 and over -> 54-36=18% disparity
  - not immediate red flag, but can point to areas in need of investigation
- prediction performance disparity
  - compare performance (e.g. acc./prec./rec.)
  - potentially worse than just disparity
    - disparity + performance disparity = biased model
- potential causes
  - data imbalance
  - indirect correlation
    - e.g. age and credit history, and credit history and loan defaults
  - societal biases
    - can be subconscious
    - biased data collection, preparation, or modeling
- mitigating bias
  - balance training and validation data
    - over-/under-sampling
    - stratified splitting
  - feature selection/engineering analysis
    - explore interconnected correlations
  - evaluate for disparity
    - can't address bias if you don't quantify it
  - trade off predictive performance for lower disparity (bias/variance)
    - 99.5% accurate model without significant bias is better than 99.9% accurate model with such bias

## Fairlearn package
- calculates group metrics for sensitive features
- `MetricFrame` creates dataframe of metrics by group
- interactive dashboard with visualizations
  - displayed in notebook
  - can upload evaluation/mitigation analysis and view in AML Studio
### Mitigate unfairness with Fairlearn
- algos for alt. models with parity constraints
  - exponentiated gradient
    - binary class. and regression
    - cost-minimization approach
    - tries to find optimal trade-off
  - grid search
    - binary class. and regression
    - simplified exp. grad.
    - good for small no. constraints
  - threshold optimizer
    - binary class. only
    - post-processing for existing classifier
- constraints
  - demographic parity
    - equal number of pos. pred. in each group
  - true positive rate parity
    - each group has comparable tpr
  - false positive rate parity
  - equalized odds
    - ratio of tpr to fpr
  - error rate parity
    - exp. grad. or grid search only
    - error in group does not deviate greatly from overall error
  - bounded group loss
    - exp. grad. or grid search only
    - restrict loss for groups in regression model
- usually, several models are trained and compared
  - models can be compared in Fairlearn dashboard