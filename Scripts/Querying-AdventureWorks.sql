/*
______          ______               _        
|  _  \         | ___ \             | |       
| | | |_____   _| |_/ /___  __ _  __| |_   _  
| | | / _ \ \ / /    // _ \/ _` |/ _` | | | | 
| |/ /  __/\ V /| |\ \  __/ (_| | (_| | |_| | 
|___/ \___| \_/ \_| \_\___|\__,_|\__,_|\__, | 
                                        __/ | 
                                       |___/  
*/

-- T-SQL Querying (AdventureWorks)
-- version 3.9.25 - July 2019 by Naji El Kotob

-- ========================
-- sp_*
-- ========================

-- Reports information about a specified database or all databases.
-- https://docs.microsoft.com/en-us/sql/relational-databases/system-stored-procedures/sp-helpdb-transact-sql
sp_helpdb 

-- Displays the definition of an object
-- https://docs.microsoft.com/en-us/sql/relational-databases/system-stored-procedures/sp-helptext-transact-sql
exec sp_helptext 'sp_helpdb';

-- Reports information about locks.
-- https://docs.microsoft.com/en-us/sql/relational-databases/system-stored-procedures/sp-lock-transact-sql
sp_lock

-- Using sp_datatype_info to get the data type of a variable
-- https://docs.microsoft.com/en-us/sql/relational-databases/system-stored-procedures/sp-datatype-info-transact-sql
sp_datatype_info

-- sp_who: Provides information about current users, sessions, and processes in an instance of the Microsoft SQL Server Database Engine. 
-- https://docs.microsoft.com/en-us/sql/relational-databases/system-stored-procedures/sp-who-transact-sql
EXEC sp_who
EXEC sp_who 'active'
EXEC sp_who2



-- ========================================================================================
-- DBCC 
-- https://docs.microsoft.com/en-us/sql/t-sql/database-console-commands/dbcc-transact-sql
-- =========================================================================================



-- Provides transaction log space usage statistics for all databases.
-- https://docs.microsoft.com/en-us/sql/t-sql/database-console-commands/dbcc-sqlperf-transact-sql
DBCC SQLPERF (LOGSPACE)


-- Returns the SET options active (set) for the current connection.
-- https://docs.microsoft.com/en-us/sql/t-sql/database-console-commands/dbcc-useroptions-transact-sql
DBCC USEROPTIONS
-- |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||


-- ========================
-- System Catalog Views 
-- ========================

-- https://docs.microsoft.com/en-us/sql/relational-databases/system-catalog-views/catalog-views-transact-sql
/*
Catalog views return information that is used BY the SQL Server Database Engine. 
We recommend that you use catalog views because they are the most general interface 
to the catalog metadata and provide the most efficient way to obtain, transform, 
and present customized forms of this information. All user-available catalog 
metadata is exposed through catalog views.
*/
SELECT name, user_access_desc, is_read_only, state_desc, recovery_model_desc  
FROM sys.databases;  



-- ========================
-- SELECT
-- ========================

USE AdventureWorks
GO

SELECT * From Sales.vSalesPerson

SELECT FirstName + ' ' + LastName As FullName, SalesLastYear
FROM Sales.vSalesPerson
WHERE SalesLastYear > 1900000


SELECT * FROM Production.Product WHERE Name LIKE '%cran%'
SELECT * FROM Production.Product WHERE Color IN ('Black','Red')


--SELECT * FROM Sales.SalesOrderHeader
--SELECT Distinct SalesPersonID From Sales.SalesOrderHeader

SELECT SalesPersonID,  AVG(TotalDue) AS Average, SUM(TotalDue) AS Total, COUNT(*) AS NumberOfOrders ,
CASE
	WHEN COUNT(*) >= 400 THEN 'High'
	WHEN COUNT(*) >= 300 THEN 'Medium'
	ELSE 'Low'
END AS Level
FROM Sales.SalesOrderHeader
WHERE SalesPersonID IS NOT NULL  
GROUP BY SalesPersonID
-- HAVING COUNT(*) > 400
ORDER BY Total DESC


SELECT SubTotal + TaxAmt + Freight AS TotalDue, TotalDue FROM Sales.SalesOrderHeader


SELECT  COUNT(*) AS COUNT, Count(SalesPersonID)
FROM Sales.SalesOrderHeader


SELECT SalesPersonID, OrderDate AS OrderYear, COUNT(*) AS COUNT, Count(SalesPersonID) AS CountPerSalesPersonID
FROM Sales.SalesOrderHeader
--WHERE SalesPersonID IS NOT NULL
GROUP BY SalesPersonID, OrderDate
HAVING COUNT(*) > 20
ORDER BY SalesPersonID, OrderYear


