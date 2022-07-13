# Work with data stream by using Azure Stream Analytics
[https://docs.microsoft.com/en-us/learn/modules/introduction-to-data-streaming]

## Stream processing approaches
- live 
  - more processing power
  - near-real-time insights
  - Event Hubs -> Azure Stream Analytics -> Power BI
- on-demand
  - data stored before processed
  - static batch processing
  - IoT/Event Hub -> ADLS G2 -> Stream Analytics -> Power BI

## Event processing
- event producer
  - Event Hubs, IoT Hub
- event processor
  - computes aggregations
  - Azure Stream Analytics
- event consumer
  - visualize or take action
  - Power BI

## Azure Stream Analytics
- PaaS
- producers
  - sensors, systems, applications
- ingestion
  - Event Hubs, IoT Hub, Blob storage
- Stream analytics engine
  - process, aggregate, transform
  - Stream Analytics Query Language (SAQL)
    - subset of T-SQL
- consumer
  - ADLS G2, Cosmos DB, SQL DB
  - Power BI
- *exactly once* event processing
- *at-least-once* event delivery