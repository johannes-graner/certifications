# Train and evaluate classification models
<https://docs.microsoft.com/en-us/learn/modules/train-evaluate-classification-models/>

## Metrics
- `sklearn.metrics.classification_report(y_test, predictions)`
- precision (true positive rate)
  - proportion of correct predictions for class
  - of predicted diabetics, how many are actually diabetic?
  - tp / (tp + fp)
- recall (false positive rate)
  - proportion of class identified
  - of all diabetic patients, how many were identified?
  - tp / (tp + fn)
- F1-score
  - combination of precision and recall
  - 2 tp / (2 tp + fp + fn)

## Different algorithms
- log reg
- support vector machine
  - hyperplane separating classes
- tree-based
- ensemble
  - combines outputs of several algorithms

## Multi-class models
- One vs Rest (OVR)
  - classifier for each class value
    - square or not
    - circle or not
    - triangle or not
- One vs One (OVO)
  - classifier for each class pair
    - square or circle
    - square or triangle
    - circle or triangle
- with *m* classes, confusion matrix is (*m\*m*)
- ROC curve for each OVR class
  - aggregate area for AUC