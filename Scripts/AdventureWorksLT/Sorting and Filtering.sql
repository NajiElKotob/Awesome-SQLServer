USE AdventureWorksLT2022
GO

-- This script contains demo code for Module 2 of the Transact-SQL course
-- يحتوي هذا السكربت على أمثلة توضيحية للوحدة الثانية من دورة ترانساكت-إس كيو إل



-- ORDER BY
-- الترتيب باستخدام ORDER BY

-- Sort by column
-- ترتيب النتائج حسب العمود CountryRegion
SELECT AddressLine1, City, PostalCode, CountryRegion
FROM SalesLT.Address
ORDER BY CountryRegion;

-- Sort and subsort
-- ترتيب حسب CountryRegion ثم ترتيب فرعي حسب City
SELECT AddressLine1, City, PostalCode, CountryRegion
FROM SalesLT.Address
ORDER BY CountryRegion, City;

-- Descending
-- ترتيب تنازلي حسب CountryRegion وتصاعدي حسب City
SELECT AddressLine1, City, PostalCode, CountryRegion
FROM SalesLT.Address
ORDER BY CountryRegion DESC, City ASC;



-- TOP
-- جلب أعلى عدد من السجلات باستخدام TOP

-- Top records
-- جلب أول 10 سجلات بناءً على تاريخ التعديل الأحدث
SELECT TOP (10) AddressLine1, ModifiedDate
FROM SalesLT.Address
ORDER BY ModifiedDate DESC;

-- Top with ties
-- جلب أول 10 سجلات مع ربط القيم المتساوية باستخدام WITH TIES
SELECT TOP (10) WITH TIES AddressLine1, ModifiedDate
FROM SalesLT.Address
ORDER BY ModifiedDate DESC;

-- Top percent
-- جلب أعلى 10% من السجلات حسب تاريخ التعديل
SELECT TOP (10) PERCENT AddressLine1, ModifiedDate
FROM SalesLT.Address
ORDER BY ModifiedDate DESC;



-- OFFSET and FETCH
-- استخدام OFFSET و FETCH لجلب البيانات مع خاصية التصفح (Pagination)

-- First 10 rows
-- جلب أول 10 سجلات
SELECT AddressLine1, ModifiedDate
FROM SalesLT.Address
ORDER BY ModifiedDate DESC OFFSET 0 ROWS FETCH NEXT 10 ROWS ONLY;

-- Next page
-- جلب الصفحة التالية (السجلات من 11 إلى 20)
SELECT AddressLine1, ModifiedDate
FROM SalesLT.Address
ORDER BY ModifiedDate DESC OFFSET 10 ROWS FETCH NEXT 10 ROWS ONLY;



-- ALL and DISTINCT
-- استخدام ALL و DISTINCT لتحديد تكرار النتائج

-- Implicit all
-- بشكل افتراضي، ALL تُستخدم وتُرجع القيم كما هي مع التكرار
SELECT City
FROM SalesLT.Address;

-- Explicit all
-- استخدام ALL بشكل صريح
SELECT ALL City
FROM SalesLT.Address;

-- Distinct
-- إزالة التكرار باستخدام DISTINCT
SELECT DISTINCT City
FROM SalesLT.Address;

-- Distinct combination
-- إزالة التكرار باستخدام مزيج من أكثر من عمود
SELECT DISTINCT City, PostalCode
FROM SalesLT.Address;



-- WHERE CLAUSE
-- جملة WHERE لتصفية البيانات

-- Simple filter
-- تصفية العناوين حسب الدولة (United Kingdom)
SELECT AddressLine1, City, PostalCode
FROM SalesLT.Address
WHERE CountryRegion = 'United Kingdom'
ORDER BY City, PostalCode;

-- Multiple criteria (and)
-- التحقق من شرطين باستخدام AND
SELECT AddressLine1, City, PostalCode
FROM SalesLT.Address
WHERE CountryRegion = 'United Kingdom'
    AND City = 'London'
ORDER BY PostalCode;

-- Multiple criteria (or)
-- استخدام OR للتحقق من أحد الشرطين
SELECT AddressLine1, City, PostalCode, CountryRegion
FROM SalesLT.Address
WHERE CountryRegion = 'United Kingdom'
    OR CountryRegion = 'Canada'
ORDER BY CountryRegion, PostalCode;

-- Nested conditions
-- استخدام الأقواس لجمع شروط متعددة
SELECT AddressLine1, City, PostalCode
FROM SalesLT.Address
WHERE CountryRegion = 'United Kingdom'
    AND (City = 'London' OR City = 'Oxford')
ORDER BY City, PostalCode;

-- Not equal to
-- استخدام <> لاستبعاد قيمة معينة
SELECT AddressLine1, City, PostalCode
FROM SalesLT.Address
WHERE CountryRegion = 'United Kingdom'
    AND City <> 'London'
ORDER BY City, PostalCode;

-- Greater than
-- شرط أن يكون الرمز البريدي أكبر من قيمة معينة
SELECT AddressLine1, City, PostalCode
FROM SalesLT.Address
WHERE CountryRegion = 'United Kingdom'
    AND City = 'London'
    AND PostalCode > 'S'
ORDER BY PostalCode;

-- Like with wildcard
-- استخدام LIKE مع الرمز % للبحث بالنمط
SELECT AddressLine1, City, PostalCode
FROM SalesLT.Address
WHERE CountryRegion = 'United Kingdom'
    AND City = 'London'
    AND PostalCode LIKE 'SW%'
ORDER BY PostalCode;

-- Like with regex pattern
-- استخدام نمط معين داخل LIKE مع أحرف مكانية
SELECT AddressLine1, City, PostalCode
FROM SalesLT.Address
WHERE CountryRegion = 'United Kingdom'
    AND City = 'London'
    AND PostalCode LIKE 'SW[0-9] [0-9]__'
ORDER BY PostalCode;

-- check for null
-- التحقق من أن العمود AddressLine2 ليس NULL
SELECT AddressLine1, AddressLine2, City, PostalCode
FROM SalesLT.Address
WHERE AddressLine2 IS NOT NULL
ORDER BY City, PostalCode;

-- within a range
-- استخدام BETWEEN للبحث ضمن نطاق تواريخ
SELECT AddressLine1, ModifiedDate
FROM SalesLT.Address
WHERE ModifiedDate BETWEEN '01/01/2005' AND '12/31/2005'
ORDER BY ModifiedDate;

-- In a list
-- استخدام IN للتحقق من وجود القيمة ضمن قائمة محددة
SELECT AddressLine1, City, CountryRegion
FROM SalesLT.Address
WHERE CountryRegion IN ('Canada', 'United States')
ORDER BY City;


-- SELECT CAST('2005-12-31' AS datetime)


