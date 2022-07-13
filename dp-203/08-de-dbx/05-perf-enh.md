# Azure Databricks performance features
[https://docs.microsoft.com/en-us/learn/modules/describe-lazy-evaluation-performance-features-azure-databricks]

## Shuffles and Tungsten
- UnsafeRow = Tungsten Binary Format (TBF)
  - in-memory format for Spark SQL, DataFrames & Datasets
  - compact
  - Spark operates directly on TBF
- data is converted to TBF, written to disk, then shuffled
  - prevents serde
### Stages
- shuffling creates stage boundaries (sync points)
- shuffle files are temporarily cached on executors
  - allows stage skipping
  - manually caching makes sure files are persisted