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
