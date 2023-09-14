-- Reset and Reload T-SQL Script
-- Version 0.3 | 14 Sep 2023

-- First, run SSMS "Run as administrator" <------

-- Show advanced options
EXEC sp_configure 'show advanced options', 1;
RECONFIGURE;

-- Enable Ad Hoc Distributed Queries
EXEC sp_configure 'Ad Hoc Distributed Queries', 1;
RECONFIGURE;


-- Select database
USE DatabaseName
GO

-- Enable IDENTITY_INSERT for the table 'Service'
-- SET IDENTITY_INSERT Service ON; -- Future feature

-- Disable the constraint(s)
ALTER TABLE Service NOCHECK CONSTRAINT ALL;
-- ...
-- ...

-- Clear the tables (Child > Parent)
DELETE FROM Table1;
-- DELETE FROM Table2;
-- DELETE FROM Table3;

-- Reset the identity columns (like auto-increment in some DBMS)
DBCC CHECKIDENT ('Table1', RESEED, 0);
-- DBCC CHECKIDENT ('Table2', RESEED, 0);
-- DBCC CHECKIDENT ('Table3', RESEED, 0);


/*
Importing data from an XLS (Excel) sheet into a SQL Server 
database can be accomplished in multiple ways. 
One common method is using the SQL Server Import and Export Wizard. 
However, if you want to automate this process via a script, 
you'd often employ tools or libraries outside of pure T-SQL.

First, you have to install and configure the 
Microsoft.ACE.OLEDB.12.0 provider "Microsoft Access Database Engine 2010 Redistributable"
which is used to read from Excel:


Setup:
1. Download and install the Microsoft Access Database Engine 2010 Redistributable if not installed.
   https://www.microsoft.com/en-US/download/details.aspx?id=13255
2. Ensure that the SQL Server service and the SQL Server Agent service are running under an account that has permissions to the folder where the Excel file resides.


Configuration:
1. Provider Permissions: Ensure that the Microsoft.ACE.OLEDB.12.0 provider is allowed to be instantiated by the SQL Server process. This can be checked and set in SQL Server Management Studio (SSMS).
In SSMS, navigate to the Server Objects -> Linked Servers -> Providers -> Microsoft.ACE.OLEDB.12.0 and ensure the "Allow inprocess" option is enabled.
2. Double-click on Microsoft.ACE.OLEDB.12.0 and enable "Allow inprocess" option.
*/

-- Import data from an XLS file into a SQL Server table
INSERT INTO TableName (
		Column1,
		Column2
) -- Adjust column names
SELECT * 
FROM OPENROWSET(
    'Microsoft.ACE.OLEDB.12.0',
    'Excel 8.0;Database=C:\Users\naji\OneDrive\Desktop\M2.xls;HDR=YES;IMEX=1',
    'SELECT [Column1],[Column2] FROM [SheetName$]'
);

-- Repeat the INSERT INTO/SELECT for each table



-- Disable IDENTITY_INSERT for the table 'Service'
-- SET IDENTITY_INSERT Service OFF; -- Future feature

-- Re-enable the constraint(s)
ALTER TABLE Service CHECK CONSTRAINT ALL;
-- ...

-- Enable Ad Hoc Distributed Queries
EXEC sp_configure 'Ad Hoc Distributed Queries', 0;
RECONFIGURE;

-- Show advanced options
EXEC sp_configure 'show advanced options', 0;
RECONFIGURE;

