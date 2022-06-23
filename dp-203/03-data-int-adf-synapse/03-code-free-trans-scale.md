# Perform code-free transformation at scaline with Azure Data Factory or Azure Synapse Pipeline
[https://docs.microsoft.com/en-us/learn/modules/code-free-transformation-scale/]

## Transformation methods
- Mapping Data Flow
  - visual transf. tool
  - spark clusters
- SSIS (SQL Server Integration Services)
  - usually custom packages for ingest/transfrom
  - lift and shift to Azure

## Transformation types
- schema modifier transf.
- row modifier transf.
  - e.g. sort
- multiple input/output transf.
  - generate or merge pipelines
  - e.g. union
### Expression builder
- visual helper for building SQL queries

## Power Query
- data preparation for people who don't know spark or SQL
- similar interface as Excel

## ADF and Databricks
Usual steps
- Storage account for ingest and transf.
- ADF
- Pipeline with copy: Extract, Load
- Databricks notebook in pipeline: Transform
- Analyze in Databricks

## SSIS
