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