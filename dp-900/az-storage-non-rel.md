# Azure storage for non-relational data
## Blob storage
- Blob = Binary Large OBject
- Organized in containers, access is managed on container level
### three types of blob:
- block blob
  - set of blocks up to 100 MB each
  - up to 50k blocks, > 4.7 TB
  - use for discrete, large binary objects that change infrequently
- Page blob
  - collection of 512-byte pages
  - supports random read and write
  - up to 8 TB (~16 B pages)
  - virtual disks on VMs are page blobs
- Append blob
  - optimized for append operations
  - cannot update or delete existing blocks
  - Up to 4 MB per block
  - Up to 195 GB

### Storage tiers
- Hot
  - frequent access
  - low latency
  - high-performance media (SSDs?)
- Cool
  - infrequent access
  - cheaper storage than hot, more expensive access
  - lower performance
- Archive
  - rare access
  - cheapest storage, most expensive access
  - high latency, offline storage.
  - access can take hours
  - to read, a blob must be first moved to Hot or Cool
- Can create lifecycle management policies

## DataLake Storage Gen2
- Used for big data analytics
- all types of structured, semi-structured, and unstructured data
- part of Azure Blob Storage
- Mounting point for distributed file systems
- Need to enable **Hierarchical Namespace** in Storage Account
  - Can upgrade from flat namespace
  - CANNOT downgrade to flat namespace

## Azure Files
- cloud-based NAS
- up to 100 TB / Storage Account
  - can set quotas on file shares
- File size up to 1 TB
- upload via portal or azcopy
- two performance tiers
  - standard: HDD
  - premium: SSD
- two file sharing protocols
  - Server Message Block (SMB): Window, Linus, MacOS
  - Network File System (NFS): Linux, MacOS
    - Only for premium tier
    - requires virtual network

## Azure Tables
- NoSQL, k-v pairs
- Items are stored in rows
  - each row has unique key (partition key + row key)
  - timestamp for last modification
  - other columns can vary row-by-row
- usually denormalized
- partitioned on common property or partition key
  - partitions are independent
  - can filter on partition key to skip data reading
- rows are stored in order of row key (log random access and range queries)