-- Dynamic Backup
-- Version 0.3 

DECLARE @sql NVARCHAR(1000)
DECLARE @formattedDate NVARCHAR(15)
DECLARE @databaseName NVARCHAR(50)
DECLARE @path NVARCHAR(250)

-- Get the current date in the YYYYMMDDHHmmss format
SET @formattedDate = FORMAT(GETDATE(), 'yyyyMMdd_HHmmss')

-- Update database_name (3) and Path (1) 
SET @databaseName = 'YourDatabaseName'
SET @path = 'X:\backup\' -- Add \ at the end

-- Construct the dynamic SQL
SET @sql = 
'BACKUP DATABASE ' + @databaseName + 
' TO  DISK = N''' + @path + @databaseName + '_' + @formattedDate + '.bak'' 
WITH  COPY_ONLY, NOFORMAT, INIT,  
NAME = N''' + @databaseName + '-Full Database Backup'',
SKIP, NOREWIND, NOUNLOAD,  STATS = 10'

-- Print (debug) and execute the SQL
PRINT @sql
PRINT @formattedDate
EXEC sp_executesql @sql
