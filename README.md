SQL Queries Project

A repository containing SQL queries for the AdventureWork2019 database. This repository covers a collection of SQL queries used to analyze data from the database, covering various aspect such as sales, inventory and customer information

Table of Contents
- Introduction
- Usage
- Queries
- Contributing

Introduction
AdventureWorks is a sample database provided by Microsoft, which is used to demonstrate features of SQL Server. The AdventureWorks 2019 database includes data about a fictitious, multinational manufacturing company. This repository provides various SQL queries that can be used to explore and analyze this database.
Usage

Once you have set up the AdventureWorks 2019 database, you can start executing the SQL queries.

1. Connect to your SQL Server:
Use SQL Server Management Studio (SSMS) or any other SQL client tool.
    - Connect to your SQL Server instance where the AdventureWorks 2019 database is installed.
2. Run the queries:
    - Open the sql files in your SQL client tool.
    - Execute the queries to perform various data retrieval and analysis tasks.
Queries
This repository includes a variety of SQL queries, such as:
- Basic having Queries:
    - Retrieve all products where the sum is greater than a certain quantity
- *Where Queries:*
    - Filter sales data by date, price greater than a certain amount 
- Order By Queries:
    - Sort products by order date
   -case when Queries 
- filter sales where price greater than 500 as expensive else affordable 
- Join Queries:
    - Join products with categories
    - Retrieve sales data with customer details
- Common Table Expressions (CTEs):
    - Recursive queries for organizational hierarchy
    - CTEs for complex data transformations

Each query is documented with comments to explain its purpose and functionality.

We hope you find these SQL queries useful for exploring the AdventureWorks 2019 database. 

Happy querying!
