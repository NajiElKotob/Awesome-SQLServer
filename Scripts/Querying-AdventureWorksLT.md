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
