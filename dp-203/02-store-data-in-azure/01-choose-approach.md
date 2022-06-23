# Choose a data storage approach in Azure
[https://docs.microsoft.com/en-us/learn/modules/choose-storage-approach-in-azure/]
## Classify your data
- structured, semi-structured, unstructured
### semi-structured
- serialization languages
  - XML, JSON, YAML, etc.

## Determine operational needs
- lookups
  - indexing/hashing
- latency
- complexity of queries
- volume of CRUD ops

## Group ops into transactions
- transaction = logical group of DB operations that execute together
- ACID
  - Atomicity: all or none succeed
  - Consistency: DB is consistent before and after trans.
  - Isolation: different transactions are independent
  - Durability: results of transactions are persisted

## Services
- Cosmos DB
  - NoSQL, semi-structured
  - indexes every property
- Blob storage
  - works with Az Content Delivery Network
    - caching
    - moves data to edge servers