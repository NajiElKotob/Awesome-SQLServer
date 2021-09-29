# Awesome SQL Server

{Awesome Works in Progress}

`
Microsoft SQL Server is a relational database management system (RDBMS) that supports a wide variety of transaction processing, business intelligence and analytics applications in corporate IT environments. [TechTarget]
`


* [Tools](#tools)
* [Installation](#installation)
* [Administration](#administration)
* [Querying](#querying)
* [Database Design](#database-design)
* [Development](#development)


## Books
* [Introducing Microsoft SQL Server 2019](https://clouddamcdnprodep.azureedge.net/gdc/gdcJivzXl/original) - Packt


## Technical white papers
* [Microsoft SQL Server 2019](https://go.microsoft.com/fwlink/p/?linkid=2166197)

## YouTube :tv:
* [Kendra Little](https://www.youtube.com/channel/UCrJ8WLrVoKxL94mKv2akxTA)

-----
## Tools

### Database Tools
* [SQL Server Management Studio](https://docs.microsoft.com/en-us/sql/ssms/download-sql-server-management-studio-ssms)
    * [Course: SSMS Shortcuts and Secrets](https://www.youtube.com/watch?v=h04qEu8vJYc&list=PLoM-GGCV9ZrKqqR2fhxuy-oKookinG4nx) - Kendra Little
* [Azure Data Studio](https://docs.microsoft.com/en-us/sql/azure-data-studio/what-is)
    * [The A to S of Azure Data Studio :tv:](https://www.youtube.com/watch?v=F0bIBFuH93c) 
* [Visual Studio Code](https://code.visualstudio.com/) - Free. Built on open source. Runs everywhere.


-----
## Installation
* [SQL Server Developer](https://www.microsoft.com/en-us/sql-server/sql-server-downloads)


-----
## Administration

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

## Database Design
* [9 reasons why there are no foreign keys constraints in your database](https://dataedo.com/blog/why-there-are-no-foreign-keys-in-your-database-referential-integrity-checks) - Piotr Kononow
* [What is Entity Relationship Diagram (ERD)](https://www.visual-paradigm.com/guide/data-modeling/what-is-entity-relationship-diagram/)

### Documentation
* [Database documentation tools](https://dbmstools.com/categories/database-documentation-tools/sqlserver?commercial=Free) - DBMSTools.com


-----

## Querying
* [Intro to SQL](https://github.com/datacamp/courses-introduction-to-sql) - DataCamp
  - [Venkatramani Rajgopal](https://venkat-rajgopal.github.io/Essential-SQL/)
* [SQL all kinds of join queries](https://huklee.github.io/2017/01/28/021.SQL-all-kinds-of-join-queries/)
* [Subqueries (Derived Table)](https://docs.microsoft.com/en-us/sql/relational-databases/performance/subqueries)
* [Learn SQL Cookbook](https://learnsql.com/cookbook/) - learnsql.com
  - [Window Functions vs. GROUP BY](https://learnsql.com/blog/sql-window-functions-vs-group-by/)
  - [SQL Window Functions Cheat Sheet](https://learnsql.com/blog/sql-window-functions-cheat-sheet/) 
* [Date and Time](https://docs.microsoft.com/en-us/sql/t-sql/functions/date-and-time-data-types-and-functions-transact-sql)
  - [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) 
  - [GETDATE](https://docs.microsoft.com/en-us/sql/t-sql/functions/getdate-transact-sql), [GETUTCDATE](https://docs.microsoft.com/en-us/sql/t-sql/functions/getutcdate-transact-sql)
  - [YEAR](https://docs.microsoft.com/en-us/sql/t-sql/functions/year-transact-sql), [MONTH](https://docs.microsoft.com/en-us/sql/t-sql/functions/month-transact-sql), [DAY](https://docs.microsoft.com/en-us/sql/t-sql/functions/day-transact-sql)
  - [DATEPART](https://docs.microsoft.com/en-us/sql/t-sql/functions/datepart-transact-sql), [DATENAME](https://docs.microsoft.com/en-us/sql/t-sql/functions/datename-transact-sql)
  - [DATEADD](https://docs.microsoft.com/en-us/sql/t-sql/functions/dateadd-transact-sql), [DATEDIFF](https://docs.microsoft.com/en-us/sql/t-sql/functions/datediff-transact-sql)
  - [ISDATE](https://docs.microsoft.com/en-us/sql/t-sql/functions/isdate-transact-sql)
* [String](https://docs.microsoft.com/en-us/sql/t-sql/functions/string-functions-transact-sql)
  - [LEN](https://docs.microsoft.com/en-us/sql/t-sql/functions/len-transact-sql), [LEFT](https://docs.microsoft.com/en-us/sql/t-sql/functions/left-transact-sql), [RIGHT](https://docs.microsoft.com/en-us/sql/t-sql/functions/right-transact-sql)
  - [UPPER](https://docs.microsoft.com/en-us/sql/t-sql/functions/upper-transact-sql), [LOWER](https://docs.microsoft.com/en-us/sql/t-sql/functions/lower-transact-sql)
  - [CHARINDEX](https://docs.microsoft.com/en-us/sql/t-sql/functions/charindex-transact-sql), [PATINDEX](https://docs.microsoft.com/en-us/sql/t-sql/functions/patindex-transact-sql)
  - [STRING_AGG](https://docs.microsoft.com/en-us/sql/t-sql/functions/string-agg-transact-sql), [STRING_SPLIT](https://docs.microsoft.com/en-us/sql/t-sql/functions/string-split-transact-sql)
* [Aggregate](https://docs.microsoft.com/en-us/sql/t-sql/functions/aggregate-functions-transact-sql)
  - Statistical aggregate functions
    - [SUM](https://docs.microsoft.com/en-us/sql/t-sql/functions/sum-transact-sql), [COUNT](https://docs.microsoft.com/en-us/sql/t-sql/functions/count-transact-sql), MIN, and MAX
    - [AVG](https://docs.microsoft.com/en-us/sql/t-sql/functions/avg-transact-sql),VAR, VARP, [STDEV](https://docs.microsoft.com/en-us/sql/t-sql/functions/stdev-transact-sql) and STDEVP
* [Analytic Functions](https://docs.microsoft.com/en-us/sql/t-sql/functions/analytic-functions-transact-sql)
  - [LAG](https://docs.microsoft.com/en-us/sql/t-sql/functions/lag-transact-sql), [LEAD](https://docs.microsoft.com/en-us/sql/t-sql/functions/lead-transact-sql)
### YouTube :tv:
* [SQL Server Queries](https://www.youtube.com/watch?v=2-1XQHAgDsM&list=PL6EDEB03D20332309) - WiseOwlTutorials
* [Querying with Transact-SQL (Channel 9)](https://channel9.msdn.com/Series/Querying-with-Transact-SQL)
* [Like (Advanced) ~11min](https://www.youtube.com/watch?v=d-fnQtWdiW4) - Database by Doug
### Books
* [Learn T-SQL Querying (Free)](https://www.packtpub.com/free-ebook/learn-t-sql-querying/9781789348811) - Packt
### Learning
#### Get Started Querying with Transact-SQL
* [Get Started Querying with Transact-SQL (Path)](https://docs.microsoft.com/en-us/learn/paths/get-started-querying-with-transact-sql/) - Microsoft Learn
1. [Introduction to Transact-SQL](https://docs.microsoft.com/en-us/learn/modules/introduction-to-transact-sql/)
1. [Sort and filter results in T-SQL](https://docs.microsoft.com/en-us/learn/modules/sort-filter-queries/)
1. [Combine multiple tables with JOINs in T-SQL](https://docs.microsoft.com/en-us/learn/modules/query-multiple-tables-with-joins/)
1. [Write Subqueries in T-SQL](https://docs.microsoft.com/en-us/learn/paths/get-started-querying-with-transact-sql/)
1. [Use built-in functions and GROUP BY in Transact-SQL](https://docs.microsoft.com/en-us/learn/modules/use-built-functions-transact-sql/)
1. [Modify data with T-SQL](https://docs.microsoft.com/en-us/learn/modules/modify-data-with-transact-sql/)

#### Microsoft Learning
* [DP-080T00: Querying Data with Microsoft Transact-SQL](https://github.com/MicrosoftLearning/dp-080-Transact-SQL)
* [Querying with Transact-SQL](https://github.com/MicrosoftLearning/QueryingT-SQL)

#### Educational SQL resources
* [Educational SQL resources](https://docs.microsoft.com/en-us/sql/sql-server/educational-sql-resources) - Tutorials, quickstarts, and other educational resources meant to teach you to work with SQL Server and Azure SQL Database.

#### SoloLearn
* [SQL](https://www.sololearn.com/learning/1060) - sololearn.com

#### Quizzes
* [SQL Quiz](https://www.w3schools.com/quiztest/quiztest.asp?qtest=SQL) - w3schools.com

-----
## Development

### Vidoes
* [SQL Server - Procedures and Programming](https://www.youtube.com/playlist?list=PLNIs-AWhQzcleQWADpUgriRxebMkMmi4H) - WiseOwlTutorials


### Microsoft Learning
* [Get Started Querying with Transact-SQL](https://docs.microsoft.com/en-us/learn/paths/get-started-querying-with-transact-sql/)
* [Program with Transact-SQL](https://docs.microsoft.com/en-us/learn/paths/program-transact-sql/)
* [Write advanced Transact-SQL queries](https://docs.microsoft.com/en-us/learn/paths/write-advanced-transact-sql-queries/)
* [Optimize query performance in SQL Server](https://docs.microsoft.com/en-us/learn/paths/optimize-query-performance-sql-server/)

### Edx
* [Developing SQL Databases (Microsoft DAT215.1x)](https://learning.edx.org/course/course-v1:Microsoft+DAT215.1x+3T2018/home)

