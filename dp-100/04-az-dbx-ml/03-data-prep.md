# Prepare data for machine learning with Azure Databricks
<https://docs.microsoft.com/en-us/learn/modules/prepare-data-for-machine-learning-azure-databricks/>

## Data cleaning
- imputation options
  - drop row
  - placeholder value 
    - e.g. -1 for age
  - basic imputing 
    - e.g. mean, median or mode
  - advanced imputing
    - clustering algorithm 
    - oversampling techniques like Synthetic Minority Over-sampling TEchnique (SMOTE)

## Feature engineering
- different types
  - aggregation
  - part-of
    - e.g. year of date
  - binning
    - grouped aggregations
  - flagging
    - boolean conditions
  - frequency-based
    - freq. of cat. vars
  - embedding
    - transform cat. or text vars to set of possibly different cardinality
    - e.g. word-2-vec
  - deriving by example

## Data encoding
- encode categorical variables
- ordinal encoding
  - implies ordering of categories
- one-hot encoding
  - pivots column with flag