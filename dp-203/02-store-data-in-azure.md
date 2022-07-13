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
# Create an Azure storage account
[https://docs.microsoft.com/en-us/learn/modules/create-azure-storage-account/]
## No. accounts needed
### Storage account settings
- Subscription: billing unit
- Location: which datacenter
- Performance
  - standard: HDD
  - premium: SSD, more services
- Replication
  - local: disk failure
  - geo: data center failure
- Access tier: hot/cool/archive
- Secure transfer required: HTTPS vs HTTP
- Virtual networks: specify vn's to accept requests from
### How many accounts are needed?
- Can reuse accounts with exactly the same settings as required.
- Depends on data diversity, cost sensitivity, tolerance for management overhead
  - Data diversity: e.g. data by region, sensitivity level
  - Cost sensitivity: e.g. geo-redundant, premium tier
  - tol. for man. oh: each account needs admin time

## Choose account settings
- deployment model: use resource manager
- account kind
  - general v2: for most things, cheapest storage
  - general v1: slightly cheaper trans. than v2, less features
  - blob: don't choose this

## Notes
- Name must be globally unique (part of URI)
# Connect an app to Azure Storage
[https://docs.microsoft.com/en-us/learn/modules/connect-an-app-to-azure-storage/]
## Azure storage services
- up to 250 accounts per subscription
- up to 5 PiB per account
### Types
- blobs
  - block, page, append
- Files
  - cloud NAS
- Queue
  - messages, up to 64 KB per message
  - async processing
- Table

## create acc
`
az storage account create \
  --resource-group learn-719c5238-a338-4029-a23f-78b2a0db9e0b \
  --location westus \
  --sku Standard_LRS \
  --name <name>
`

## Interact through APIs
- REST
  - need to manually parse XML
- client library
  - e.g. .NET, Java, Python, Node, Go
  - wrappers around REST API

## Connect to acc
- Access key
  - connection string
- REST API endpoint
  - e.g. ```https://[name].blob.core.windows.net/```
# Secure you Azure Storage Account
[https://docs.microsoft.com/en-us/learn/modules/secure-azure-storage-account/]
## Security in Azure storage
- Encryption at rest
  - Storage Service Encryption (SSE)
    - 256-bit AES
    - FIPS 140-2 compliant
  - virtual disks (VHDs) for VMs
    - Azure Disk Encryption
    - BitLocker for Windows
    - dm-crypt for Linux
- Encryption in transit
  - can enforce HTTPS only by *secure transfer*
    - also enforces SMB 3.0 for file shares
- CORS support
  - Cross-Origin Resource Sharing
  - system for restricting GET requests
  - optional flag on storage accounts
- Role-Based Access Control (RBAC)
- Auditing
  - Storage Analytics Service
  - logs every operation

## Account keys
- Better to use Azure AD when possible
  - blob, queue
- control everything in account
  - use only for in-house apps

## Shared Access Signatures (SAS)
- instead of access keys for untrusted 3rd-party apps
- service-level: access to that service
- account-level: service-level + more (e.g. create file systems)
- can provision SAS programmatically for 3rd-party authentication

## Advanced Threat Protection
- Microsoft Defender for Storage
- monitoring, anomaly detection
  - sends alerts
- Blob, Files, Data Lake Gen2
- account types: general v2, block blob, blob storage

## Data Lake
- RBAC
- POSIX-compliant ACLs (read, write, execute)
- Azure AD OAuth 2.0
# Store application data with Azure Blob Storage
[https://docs.microsoft.com/en-us/learn/modules/store-app-data-with-azure-blob-storage/]
- any number of containers in account
  - any number of blobs in container
- name-value metadata can be attached
  - cannot filter by this

## Designing a storage organization strategy
### Storage accounts
- Can use several accounts to separate costs and access
### Containers/Blobs
- Apps with other DB
  - GUID as blob name
    - referenced in internal DB in app
- Other apps
  - virtual directories
  - file extensions
- public access
  - off by default
  - turns off authentication on container level
  - good for public files
  - very scalable
    - no traffic in server-side app
- virtual directories
- blob types
  - block: most cases14
  - append: streaming or logs
  - page: random access
