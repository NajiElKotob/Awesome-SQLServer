USE tempdb
GO

-- SQL Basics - Tips and Tricks 
-- Numbers, Strings, NULLs, and Comments
-- Naji El Kotob | najielkotob.com


----------------------------------------------------
-- Comments in T-SQL
----------------------------------------------------

-- This is a single-line comment

/*
 This is a multi-line comment.
 Use it to describe logic or disable multiple lines.
*/

-- You can comment at the end of a line too
SELECT 10 + 5   -- Adds two integers



----------------------------------------------------
-- Data Type Behavior: Numbers + Strings + NULL
----------------------------------------------------

-- Number + Number
SELECT 1 + 1                              -- Returns: 2

-- String + Number
SELECT '1' + 1                            -- Returns: 2 (implicit conversion)
SELECT 1 + '1'                            -- Returns: 2 (implicit conversion)

-- String + String
SELECT '1' + '1'                          -- Returns: 11 (concatenation if VARCHAR)

-- Tip: SQL Server tries to implicitly convert strings to numbers [when possible]

-- Try this with non-numeric strings
SELECT 1 + 'A'                         -- Error: Conversion failed

-- AS





----------------------------------------------------
-- NULL
----------------------------------------------------

-- NULL behavior
SELECT 'A' + NULL							
SELECT NULL + 'A'							
SELECT NULL + NULL							

-- Use ISNULL to handle NULLs safely
SELECT ISNULL('A', '') + ISNULL(NULL, '')   

-- Also try:
SELECT ISNULL(NULL, 0) + 100				





----------------------------------------------------
-- Practice Tasks
----------------------------------------------------

-- What will this return?
SELECT '50' + 25

-- How to fix this error? (Hint: use TRY_CAST or convert manually)
SELECT 'ABC' + 1

-- Try using CAST or CONVERT
SELECT 'Sum: ' + CAST(5 + 10 AS VARCHAR)

-- Handle NULL to return a string

SELECT 'Total: ' + ISNULL(CAST(NULL AS VARCHAR), '0')



----------------------------------------------------
-- TRY_CAST and TRY_CONVERT
----------------------------------------------------
SELECT TRY_CAST('123' AS INT)             -- Returns: 123
SELECT TRY_CAST('XYZ' AS INT)             -- Returns: NULL

SELECT TRY_CONVERT(INT, '123')            -- Returns: 123
SELECT TRY_CONVERT(INT, 'XYZ')            -- Returns: NULL

-- Avoids breaking queries when conversion fails
