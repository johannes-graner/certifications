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