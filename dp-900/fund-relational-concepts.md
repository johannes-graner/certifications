# Fundamental Relational Concepts
- One common database structure

## Relational data
- Based on tables
- Each row is an **entity**
- Strict schema, every row in a table have the same columns
  - columns can be null
  - columns are typed

## Normalization
- Simple definition:
  1. Each entity type gets its own table
  2. Each attribute gets its own column
  3. Each entity (row) is uniquely identified using a primary key
  4. Foreign keys link related entities in other tables
- Removes duplication of data
- Enforces data types (e.g. decimal prices, integral quantities)
- Primary keys can be composite, i.e. unique combinations of multiple columns.

## SQL
- Open standard, many vendors have proprietary extensions
- Dialect examples:
  - Transact-SQL (T-SQL): Microsoft SQL Server, Azure SQL. Allows writing application code to DB
  - pgSQL: PostgreSQL
  - Procedural Language/SQL (PL/SQL): Oracle
- Statement types:
  - Data Definition Language (DDL)
    - Create, modify, remove tables
    - CREATE, ALTER, DROP, RENAME
  - Data Control Language (DCL)
    - DB admins use DCL to manage permissions
    - GRANT, DENY, REVOKE
  - Data Manipulation Language (DML)
    - Manipulate rows, query, insert etc.
    - SELECT, INSERT, UPDATE, DELETE, WHERE

## Describe DB objects
- Views: virtual tables based on SELECT query
- Stored procedure: function in SQL
- Index: optimize queries that filter on index column
  - Makes reading fast, writing is slowed