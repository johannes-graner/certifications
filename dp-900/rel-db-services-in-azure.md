# Azure SQL Services and Capabilities
- SQL Server on VMs: IaaS
  - Good for moving on-prem SQL Server to Azure
- SQL Managed Instance: PaaS
  - Automated software updates, backups, maintenance
- SQL DB: PaaS
  - Good when creating new application in the cloud
  - One server that scales vertically
  - Single Database: one database per server
  - Elastic Pool: several databases per server, good for uneven loads
- SQL Edge: for IoT
  - streaming time-series data

| |SQL Server on Azure VMs|Azure SQL Managed Instance	Azure|SQL Database|
|--|--|--|--|
Type of cloud service|	IaaS|	PaaS|	PaaS
SQL Server compatibility|	Fully compatible with on-prem|	Near-100% compatibility with SQL Server. Most on-premises databases can be migrated with minimal code changes by using the Azure Database Migration service|	Supports most core database-level capabilities of SQL Server. Some features depended on by an on-premises application may not be available.
Architecture|	SQL Server instances are installed in a virtual machine. Each instance can support multiple databases.|	Each managed instance can support multiple databases. Additionally, instance pools can be used to share resources efficiently across smaller instances.|	You can provision a single database in a dedicated, managed (logical) server; or you can use an elastic pool to share resources across multiple databases and take advantage of on-demand scalability.
Availability|	99.99%|	99.99%|	99.995%
Management|	You must manage all aspects of the server, including operating system and SQL Server updates, configuration, backups, and other maintenance tasks.|	Fully automated updates, backups, and recovery.|	Fully automated updates, backups, and recovery.
Use cases|	Use this option when you need to migrate or extend an on-premises SQL Server solution and retain full control over all aspects of server and database configuration.|	Use this option for most cloud migration scenarios, particularly when you need minimal changes to existing applications.|	Use this option for new cloud solutions, or to migrate applications that have minimal instance-level dependencies.
| Business benefits | Same as on-prem, but on cloud for easy scaling etc. | Less admin tasks/time. Login with Azure AD | Very little admin. Scalable. High availability. Security. Encryption.

## Azure services for open-source DBs
- MySQL:
  - free Community edition, more powerful Standard and Enterprise editions
- MariaDB: 
  - created by creators of MySQL.
  - Built-in support for Oracle and temporal data.
  - Tables can be versioned.
- PostgreSQL
  - hybrid relational-object DB
  - geometric data (lines, circles, polygons)
  - pgsql is a variant of standard SQL

### Azure DB
- MySQL
  - Based on community edition
  - firewalls etc
  - easy scaling
  - cannot do security and admin, managed by Azure
  - new projects should use flexible server
  - auto backups
  - Good compatibility with LAMP (Linux, Apache, MySQL, PHP)
- MariaDB
  - Based on community edition
  - easy scaling
  - fully managed
- PostgreSQL
  - Same services as MySQL
  - cannot perform specialized tasks, e.g. storing non-pgsql procedures or direct OS operations
  - Most common extensions are supported, more are added over time
  - single server, flexible server or hyperscale
    - choose tier for single server
    - flexible server is fully managed
    - hyperscale scales horizontally
    - for big data
  - failure detection
  - pgAdmin tool for DB management