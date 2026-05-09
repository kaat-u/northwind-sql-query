------------------------------------------------------------
------------------------------------------------------------

-- 4. Pedidos por compañía

SELECT * 
FROM Orders 
WHERE CustomerID IN (
	SELECT CustomerID
	FROM Customers
	WHERE CompanyName = 'Rattlesnake Canyon Grocery')
	GO

------------------------------------------------------------
------------------------------------------------------------

-- 5. Productos vendidos en categoría

SELECT p.ProductName AS 'Producto',
	SUM(od.Quantity) AS 'Cantidad Vendida'
FROM Products p
INNER JOIN Categories c
	ON p.CategoryID = c.CategoryID
INNER JOIN [Order Details] od
	ON p.ProductID = od.ProductID
WHERE c.CategoryName = 'Beverages'
GROUP BY p.ProductName
GO

------------------------------------------------------------
------------------------------------------------------------

-- 6. Empleado y su supervisor (SELF JOIN)

SELECT e.FirstName + ' ' + e.LastName AS 'Empleado',
	   s.FirstName + ' ' + s.LastName AS 'Supervisor'
FROM Employees e
INNER JOIN Employees s
	ON e.ReportsTo = s.EmployeeID
GO

------------------------------------------------------------
------------------------------------------------------------

-- 7. Clasificación de precio (CASE)

SELECT ProductName AS 'Producto',
	   UnitPrice AS 'Precio',
	   CASE
			WHEN UnitPrice < 10 THEN 'Barato'
			WHEN UnitPrice BETWEEN 10 AND 50 THEN 'Medio'
			WHEN UnitPrice > 50 THEN 'Caro'
		END AS 'Clasificación'
FROM Products
GO

------------------------------------------------------------
------------------------------------------------------------

-- 8. Estado del pedido (Enviado / Pendiente)

SELECT o.OrderID AS 'Número de pedido',
	   o.CustomerID AS 'Cliente',
	   CASE
			WHEN ShippedDate IS NOT NULL THEN 'Enviado'
			ELSE 'Pendiente'
		END AS 'EStado'
FROM Orders o
GO

------------------------------------------------------------
------------------------------------------------------------

-- 9. Total de compras por cliente (ORDER BY DESC) 

SELECT o.CustomerID AS 'Cliente',
	   SUM(od.UnitPrice * od.Quantity) AS 'Total compras'
FROM Orders o
INNER JOIN [Order Details] od
	ON o.OrderID = od.OrderID
GROUP BY o.CustomerID
ORDER BY 2 DESC
GO

------------------------------------------------------------
------------------------------------------------------------

-- 10.	Productos y categorías en una lista (UNION) 

SELECT ProductName AS 'Nombre'
FROM Products
UNION
SELECT CategoryName
FROM Categories
GO

------------------------------------------------------------
------------------------------------------------------------





