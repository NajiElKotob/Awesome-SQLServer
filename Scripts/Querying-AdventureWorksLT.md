# Querying AdventureWorksLT

## Use SELECT queries to retrieve data
* Get a list of all products

`SELECT * FROM SalesLT.Product;`


* Retrieve the Name, StandardCost, and ListPrice columns for all products.

`SELECT Name, StandardCost, ListPrice FROM SalesLT.Product;`

* ProductName and Markup with aliases

`SELECT Name AS ProductName, 
  ListPrice - StandardCost AS Markup
 FROM SalesLT.Product;`

* Concatenate the Color and Size column values (with a literal comma between them)

`SELECT ProductNumber, Color, Size, Color + ', ' + Size AS ProductDetails FROM SalesLT.Product;`

* Concatenate the numeric value (ProductID) and the text-based value (Name) 

`SELECT CAST(ProductID AS varchar(5)) + ': ' + Name AS ProductName FROM SalesLT.Product;`
