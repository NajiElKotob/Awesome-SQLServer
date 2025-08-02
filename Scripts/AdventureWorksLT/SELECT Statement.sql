USE AdventureWorksLT2022
GO

-- BASIC QUERIES
-- الاستعلامات الأساسية

-- Select all columns
-- استرجاع جميع الأعمدة من جدول العملاء
SELECT * FROM SalesLT.Customer;

-- Select specific columns
-- استرجاع أعمدة محددة: رقم العميل، الاسم الأول، والاسم الأخير
SELECT CustomerID, FirstName, LastName
FROM SalesLT.Customer;

-- Select an expression
-- دمج الاسم الأول والاسم الأخير في عمود واحد (بدون اسم مخصص)
SELECT CustomerID, FirstName + ' ' + LastName
FROM SalesLT.Customer;

-- Apply an alias
-- دمج الاسم الأول والاسم الأخير مع تعيين اسم مخصص للعمود باستخدام AS
SELECT CustomerID, FirstName + ' ' + LastName AS CustomerName
FROM SalesLT.Customer;


-- DATA TYPES
-- أنواع البيانات

-- Try to combine incompatible data types (results in error)
-- محاولة دمج أنواع بيانات غير متوافقة (ينتج عنها خطأ)
SELECT CustomerID + ':' + EmailAddress AS CustomerIdentifier
FROM SalesLT.Customer;

-- Use cast
-- استخدام الدالة CAST لتحويل نوع البيانات
SELECT CAST(CustomerID AS varchar) + ':' + EmailAddress AS CustomerIdentifier
FROM SalesLT.Customer;

-- Use convert
-- استخدام الدالة CONVERT لتحويل نوع البيانات
SELECT CONVERT(varchar, CustomerID) + ':' + EmailAddress AS CustomerIdentifier
FROM SalesLT.Customer;

-- convert dates
-- تحويل التاريخ إلى صيغة نصية - مع وبدون تنسيق ISO8601
SELECT CustomerID,
       CONVERT(nvarchar(30), ModifiedDate) AS ConvertedDate,           -- بدون تنسيق محدد
	   CONVERT(nvarchar(30), ModifiedDate, 126) AS ISO8601FormatDate   -- تنسيق ISO 8601
FROM SalesLT.Customer;



-- NULL VALUES
-- القيم الفارغة (NULL)

-- See the effect of expressions with NULL values
-- ملاحظة تأثير وجود NULL في عملية الدمج (ستُرجع NULL)
SELECT CustomerID, Title + ' ' + LastName AS Greeting
FROM SalesLT.Customer;

-- Replace NULL value (use ? if Title is NULL)
-- استبدال القيمة NULL باستخدام ISNULL - يتم عرض "؟" في حال عدم وجود Title
SELECT CustomerID, ISNULL(Title, '?') + ' ' + LastName AS Greeting
FROM SalesLT.Customer;

-- Coalesce (use first non-NULL value)
-- استخدام COALESCE لعرض أول قيمة غير NULL بين Title و FirstName
SELECT CustomerID, COALESCE(Title, FirstName) + ' ' + LastName AS Greeting
FROM SalesLT.Customer;

-- Convert specific values to NULL
-- استخدام NULLIF لتحويل القيم المحددة إلى NULL (إذا كانت الخصم = 0)
SELECT SalesOrderID, ProductID, UnitPrice, NULLIF(UnitPriceDiscount, 0) AS Discount
FROM SalesLT.SalesOrderDetail;



-- CASE statement
-- جملة CASE الشرطية

-- Simple case
-- استخدام CASE لتنسيق الاسم الكامل بناءً على وجود Title و MiddleName
SELECT  CustomerID,
        CASE
            WHEN Title IS NOT NULL AND MiddleName IS NOT NULL
                THEN Title + ' ' + FirstName + ' ' + MiddleName + ' ' + LastName
            WHEN Title IS NOT NULL AND MiddleName IS NULL
                THEN Title + ' ' + FirstName + ' ' + LastName
            ELSE FirstName + ' ' + LastName
        END AS CustomerName
FROM SalesLT.Customer;

-- Searched case
-- استخدام CASE مع قيم ثابتة في العمود Suffix، مثل 'Sr.' و 'Jr.'
SELECT  FirstName, LastName,
        CASE Suffix
            WHEN 'Sr.' THEN 'Senior'
            WHEN 'Jr.' THEN 'Junior'
            ELSE ISNULL(Suffix, '')
        END AS NameSuffix
FROM SalesLT.Customer;
