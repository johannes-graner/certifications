# Train and evaluate regression models
<https://docs.microsoft.com/en-us/learn/modules/train-evaluate-regression-models/>

## Regression basics
- Root Mean Squared Error (RMSE) has same unit as predicted label

## Different regression models
- linear regression
- decision trees
- ensemble algorithms
  - large number of dec. trees
  - e.g. random forest
### Ensemble models
- bagging: aggregate over several models
- boosting: models build on each other

## Improving models
- hyperparameters for iterative models
  - tune by grid search
- preprocess data
- scale features
- categorical features as one-hot encoding

## Saving models
- `joblib.dump(model, filename)` to store as pickle (.pkl)
- load saved model to 'inference' or 'score' (i.e. predict)
