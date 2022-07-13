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
- *at-least-once* event delivery# Enable reliable messaging for Big Data application using Azure Event Hubs
[https://docs.microsoft.com/en-us/learn/modules/enable-reliable-messaging-for-big-data-apps-using-event-hubs]

## Azure Event Hubs
- pub-sub model
- event is a packet of info (datagram) with notification
  - published individually or in batches
    - publication must be < 1 MB
- publishers
  - Advanced Message Queuing Protocol (AMQP) 1.0
    - for frequent data
    - high init overhead
  - HTTPS
    - more overhead per request
    - no init overhead
  - Kafka
- subscribers
  - EventHubReceiver
    - simple
    - limited management
  - EventProcessorHost
    - efficient
- consumer groups process stream independently from each other
- default 4 partitions

## Configuring applications to send and receive through Event Hubs
- sending
  - Event hub namespace name
  - Event hub name
  - Shared access policy name
  - Primary shared access key
- receiving
  - Event hub namespace name
  - Event hub name
  - Shared access policy name
  - Primary shared access key
  - If using Blob Storage for message storing
    - Storage acc. name, conn. string, container name

## Event Hub performance
- test resilience
  - received messages are transmitted and processed even if received during downtime
    - downtime due to backend service maintenance
  - client SDKs have built-in resilience
  - useful metrics
    - throttled requests: exceeded throughput limit
    - active connections
    - incoming/outgoing bytes# Ingest data streams with Azure Stream Analytics
[https://docs.microsoft.com/en-us/learn/modules/ingest-data-streams-with-azure-stream-analytics]

## Windowing
- tumbling (just standard windows)
  - contiguous series
  - fixed-size, non-overlapping
  - event belongs to exactly one window
  - `GROUP BY TumblingWindow(minute, 10)`
    - exclusive beginning, inclusive end
  - output at end of windows
- hopping
  - fixed-size, overlapping
  - basically overlapping tumbling
  - event belongs to at least one window
  - `GROUP BY HoppingWindow(minute, 10, 5)`
    - hops every 5 minutes
- sliding
  - fixed-size
  - new window every time event is created
    - window contains all points received less than <size> time ago
  - event belongs to at least one window
  - `GROUP BY SlidingWindow(minute, 10) HAVING COUNT(*) > 3`
    - windows are 10 min long, only windows with 4 or more events are considered
- session
  - variable-size, non-overlapping
  - clusters events received at similar times
  - timeout is max distance between neighboring events in window
  - maximum duration
  - can specify partitioning key
  - `GROUP BY Username, SessionWindow(minute, 2, 10) OVER (PARTITION BY Username)`
    - 2 min timeout, 10 min max duration
    - partitioned by Username
- snapshot
  - group by identical timestamp values
  - `GROUP BY System.Timestamp()`\n
