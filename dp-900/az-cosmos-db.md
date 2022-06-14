# Fundamentals of Azure Cosmos DB
- Scalable NoSQL DB
- Supports multiple APIs
- Indexed and partitioned data
- Several Azure regions can be added to a Cosmos DB
  - Results in local replicas

## When to use Cosmos DB
- Partitions up to 10 GB
- automatic indexing
- IoT
  - Burst data
  - Can define triggers on data ingest
- Retail and marketing
  - Windows Store, Xbox Live
- Gaming
  - very low latency
  - spiking request rates
- Web and mobile
  - Xamarin for Android/iOS

## APIs
- SQL
  - Native API
  - Returns JSON documents
- MongoDB
- Table API
  - for k-v pairs
  - better scalability and performance than Table Storage
  - language-specific SDKs to call table
- Cassandra
  - column-family
  - SQL-based syntax
- Gremlin
  - graph DBs