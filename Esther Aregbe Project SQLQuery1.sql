-- JOIN
--(1) Find sales person name, territoryname, sales ytd, sales last year and bonus 

select PP.FirstName,pp.LastName, st.Name as territory_name, SP.SalesYTD, SP.SalesLastYear, sp.Bonus
from sales.SalesPerson SP
join Person.Person PP 
ON SP.BusinessEntityID = PP.BusinessEntityID
Join sales.SalesTerritory ST
on SP.TerritoryID = ST.TerritoryID;

--JOIN, HAVING
--(2)How can we find the names of products for which we have sold more than 1,000 units, along with the total revenue generated by each product?
 
SELECT PP.Name AS ProductName, SUM(sod.OrderQty) AS TotalUnitsSold, SUM(sod.LineTotal) AS TotalRevenue
FROM Sales.SalesOrderDetail sod
JOIN Production.Product PP ON sod.ProductID = PP.ProductID
GROUP BY PP.Name
HAVING SUM(sod.OrderQty) > 1000;

--JOIN, HAVING
--(3) How can we find the names of products that have been ordered more than 1,000 times, along with the total revenue generated by each product?

SELECT pp.Name AS ProductName,COUNT(sod.SalesOrderDetailID) AS NumberOfOrders, SUM(sod.LineTotal) AS TotalRevenue
FROM Sales.SalesOrderDetail sod
JOIN Production.Product pp ON sod.ProductID = pp.ProductID
GROUP BY pp.Name
HAVING COUNT(sod.SalesOrderDetailID) > 1000;

--AND, IN, BETWEEN

--(4) we want to see people whose person type is SP and have middle name 

select PersonType, firstname, MiddleName, LastName
from person.person
where persontype = 'SP' and MiddleName is not null

--(5) we want to see details of people whose first name are Mary, John and Michael

select FirstName, lastname, middlename
from person.person
where firstname in ('Mary', 'John','Michael')
order by FirstName

--(6) we want to see employees whose vacationhours are for 20 and 50

select BusinessEntityID, JobTitle, HireDate, VacationHours
from HumanResources.Employee
where VacationHours between 20 and 50
order by VacationHours asc;

--where
--(7) Find the details of products that have a ListPrice greater than $1000.

select ProductID, name as product_name, ListPrice
from Production.Product
where ListPrice > 1000

--leftjoin
-- (8) Retrieve all customers and their associated sales orders, if any.

select  pp.FirstName, pp.LastName,sc.CustomerID, count(soh.SalesOrderID) as salesorder_count
from sales.customer sc
join person.person pp
on sc.PersonID = pp.BusinessEntityID
left join sales.SalesOrderHeader SOh
on sc.CustomerID = SOh.CustomerID
group by pp.FirstName, pp.LastName, sc.CustomerID;

--rightjoin
--(9) identify all sales transactions alongside their respective customers, ensuring inclusion of customers who have no associated order information

select pp.FirstName, pp.LastName,soh.CustomerID, soh.SalesOrderID
from sales.SalesOrderHeader soh
right join sales.Customer sc
on soh.CustomerID = sc.CustomerID
join person.Person pp
on sc.PersonID =pp.BusinessEntityID

--join
- --(10)extract all product name along with their respective categories, ensuring that products without any associated category information are also included in the result set. 

	select pp.name, pc.name as product_category
	from production.ProductCategory pc
	join production.ProductSubcategory ps 
	on ps.ProductCategoryID = pc.ProductCategoryID
	right join Production.product pp
	on  pp.ProductSubcategoryID=ps.ProductSubcategoryID;

--join
--(11)- list all products and their respective sales orders, including products that have never been sold and sales orders that do not correspond to any products.

select pp.Name, so.SalesOrderDetailID, so.SalesOrderID
from Production.Product pp
full outer join sales.SalesOrderDetail so on pp.ProductID = so.ProductID

--join
--(12) Find the total number of products in each product category.

SELECT pc.Name AS ProductCategory,COUNT(p.ProductID) AS TotalProducts
FROM Production.Product p
JOIN Production.ProductSubcategory ps ON p.ProductSubcategoryID = ps.ProductSubcategoryID
JOIN Production.ProductCategory pc ON ps.ProductCategoryID = pc.ProductCategoryID
GROUP BY pc.Name;

--join
--(13)  Calculate the average ListPrice of products in the 'Bikes' category.

SELECT pc.Name AS ProductCategory,avg(p.ListPrice) AS avg_listprice
FROM Production.Product p
JOIN Production.ProductSubcategory ps ON p.ProductSubcategoryID = ps.ProductSubcategoryID
JOIN Production.ProductCategory pc ON ps.ProductCategoryID = pc.ProductCategoryID
where pc.Name = 'Bikes'
GROUP BY pc.Name;

--subquery
--(14) List the names of employees who work in the 'Sales' department.

SELECT pp.FirstName, pp.LastName 
FROM Person.Person pp
JOIN HumanResources.Employee hre ON pp.BusinessEntityID = hre.BusinessEntityID
WHERE hre.BusinessEntityID 
IN (SELECT edh.BusinessEntityID
    FROM HumanResources.EmployeeDepartmentHistory edh
    JOIN HumanResources.Department d ON edh.DepartmentID = d.DepartmentID
     WHERE d.Name = 'Sales');
	
	--case when
--(15) Create a query that displays the product name and a column that indicates whether the product is 'Expensive' or 'Affordable'
--based on whether the ListPrice is above or below $500.

select Name,
case when listprice > 500 then 'Expensive' else 'affordable'
end as status
from Production.Product

--orderby
--(16) Retrieve all orders placed in the last year assuming we are in 2012

SELECT SalesOrderID, OrderDate
FROM Sales.SalesOrderHeader
WHERE OrderDate BETWEEN '2011-01-01' AND '2011-12-31'
ORDER BY OrderDate;


--CTE
--(17) Find the total sales amount for each salesperson in the last year, including the sales details and average sales per order.

WITH SalesLastYear AS (
    SELECT SalesOrderID, SalesPersonID, OrderDate, TotalDue
    FROM Sales.SalesOrderHeader
    WHERE OrderDate between '2011-01-01' and '2012-01-01'
),
SalesPersonDetails AS (
    SELECT sp.BusinessEntityID, pp.FirstName, pp.LastName
    FROM Sales.SalesPerson sp
    JOIN Person.Person pp ON sp.BusinessEntityID = pp.BusinessEntityID
),
TotalSales AS (
    SELECT SalesPersonID, SUM(TotalDue) AS TotalSales
    FROM SalesLastYear
    GROUP BY SalesPersonID
)
SELECT spd.FirstName, spd.LastName, ts.TotalSales
FROM TotalSales ts
JOIN SalesPersonDetails spd ON ts.SalesPersonID = spd.BusinessEntityID
ORDER BY ts.TotalSales DESC;

