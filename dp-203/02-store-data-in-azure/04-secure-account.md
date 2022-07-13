# Secure you Azure Storage Account
<https://docs.microsoft.com/en-us/learn/modules/secure-azure-storage-account/>
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