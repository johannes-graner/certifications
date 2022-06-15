# Fundamentals of real-time analytics
## Batch and stream processing
### Batch
Advantages
- Large volumes of data can be processed at a convenient time
- Can schedule to run e.g. overnight or on off-peak hours

Disadvantages
- Latency between ingestion and processing
- All data must be ready before processing starts
  - i.e. errors stop the whole process

### Diffs between batch and stream
- data scope
  - batch: access to all data at once
  - stream: only the most recent or rolling window
- Data size
  - batch: optimized for parallel processing of large datasets
  - stream: processes one record at a time (or microbatching)
- Latency
  - batch: up to several hours
  - stream: seconds or milliseconds
- Analysis
  - batch: complex analysis tasks
  - stream: simple aggregations or response functions

### Combining batch and stream
Do simple analysis as stream while persisting data for large scale historical batch analysis

## Stream processing architecture
1. Event happens
1. Generated data is captured in *source*
1. data is processed
1. processed data is written to *sink*

### In Azure
- Azure Stream Analytics: PaaS for non-changing query
- Spark Structured Streaming
  - used in Synapse Analytics, Databricsk, HDInsight
- Azure Data Explorer: real-time DB for time-series
  - used in Synapse Analytics

Sources:
- Azure Event Hubs
  - Queue with strict ordering and exactly-once semantics
- Azure IoT Hub
  - Event Hub optimized for IoT
- Azure Data Lake Store Gen 2
  - usually batch, can be used for stream too
- Apache Kafka
  - open-source
  - can be used with HDInsight

Sinks:
- Event Hubs
  - queue for downstream processing
- Data Lake Store Gen 2
  - persist result as file
- SQL DB, Synapse Analytics, Databricks
  - persist result as table
- Power BI
  - reports and visualizations

## Azure Stream Analytics
- Streaming pipeline
  - ingest
  - process
  - persist
- runs perpetually
  - processes data as it comes in
- Good for continually capturing data

### Stream Analytics Jobs
- Can use static data for reference or joining
- Intensive jobs can be run on clusters (scalable dedicated tenants)

## Spark on Azure
Used in Synapse Analytics, Databricks, and HDInsight
- Synapse and Databricks support Delta Lake

## Azure Data Explorer
Analyze big data from
- web
- apps
- IoT
- etc.

Ex. use case: process Stream Analytics errors

Ingest with connectors or programmatically
- stream and batch

Good for logs and IoT
- Uses Kusto Query Language (KQL)
  - Optimized for read
  - Made for DAs
- Especially in Synapse