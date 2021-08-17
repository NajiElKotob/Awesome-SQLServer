# Awesome SQL Server

{Work in Process}

* [Tools](#tools)
* [Administration](#administration)
* [Querying](#querying)


-----
## Tools

### Database Tools
* [SQL Server Management Studio](https://docs.microsoft.com/en-us/sql/ssms/download-sql-server-management-studio-ssms)
* [Azure Data Studio](https://docs.microsoft.com/en-us/sql/azure-data-studio/what-is)
    * [The A to S of Azure Data Studio :tv:](https://www.youtube.com/watch?v=F0bIBFuH93c) 
* [Visual Studio Code](https://code.visualstudio.com/) - Free. Built on open source. Runs everywhere.

### Documentation
* [Database documentation tools](https://dbmstools.com/categories/database-documentation-tools/sqlserver?commercial=Free) - DBMSTools.com

-----
## Installation
* [SQL Server Developer](https://www.microsoft.com/en-us/sql-server/sql-server-downloads)


-----

## Database Design
* [9 reasons why there are no foreign keys constraints in your database](https://dataedo.com/blog/why-there-are-no-foreign-keys-in-your-database-referential-integrity-checks) - Piotr Kononow
* [What is Entity Relationship Diagram (ERD)](https://www.visual-paradigm.com/guide/data-modeling/what-is-entity-relationship-diagram/)

-----
## Development

-----
## Administration


### Books
* [Introducing Microsoft SQL Server 2019](https://clouddamcdnprodep.azureedge.net/gdc/gdcJivzXl/original) - Packt

### Articles and Videos
#### Architecture
* [Understanding Memory with SQL Server and Azure SQL](https://www.youtube.com/watch?v=CRAx73LiXTc) (Bob Ward, June 2020)


#### Tuning


#### Security
* [Security Considerations for a SQL Server Installation](https://docs.microsoft.com/en-us/sql/sql-server/install/security-considerations-for-a-sql-server-installation)
* [Transparent Data Encryption (TDE)](https://www.red-gate.com/simple-talk/sql/sql-development/encrypting-sql-server-transparent-data-encryption-tde/) 

#### Backup
[Understanding SQL Server Backup Types](https://www.sqlshack.com/understanding-sql-server-backup-types/) (Prashanth Jayaram, April 2018)

#### Audit
* [SQL Server Auditing Best Practices](https://www.sqlshack.com/sql-server-auditing-best-practices/) (sqlshack.com, May 2019) - Goal, Scope, Tools, Audit Data, Audit Role, Audit for Audit, Archiving and more.


#### Troubleshooting
* [Connect to SQL Server when system administrators are locked out](https://docs.microsoft.com/en-us/sql/database-engine/configure-windows/connect-to-sql-server-when-system-administrators-are-locked-out)
* Service Packs (SP), Cumulative Updates (CU), patches and hotfixes
  - [Microsoft SQL Server Versions List](https://sqlserverbuilds.blogspot.com/) - This unofficial build chart lists all of the known Service Packs (SP), Cumulative Updates (CU), patches and hotfixes.
  - [How do I find SQL Server version?](https://sqlserverbuilds.blogspot.com/2019/01/how-do-i-find-sql-server-version.html)

-----

## Querying
* [Get Started Querying with Transact-SQL](https://docs.microsoft.com/en-us/learn/paths/get-started-querying-with-transact-sql/) - Microsoft Learn
* [Intro to SQL](https://github.com/datacamp/courses-introduction-to-sql) - DataCamp
  - [Venkatramani Rajgopal](https://venkat-rajgopal.github.io/Essential-SQL/)
* [SQL all kinds of join queries](https://huklee.github.io/2017/01/28/021.SQL-all-kinds-of-join-queries/)
* [Subqueries (Derived Table)](https://docs.microsoft.com/en-us/sql/relational-databases/performance/subqueries)
* [Learn SQL Cookbook](https://learnsql.com/cookbook/) - learnsql.com
  - [Window Functions vs. GROUP BY](https://learnsql.com/blog/sql-window-functions-vs-group-by/)
  - [SQL Window Functions Cheat Sheet](https://learnsql.com/blog/sql-window-functions-cheat-sheet/) 
* Date and Time
  - [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) 
  - [GETDATE](https://docs.microsoft.com/en-us/sql/t-sql/functions/getdate-transact-sql), [GETUTCDATE](https://docs.microsoft.com/en-us/sql/t-sql/functions/getutcdate-transact-sql)
  - YEAR, MONTH, DAY
  - DATEPART, DATENAME
  - DATEADD, DATEDIFF
  - ISDATE
* [String](https://docs.microsoft.com/en-us/sql/t-sql/functions/string-functions-transact-sql)
  - [LEN](https://docs.microsoft.com/en-us/sql/t-sql/functions/len-transact-sql), LEFT, RIGHT
  - [UPPER](https://docs.microsoft.com/en-us/sql/t-sql/functions/upper-transact-sql), LOWER
  - [CHARINDEX](https://docs.microsoft.com/en-us/sql/t-sql/functions/charindex-transact-sql), PATINDEX
  - STRING_AGG, STRING_SPLIT
* Numeric
  - Statistical aggregate functions
    - [SUM()](https://docs.microsoft.com/en-us/sql/t-sql/functions/sum-transact-sql), COUNT(), MIN(), and MAX()
    - AVG(),VAR(), VARP(), STDEV() and STDEVP()
* [Analytic Functions](https://docs.microsoft.com/en-us/sql/t-sql/functions/analytic-functions-transact-sql)
  - [LAG](https://docs.microsoft.com/en-us/sql/t-sql/functions/lag-transact-sql), [LEAD](https://docs.microsoft.com/en-us/sql/t-sql/functions/lead-transact-sql)
### YouTube :tv:
* [SQL Server Queries](https://www.youtube.com/watch?v=2-1XQHAgDsM&list=PL6EDEB03D20332309) - WiseOwlTutorials
* [Querying with Transact-SQL (Channel 9)](https://channel9.msdn.com/Series/Querying-with-Transact-SQL)
### Books
* [Learn T-SQL Querying](https://www.packtpub.com/free-ebook/learn-t-sql-querying/9781789348811) - Packt
### Learning
#### Get Started Querying with Transact-SQL
* [Introduction to Transact-SQL](https://docs.microsoft.com/en-us/learn/modules/introduction-to-transact-sql/)
* [Sort and filter results in T-SQL](https://docs.microsoft.com/en-us/learn/modules/sort-filter-queries/)
* [Combine multiple tables with JOINs in T-SQL](https://docs.microsoft.com/en-us/learn/modules/query-multiple-tables-with-joins/)
* [Write Subqueries in T-SQL](https://docs.microsoft.com/en-us/learn/paths/get-started-querying-with-transact-sql/)
* [Use built-in functions and GROUP BY in Transact-SQL](https://docs.microsoft.com/en-us/learn/modules/use-built-functions-transact-sql/)
* [Modify data with T-SQL](https://docs.microsoft.com/en-us/learn/modules/modify-data-with-transact-sql/)

### Educational SQL resources
* [Educational SQL resources](https://docs.microsoft.com/en-us/sql/sql-server/educational-sql-resources) - Tutorials, quickstarts, and other educational resources meant to teach you to work with SQL Server and Azure SQL Database.
