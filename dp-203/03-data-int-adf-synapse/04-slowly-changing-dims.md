# Populate slowly changing dimensions in Azure Synapse Analytics pipelines
<https://docs.microsoft.com/en-us/learn/modules/populate-slowly-changing-dimensions-azure-synapse-analytics-pipelines>
- Slowly Changing Dimensions (SCD) are tables that handle changes to dimension valeus

## Describe SCD
- value of business entity changes without schedule
  - e.g. customers' contact details
- any SCD table should have column for mod. time

## SCD types
- Type 1
  - reflects latest values
  - dimension table is overwritten on update
  - use for supplementary values
- Type 2
  - supports versioning
  - add new row on update
  - isCurrent column
  - start and end date columns
- Type 3
  - old value kept in another column
  - keeps track of one change at a time
  - only for few versioned columns
- Type 6
  - combines 1,2,3
