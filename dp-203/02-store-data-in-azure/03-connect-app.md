# Connect an app to Azure Storage
<https://docs.microsoft.com/en-us/learn/modules/connect-an-app-to-azure-storage/>
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