-- Set Operators
-- https://docs.microsoft.com/en-us/sql/t-sql/language-elements/set-operators-except-and-intersect-transact-sql?view=sql-server-2017



-- AND, OR, NOT
/*
https://docs.microsoft.com/en-us/sql/t-sql/language-elements/operator-precedence-transact-sql
https://www.w3schools.com/sql/sql_and_or.asp
https://www.techonthenet.com/sql/not.php
*/
DECLARE @val1 int = 1, @val2 int = 2, @val3 int = 3;
SELECT @val1, @val2, @val3 
WHERE
@val1 = 1 AND @val2 = 0 OR NOT @val3 = 2


--	=============
--	EXISTS
--	=============
-- https://docs.microsoft.com/en-us/sql/t-sql/language-elements/exists-transact-sql
-- http://searchsqlserver.techtarget.com/answer/Delete-FROM-table-A-if-matching-row-exists-in-B

CREATE TABLE #tmpTableA 
(Id int Identity NOT NULL,
Name varchar(10) NOT NULL)

CREATE TABLE #tmpTableB
(Id int Identity NOT NULL,
Name varchar(10) NOT NULL)


TRUNCATE TABLE #tmpTableA
TRUNCATE TABLE #tmpTableB

DECLARE @count int = 0

WHILE @count < 10
BEGIN
INSERT INTO #tmpTableA (Name) VALUES ('A' + CAST(@count AS varchar(10)));
SET @count += 1;
IF @count > 3 CONTINUE
INSERT INTO #tmpTableB (Name) VALUES ('B' + CAST(@count AS varchar(10)));
END;


SELECT * FROM #tmpTableA;
SELECT * FROM #tmpTableB;

