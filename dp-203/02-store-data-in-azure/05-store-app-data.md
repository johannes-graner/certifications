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