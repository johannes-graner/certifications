# Enable reliable messaging for Big Data application using Azure Event Hubs
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
    - incoming/outgoing bytes