DELETE FROM #tmpTableA WHERE EXISTS
       (SELECT * FROM #tmpTableB B WHERE B.Id = #tmpTableA.Id); 


-- Uses AdventureWorks  
-- The following example shows queries to find employees of departments that start with P.
SELECT p.FirstName, p.LastName, e.JobTitle  
FROM Person.Person AS p   
JOIN HumanResources.Employee AS e  
   ON e.BusinessEntityID = p.BusinessEntityID   
WHERE EXISTS  
(SELECT *  
    FROM HumanResources.Department AS d  
    JOIN HumanResources.EmployeeDepartmentHistory AS edh  
       ON d.DepartmentID = edh.DepartmentID  
    WHERE e.BusinessEntityID = edh.BusinessEntityID  
    AND d.Name LIKE 'P%');  
GO 

/*
=== Code Under Review ===
Each AdventureWorks customer is a retail company with a named contact. 
Create queries that return the total revenue for each customer, 
including the company and customer contact names.

SELECT CompanyContact, SUM(SalesAmount) AS Revenue
FROM
	(SELECT CONCAT (C.CompanyName, CONCAT (' (' + c.FirstName + ' ', c.LastName + ')')) AS CompanyContact, SOH.TotalDue
	 FROM Sales.SalesOrderHeader AS SOH
	 JOIN Sales.Customer AS C
	 ON SOH.CustomerID = C.CustomerID) AS CustomerSales(CompanyContact, SalesAmount)
GROUP BY CompanyContact
ORDER BY CompanyContact;

-- Result
The total of the first 3 rows = the total of the last 3 rows = the Null/Null row
SalesPersonID	CustomerID	TotalAmount
NULL	30116	211671.2674
NULL	30117	919801.8188
NULL	30118	313671.5352
NULL	NULL	1445144.6214
275		NULL	755382.7754
276		NULL	211671.2674
277		NULL	478090.5786
*/


SELECT TOP(10) PERCENT * FROM Sales.SalesOrderDetail
ORDER BY LineTotal DESC

--OFFSET and FETCH
--OFFSET <EXPR1> ROWS, which you use to specify the line number FROM which to start retrieving results
--FETCH NEXT <EXPR2> ROWS ONLY, which you use to specify how many lines to
SELECT  ROW_NUMBER() OVER(ORDER BY P.ProductID) AS RowNumber, *
FROM Production.Product AS P
ORDER BY RowNumber
OFFSET 10 ROWS
FETCH NEXT 20 ROWS ONLY



-- Ranking Functions
-- https://docs.microsoft.com/en-us/sql/t-sql/functions/ranking-functions-transact-sql
SELECT p.FirstName, p.LastName  
    ,ROW_NUMBER() OVER (ORDER BY a.PostalCode) AS "Row Number"  
    ,RANK() OVER (ORDER BY a.PostalCode) AS Rank  
    ,DENSE_RANK() OVER (ORDER BY a.PostalCode) AS "Dense Rank"  
    ,NTILE(4) OVER (ORDER BY a.PostalCode) AS Quartile  
    ,s.SalesYTD
    ,a.PostalCode  
FROM Sales.SalesPerson AS s   
    INNER JOIN Person.Person AS p   
        ON s.BusinessEntityID = p.BusinessEntityID  
    INNER JOIN Person.Address AS a   
        ON a.AddressID = p.BusinessEntityID  
WHERE TerritoryID IS NOT NULL AND SalesYTD <> 0;  


SELECT p.FirstName, p.LastName  
    ,ROW_NUMBER() OVER (ORDER BY (ROUND(s.SalesYTD, -6)/1000000) DESC) AS "Row Number"  
    ,RANK() OVER (ORDER BY (ROUND(s.SalesYTD, -6)/1000000) DESC) AS Rank  
    ,DENSE_RANK() OVER (ORDER BY (ROUND(s.SalesYTD, -6)/1000000) DESC) AS "Dense Rank"  
    ,NTILE(4) OVER (ORDER BY (ROUND(s.SalesYTD, -6)/1000000) DESC) AS Quartile  
    ,s.SalesYTD, (ROUND(s.SalesYTD, -6)/1000000) SalesYTDMillion 
FROM Sales.SalesPerson AS s   
    INNER JOIN Person.Person AS p   
        ON s.BusinessEntityID = p.BusinessEntityID  
    INNER JOIN Person.Address AS a   
        ON a.AddressID = p.BusinessEntityID  
WHERE TerritoryID IS NOT NULL AND SalesYTD <> 0; 


-- CTE (Common Table Expression)
WITH OrderedOrders AS  
(  
    SELECT SalesOrderID, OrderDate,  
    ROW_NUMBER() OVER (ORDER BY OrderDate) AS RowNumber  
    FROM Sales.SalesOrderHeader   
)   
SELECT SalesOrderID, OrderDate, RowNumber    
FROM OrderedOrders   
WHERE RowNumber BETWEEN 50 AND 60


-- FUNCTIONS ================
-- ==========================

-- Date and Time functions

SELECT GETDATE(), GETUTCDATE();

SELECT DATENAME(year, GETDATE()) as Year,
       DATENAME(week, GETDATE()) as Week,
       DATENAME(dayofyear, GETDATE()) as DayOfYear,
       DATENAME(month, GETDATE()) as Month,
       DATENAME(day, GETDATE()) as Day,
       DATENAME(weekday, GETDATE()) as Weekday


SELECT   NationalIDNumber,
         HireDate,
         DATEDIFF(year, HireDate, GETDATE()) YearsOfService
FROM     HumanResources.Employee
WHERE    DATEDIFF(year, HireDate, GETDATE()) >= 5
ORDER BY YearsOfService DESC


-- Tables ===================
-- ==========================

-- Table Variable
/*
=== Code Under Review === 
DECLARE @Colors AS TABLE (Color nvarchar(15));

INSERT INTO @Colors
SELECT DISTINCT Color FROM SalesLT.Product;

SELECT ProductID, Name, Color
FROM SalesLT.Product
WHERE Color IN (SELECT Color FROM @Colors);
*/

-- Union
-- https://technet.microsoft.com/en-us/library/ms187731(v=sql.110).aspx
USE AdventureWorks;
GO
IF OBJECT_ID ('dbo.EmployeeOne', 'U') IS NOT NULL
DROP TABLE dbo.EmployeeOne;
GO
IF OBJECT_ID ('dbo.EmployeeTwo', 'U') IS NOT NULL
DROP TABLE dbo.EmployeeTwo;
GO
IF OBJECT_ID ('dbo.EmployeeThree', 'U') IS NOT NULL
DROP TABLE dbo.EmployeeThree;
GO

SELECT pp.LastName, pp.FirstName, e.JobTitle 
INTO dbo.EmployeeOne
FROM Person.Person AS pp JOIN HumanResources.Employee AS e
ON e.BusinessEntityID = pp.BusinessEntityID
WHERE LastName = 'Johnson';
GO
SELECT pp.LastName, pp.FirstName, e.JobTitle 
INTO dbo.EmployeeTwo
FROM Person.Person AS pp JOIN HumanResources.Employee AS e
ON e.BusinessEntityID = pp.BusinessEntityID
WHERE LastName = 'Johnson';
GO
SELECT pp.LastName, pp.FirstName, e.JobTitle 
INTO dbo.EmployeeThree
FROM Person.Person AS pp JOIN HumanResources.Employee AS e
ON e.BusinessEntityID = pp.BusinessEntityID
WHERE LastName = 'Johnson';
GO

-- Union ALL
SELECT LastName, FirstName, JobTitle
FROM dbo.EmployeeOne
UNION ALL
SELECT LastName, FirstName ,JobTitle
FROM dbo.EmployeeTwo
UNION ALL
SELECT LastName, FirstName,JobTitle 
FROM dbo.EmployeeThree;
GO

SELECT LastName, FirstName,JobTitle
FROM dbo.EmployeeOne
UNION 
SELECT LastName, FirstName, JobTitle 
FROM dbo.EmployeeTwo
UNION 
SELECT LastName, FirstName, JobTitle 
FROM dbo.EmployeeThree;
GO

SELECT LastName, FirstName,JobTitle 
FROM dbo.EmployeeOne
UNION ALL
(
SELECT LastName, FirstName, JobTitle 
FROM dbo.EmployeeTwo
UNION
SELECT LastName, FirstName, JobTitle 
FROM dbo.EmployeeThree
);
GO







-- APPLY
-- https://www.simple-talk.com/sql/t-sql-programming/sql-server-apply-basics/
USE AdventureWorks
GO
IF OBJECT_ID (N'fn_sales', N'IF') IS NOT NULL
  DROP FUNCTION dbo.fn_sales
GO
CREATE FUNCTION fn_sales (@SalesPersonID int)
RETURNS TABLE
AS
RETURN
(
  SELECT TOP 3 
    SalesPersonID, 
    ROUND(TotalDue, 2) AS SalesAmount
  FROM 
    Sales.SalesOrderHeader
  WHERE 
    SalesPersonID = @SalesPersonID
  ORDER BY 
    TotalDue DESC
)
GO

SELECT SalesAmount FROM fn_sales(285)
SELECT sp.FirstName + ' ' + sp.LastName AS FullName FROM Sales.vSalesPerson AS sp
SELECT SalesPersonID, TotalDue FROM  Sales.SalesOrderHeader


SELECT 
  sp.FirstName + ' ' + sp.LastName AS FullName,
  fn.SalesAmount
FROM
  Sales.vSalesPerson AS sp
CROSS APPLY -- Similar to Inner Join 
  fn_sales(sp.BusinessEntityID) AS fn
ORDER BY
  sp.LastName, fn.SalesAmount DESC



-- CTE - Common Table Expressions
-- https://technet.microsoft.com/en-us/library/ms190766(v=sql.105).aspx
USE AdventureWorks;
GO
-- Define the CTE expression name and column list.
WITH Sales_CTE (SalesPersonID, SalesOrderID, SalesYear)
AS
-- Define the CTE query.
(
    SELECT SalesPersonID, SalesOrderID, YEAR(OrderDate) AS SalesYear
    FROM Sales.SalesOrderHeader
    WHERE SalesPersonID IS NOT NULL
)
-- Define the outer query referencing the CTE name.
SELECT SalesPersonID, COUNT(SalesOrderID) AS TotalSales, SalesYear
FROM Sales_CTE
GROUP BY SalesYear, SalesPersonID
ORDER BY SalesPersonID, SalesYear;
GO



-- https://sqlwithmanoj.com/tag/option-maxrecursion/
-- https://www.simple-talk.com/sql/t-sql-programming/sql-server-cte-basics/

DECLARE
    @startDate DATETIME,
    @endDate DATETIME
 
SET @startDate = '11/10/2011'
SET @endDate = '03/25/2012'
 
; WITH CTE AS (
    SELECT
        YEAR(@startDate) AS 'yr',
        MONTH(@startDate) AS 'mm',
        DATENAME(mm, @startDate) AS 'mon',
        DATEPART(d,@startDate) AS 'dd',
        @startDate 'new_date'
    UNION ALL
    SELECT
        YEAR(new_date) AS 'yr',
        MONTH(new_date) AS 'mm',
        DATENAME(mm, new_date) AS 'mon',
        DATEPART(d,@startDate) AS 'dd',
        DATEADD(d,1,new_date) 'new_date'
    FROM CTE
    WHERE new_date < @endDate
    )
SELECT yr AS 'Year', mon AS 'Month', count(dd) AS 'Days'
FROM CTE
GROUP BY mon, yr, mm
ORDER BY yr, mm
OPTION (MAXRECURSION 1000)


-- Rollup
USE AdventureWorksLT
GO
SELECT a.CountryRegion, a.StateProvince, SUM(soh.TotalDue) AS Revenue, COUNT(*) AS Num
FROM SalesLT.Address AS a
JOIN SalesLT.CustomerAddress AS ca 
ON a.AddressID = ca.AddressID
JOIN SalesLT.Customer AS c 
ON ca.CustomerID = c.CustomerID
JOIN SalesLT.SalesOrderHeader as soh 
ON c.CustomerID = soh.CustomerID
--GROUP BY a.CountryRegion, a.StateProvince
--GROUP BY GROUPING SETS (a.CountryRegion, a.StateProvince, ())
--GROUP BY ROLLUP(a.CountryRegion, a.StateProvince)
GROUP BY CUBE(a.CountryRegion, a.StateProvince)


SELECT GROUPING_ID(a.CountryRegion) AS CountryRegionLevel, 
GROUPING_ID(a.StateProvince) AS StateProvinceLevel, 
a.CountryRegion, a.StateProvince,
IIF(GROUPING_ID(a.CountryRegion) = 1 AND GROUPING_ID(a.StateProvince) = 1, 'Total', 
IIF(GROUPING_ID(a.StateProvince) = 1, a.CountryRegion + ' Subtotal', a.StateProvince + ' Subtotal')) AS Level,
SUM(soh.TotalDue) AS Revenue
FROM SalesLT.Address AS a
JOIN SalesLT.CustomerAddress AS ca
ON a.AddressID = ca.AddressID
JOIN SalesLT.Customer AS c
ON ca.CustomerID = c.CustomerID
JOIN SalesLT.SalesOrderHeader as soh
ON c.CustomerID = soh.CustomerID
GROUP BY ROLLUP(a.CountryRegion, a.StateProvince)
ORDER BY a.CountryRegion, a.StateProvince;


SELECT a.CountryRegion, a.StateProvince, a.City,
CHOOSE (1 + GROUPING_ID(a.CountryRegion) + GROUPING_ID(a.StateProvince) + GROUPING_ID(a.City),
        a.City + ' Subtotal', a.StateProvince + ' Subtotal',
        a.CountryRegion + ' Subtotal', 'Total') AS Level,
SUM(soh.TotalDue) AS Revenue
FROM SalesLT.Address AS a
JOIN SalesLT.CustomerAddress AS ca
ON a.AddressID = ca.AddressID
JOIN SalesLT.Customer AS c
ON ca.CustomerID = c.CustomerID
JOIN SalesLT.SalesOrderHeader as soh
ON c.CustomerID = soh.CustomerID
GROUP BY ROLLUP(a.CountryRegion, a.StateProvince, a.City)
ORDER BY a.CountryRegion, a.StateProvince, a.City;






-- Pivot
-- https://docs.microsoft.com/en-us/sql/t-sql/queries/FROM-using-pivot-and-unpivot


/*
SELECT * FROM Production.Product
SELECT * FROM Production.ProductSubCategory
*/
USE AdventureWorks
GO

SELECT DISTINCT Color FROM Production.Product


SELECT * FROM
(SELECT P.ProductID, PSC.Name,ISNULL(P.Color, 'Uncolored') AS Color
 FROM Production.ProductSubcategory AS PSC
 JOIN Production.Product AS P
 ON PSC.ProductCategoryID=P.ProductSubcategoryID
 ) AS PPSC
PIVOT(COUNT(ProductID) FOR Color IN([Red],[Blue],[Black],[Silver],[Yellow],[Grey], [Multi], [Uncolored])) as pvt
ORDER BY Name;



-- Unpivot
USE AdventureWorksLT
GO
CREATE TABLE #ProductColorPivot
(Name varchar(50), Red int, Blue int, Black int, Silver int, Yellow int, Grey int , multi int, uncolored int);

INSERT INTO #ProductColorPivot
SELECT * FROM
(SELECT P.ProductID, PC.Name,ISNULL(P.Color, 'Uncolored') AS Color
 FROM saleslt.productcategory AS PC
 JOIN SalesLT.Product AS P
 ON PC.ProductCategoryID=P.ProductCategoryID
 ) AS PPC
PIVOT(COUNT(ProductID) FOR Color IN([Red],[Blue],[Black],[Silver],[Yellow],[Grey], [Multi], [Uncolored])) as pvt
ORDER BY Name;

SELECT * FROM #ProductColorPivot


SELECT * -- Name, Color, ProductCount
FROM
(SELECT * -- Name, [Red],[Blue],[Black],[Silver],[Yellow],[Grey], [Multi], [Uncolored]
FROM #ProductColorPivot) pcp
UNPIVOT
(ProductCount FOR Color IN ([Red],[Blue],[Black],[Silver],[Yellow],[Grey], [Multi], [Uncolored])
) AS ProductCounts

DROP TABLE #ProductColorPivot


SELECT
  CustomerID,
  [2011] AS Y2011, [2012] AS Y2012, [2013] AS Y2013, [2014] AS Y2014
 FROM
 (
    SELECT CustomerID, DATEPART(yyyy, OrderDate) AS OrderYear, TotalDue
     FROM Sales.SalesOrderHeader
 ) AS piv
PIVOT
(
  SUM(TotalDue) FOR OrderYear IN([2011], [2012], [2013], [2014])
) AS child
ORDER BY CustomerID


USE AdventureWorksLT
GO

SELECT * FROM SalesLT.vGetAllCategories;

SELECT * FROM
(SELECT cust.CompanyName, cat.ParentProductCategoryName, sod.LineTotal
 FROM SalesLT.SalesOrderDetail AS sod
 JOIN SalesLT.SalesOrderHeader AS soh ON sod.SalesOrderID = soh.SalesOrderID
 JOIN SalesLT.Customer AS cust ON cust.CustomerID = soh.CustomerID
 JOIN SalesLT.Product AS prod ON prod.ProductID = sod.ProductID
 JOIN SalesLT.vGetAllCategories AS cat ON prod.ProductcategoryID = cat.ProductCategoryID) AS catsales
PIVOT (SUM(LineTotal) FOR ParentProductCategoryName
IN ([Accessories], [Bikes], [Clothing], [Components])) AS pivotedsales
ORDER BY CompanyName;



-- Unpivot



--Insert/Update/Delete

-- Finish the INSERT statement
DELETE FROM SalesLT.Product WHERE ProductID = 1000;
INSERT INTO SalesLT.Product (Name, ProductNumber, StandardCost, ListPrice, ProductCategoryID, SellStartDate)
VALUES
('LED Lights3', 'LT-L123b', 2.56, 12.99, 37, getdate());

-- Get last identity value that was inserted
SELECT SCOPE_IDENTITY();

-- Finish the SELECT statement
SELECT * FROM SalesLT.Product
WHERE ProductID = SCOPE_IDENTITY();


/*
IDENT_CURRENT (Transact-SQL)
Returns the last identity value generated for a specified table or view. The last identity value generated can be for any session and any scope.
https://docs.microsoft.com/en-us/sql/t-sql/functions/ident-current-transact-sql
*/

-- Insert product category
INSERT INTO SalesLT.ProductCategory (ParentProductCategoryID, Name)
VALUES
(4, 'Bells and Horns');

-- Insert 2 products
INSERT INTO SalesLT.Product (Name, ProductNumber, StandardCost, ListPrice, ProductCategoryID, SellStartDate)
VALUES
('Bicycle Bell', 'BB-RING', 2.47, 4.99, IDENT_CURRENT('SalesLT.ProductCategory'), GETDATE()),
('Bicycle Horn', 'BB-PARP', 1.29, 3.75, IDENT_CURRENT('SalesLT.ProductCategory'), GETDATE());

-- Check if products are properly inserted
SELECT c.Name As Category, p.Name AS Product
FROM SalesLT.Product AS p
JOIN SalesLT.ProductCategory as c ON p.ProductCategoryID = c.ProductCategoryID
WHERE p.ProductCategoryID = IDENT_CURRENT('SalesLT.ProductCategory');


-- Update the SalesLT.Product table
UPDATE SalesLT.Product
SET ListPrice = ListPrice * 1.1
WHERE ProductCategoryID =
  (SELECT ProductCategoryID FROM SalesLT.ProductCategory WHERE Name = 'Bells and Horns');

/*
https://docs.microsoft.com/en-us/sql/t-sql/statements/create-sequence-transact-sql
*/
-- Define a sequence
CREATE SEQUENCE dbo.CountBy1 AS INT START WITH 1 INCREMENT BY 1;

-- Retrieve next available value FROM sequence
SELECT NEXT VALUE FOR dbo.CountBy1;

SELECT * FROM sys.sequences -- WHERE name = 'CountBy1' ;  

ALTER SEQUENCE dbo.CountBy1 RESTART WITH 1 ;  

ALTER SEQUENCE dbo.CountBy1 
    RESTART WITH 5  
    INCREMENT BY 5  
    MINVALUE 5
    MAXVALUE 20  
    NO CYCLE  
    NO CACHE;


-- ===================
-- Programming
-- ===================
-- SELECT * FROM Production.Product
DECLARE @id int = 316;
DECLARE @name varchar(30);

WHILE @id < 325
BEGIN	
	SET @id = @id + 1;

	--IF @id = 320 
	--	break;

	--IF @id = 320 
	--	continue;

SELECT @name = Name FROM Production.Product WHERE ProductID = @id;
-- PRINT @id  + '    ' + @name; -- Conversion failed when converting the varchar value 'LL Crankarm' to data type int.

PRINT CAST(@id AS varchar(5)) + '    ' + @name;
END


-- Stored Procedure
-- https://docs.microsoft.com/en-us/sql/t-sql/statements/create-procedure-transact-sql
USE AdventureWorks
GO
-- DROP PROC uspGetProductsByCategory
ALTER PROC uspGetProductsByCategory (@SubcategoryID int = NULL)
WITH ENCRYPTION  
AS
BEGIN
IF @SubcategoryID IS NULL
	SELECT ProductID, ProductSubcategoryID, Name FROM Production.Product
ELSE
	SELECT ProductID, ProductSubcategoryID, Name FROM Production.Product WHERE ProductSubcategoryID = @SubcategoryID
END
-- Stored procedures can return rowsets (usually the results of a SELECT statement). 
-- They can also return output parameters, and they always return a return value, which is used to indicate status.
uspGetProductsByCategory
EXEC uspGetProductsByCategory
EXEC uspGetProductsByCategory 1
EXEC uspGetProductsByCategory @SubcategoryID = 1


--Functions
-- https://docs.microsoft.com/en-us/sql/relational-databases/user-defined-functions/create-user-defined-functions-database-engine

IF OBJECT_ID (N'dbo.ufnGetInventoryStock', N'FN') IS NOT NULL  
    DROP FUNCTION ufnGetInventoryStock;  
GO  
CREATE FUNCTION dbo.ufnGetInventoryStock(@ProductID int)  
RETURNS int   
AS   
-- Returns the stock level for the product.  
BEGIN  
    DECLARE @ret int;  
    SELECT @ret = SUM(p.Quantity)   
    FROM Production.ProductInventory p   
    WHERE p.ProductID = @ProductID   
        AND p.LocationID = '6';  
     IF (@ret IS NULL)   
        SET @ret = 0;  
    RETURN @ret;  
END;  
GO  

SELECT * FROM Production.ProductInventory WHERE LocationID = 6

SELECT dbo.ufnGetInventoryStock(2)

SELECT ProductModelID, Name, dbo.ufnGetInventoryStock(ProductID)AS CurrentSupply  
FROM Production.Product  
WHERE ProductModelID BETWEEN 75 and 80;  

--Alternative Subquery
SELECT ProductModelID, Name, (SELECT SUM(PrI.Quantity)   
    FROM Production.ProductInventory PrI 
    WHERE PrI.ProductID =  P.ProductID 
        AND PrI.LocationID = '6') AS CurrentSupply  
FROM Production.Product P
WHERE ProductModelID BETWEEN 75 and 80; 

-- Alternative Join
SELECT P.ProductModelID, P.Name,  SUM(PrI.Quantity) AS  CurrentSupply  
FROM Production.Product P
INNER JOIN Production.ProductInventory PrI 
ON P.ProductID = PrI.ProductID

WHERE (P.ProductModelID BETWEEN 75 AND 80)
AND PrI.LocationID = 6

GROUP BY P.ProductModelID, P.Name
HAVING SUM(PrI.Quantity) > 400; -- Having used to filter the group (Aggregate) result.


-- Table-Valued Functions
-- https://docs.microsoft.com/en-us/sql/relational-databases/user-defined-functions/create-user-defined-functions-database-engine
IF OBJECT_ID (N'Sales.ufn_SalesByStore', N'IF') IS NOT NULL  
    DROP FUNCTION Sales.ufn_SalesByStore;  
GO  
CREATE FUNCTION Sales.ufn_SalesByStore (@storeid int)  
RETURNS TABLE  
AS  
RETURN   
(  
    SELECT P.ProductID, P.Name, SUM(SD.LineTotal) AS 'Total'  
    FROM Production.Product AS P   
    JOIN Sales.SalesOrderDetail AS SD ON SD.ProductID = P.ProductID  
    JOIN Sales.SalesOrderHeader AS SH ON SH.SalesOrderID = SD.SalesOrderID  
    JOIN Sales.Customer AS C ON SH.CustomerID = C.CustomerID  
    WHERE C.StoreID = @storeid  
    GROUP BY P.ProductID, P.Name  
);

SELECT * FROM Sales.Customer
SELECT * FROM Sales.ufn_SalesByStore (602);  

-- Views
-- View is a stored query
CREATE VIEW vwProductsList
AS
	SELECT Name, ProductNumber, Color
	FROM     Production.Product
GO

SELECT * FROM vwProductsList



DECLARE @OrderDate datetime = GETDATE();
DECLARE @DueDate datetime = DATEADD(dd, 7, GETDATE());
DECLARE @CustomerID int = 1;
INSERT INTO SalesLT.SalesOrderHeader (OrderDate, DueDate, CustomerID, ShipMethod)
VALUES (@OrderDate, @DueDate, @CustomerID, 'CARGO TRANSPORT 5');
DECLARE @OrderID int = SCOPE_IDENTITY();


DECLARE @ProductID int = 760;
DECLARE @Quantity int = 1;
DECLARE @UnitPrice money = 782.99;

IF EXISTS (SELECT * FROM SalesLT.SalesOrderHeader WHERE SalesOrderID = @OrderID)
BEGIN
	INSERT INTO SalesLT.SalesOrderDetail (SalesOrderID, OrderQty, ProductID, UnitPrice)
	VALUES (@OrderID, @Quantity, @ProductID, @UnitPrice)
END
ELSE
BEGIN
	PRINT 'The order does not exist'
END


-- Errors

--System errors have pre-defined numbers, messages, severity levels, 
-- and other characteristics that you can use to troubleshoot issues.
SELECT * FROM sys.messages


-- Use RAISERROR and THROW to raise custom errors.
UPDATE Production.Product
SET DiscontinuedDate = GetDate()
WHERE ProductID = -1;

If @@ROWCOUNT < 1
	--RAISERROR('Product not found!', 16, 0);
	THROW 50001, 'Product not found!', 0;

-- Error Handling

/*
A common exception handling pattern is to log the error, and then if the
operation cannot be completed successfully, throw it (or a new custom error) to the calling application.
*/
DECLARE @discount int = 0;
BEGIN TRY
UPDATE Production.Product
SET ListPrice = ListPrice / @discount
END TRY
BEGIN CATCH
PRINT @@ERROR;
PRINT ERROR_MESSAGE();
PRINT ERROR_NUMBER();
PRINT ERROR_SEVERITY();
PRINT ERROR_STATE();
PRINT 'Line Number: ' + CAST(ERROR_LINE() AS nvarchar);
PRINT 'Procedure: ' + ISNULL(ERROR_PROCEDURE(), 'N/A');
--THROW; -- Throw the original error
THROW 50001, 'An error occured', 0; -- Re-throw a custom error
END CATCH


-- Transaction
/*
Transactions are used to protect data integrity BY ensuring that all data changes 
within a transaction succeed or fail as a unit.
*/
BEGIN TRY
	BEGIN TRANSACTION
	-- Task 1
	-- Task 2
	COMMIT TRANSACTION
END TRY
BEGIN CATCH
	IF @@TRANCOUNT > 0 -- Or XACT_STATE()
		BEGIN
			ROLLBACK TRANSACTION -- Or Enable XACT_ABORT to automatically rollback on error e.g. SET XACT_ABOART ON;
		END
	THROW;
END CATCH




DECLARE @OrderID int = 0

-- Declare a custom error if the specified order doesn't exist
DECLARE @error varchar(25) = 'Order #' + cast(@OrderID as varchar) + ' does not exist';

IF NOT EXISTS (SELECT * FROM SalesLT.SalesOrderHeader WHERE SalesOrderID = @OrderID)
BEGIN
  THROW 50001, @error, 0;
END
ELSE
BEGIN
  DELETE FROM SalesLT.SalesOrderDetail WHERE SalesOrderID = @OrderID;
  DELETE FROM SalesLT.SalesOrderHeader WHERE SalesOrderID = @OrderID;
END


-- XML
USE AdventureWorks
GO

-- https://www.simple-talk.com/sql/learn-sql-server/using-the-for-xml-clause-to-return-query-results-as-xml/
SELECT Name, ProductNumber, Color,ListPrice FROM Production.Product
SELECT Name, ProductNumber, Color,ListPrice FROM Production.Product FOR XML AUTO
SELECT Name, ProductNumber, Color,ListPrice FROM Production.Product FOR XML PATH

SELECT  ProductNumber AS "@ProductID",Name AS ProductName, Color AS Color,ListPrice AS Price FROM Production.Product 
FOR XML PATH ('Product'), ROOT ('Products');


-- DataType
SELECT NEWID();

-- Spacial Data example in AdventureWorkds
--https://docs.microsoft.com/en-us/sql/t-sql/spatial-geography/stdistance-geography-data-type
-- The following example finds the distance between two geography instances.
DECLARE @g geography;  
DECLARE @h geography;  
SET @g = geography::STGeomFromText('LINESTRING(-122.360 47.656, -122.343 47.656)', 4326);  
SET @h = geography::STGeomFromText('POINT(-122.34900 47.65100)', 4326);  
SELECT @g.STDistance(@h);  

-- https://docs.microsoft.com/en-us/sql/relational-databases/spatial/query-spatial-data-for-nearest-neighbor
USE AdventureWorks 
GO  
DECLARE @g geography = 'POINT(-121.626 47.8315)';  
SELECT TOP(7) SpatialLocation.ToString(), City FROM Person.Address  
WHERE SpatialLocation.STDistance(@g) IS NOT NULL  
ORDER BY SpatialLocation.STDistance(@g);  



