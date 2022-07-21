# Explore and analyze data with Python
<https://docs.microsoft.com/en-us/learn/modules/explore-analyze-data-with-python>

## Pandas
- DataFrame syntax
  - `df.loc[i]` search by index
    - ranges include lower and upper bound
  - `df.iloc[i]` search by row number
    - ranges include only lower bound
  - `df.query(...)`
  - `pf.read_csv(file, delimiter=',', header='infer')`
  - `df.isnull().sum()` to get no. nulls per column
  - `pd.concat(df1, df2, axis)` to union or join by index
  - `df.plot.bar(x,y,color=...,figsize=(6,4))` to call matplotlib
  - `df.describe()` for descriptive statistics
  - `df.boxplot(column=..., by=..., figsize=...)` for grouped boxplots

## Data issues
- skewness
  - right skew = more mass to the right = heavy-tailed to the right

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
# Train and evaluate clustering models
<https://docs.microsoft.com/en-us/learn/modules/train-evaluate-cluster-models/>

## Different clustering algorithms
- k-means
- hierarchical
  - divisive
  - agglomerative

## Metrics
- Within Cluster Sum of Squares (WCSS)
  - decreases with number of clusters
  - elbow plot
# Train and evaluate deep learning models
<https://docs.microsoft.com/en-us/learn/modules/train-evaluate-deep-learn-models/>

## Concepts
- optimizers (minimizer algos for loss function)
  - Stochastic Gradient Descent (SGD)
  - Adaptive Learning Rate (ADADELTA)
  - Adaptime Momentum Estimation (Adam)
- learning rate
  - how much the optimizer adjusts weights and biases

## Deep Learning with PyTorch
- save models as `.pt`

## CNNs
- convolution layer
  - moving weighted average
  - activation function
    - often Rectified Linear Unit (ReLU) to set negative values to 0
- pooling layer
  - downsample
    - max pooling (max value in filter area)
- dropping layers
  - prevent overfitting
  - randomly drop feature maps
    - randomness applied per epoch
- flattening layers
  - used after pooling layer
  - flattens feature map (matrix) to a vector
  - often used before fully connected layer
- fully connected layer
  - CNN usually ends with fully connected layer
  - basically a standard neural network

## Transfer learning
- CNNs typically consist of two parts
  - set of layers from base model for feature extraction
  - fully connected layer that uses extracted features for class prediction
- transfer learning is to use an already trained set of feature extraction layers
  - very effective for e.g. image classification
    - features: edges, corners, shapes, etc.
    - train prediction layers on custom data
