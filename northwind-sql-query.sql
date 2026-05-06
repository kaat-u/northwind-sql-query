------------------------------------------------------------
------------------------------------------------------------

-- 4.	(2 pts) Escribe la consulta SQL para 
-- mostrar todos los pedidos realizados 
-- por la compañía Rattlesnake Canyon Grocery.

SELECT * 
FROM Orders 
WHERE CustomerID IN (
	SELECT CustomerID
	FROM Customers
	WHERE CompanyName = 'Rattlesnake Canyon Grocery')
	GO

------------------------------------------------------------
------------------------------------------------------------

-- 5.	(2 pts) Escribe la consulta SQL para mostrar 
-- el nombre del producto y la cantidad vendida 
-- en la categoría Beverages.

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

-- 6.	(2 pts) Usando la tabla Employees, escribe 
-- una consulta que muestre el nombre completo del 
-- empleado y el nombre de su supervisor (SELF JOIN).

SELECT e.FirstName + ' ' + e.LastName AS 'Empleado',
	   s.FirstName + ' ' + s.LastName AS 'Supervisor'
FROM Employees e
INNER JOIN Employees s
	ON e.ReportsTo = s.EmployeeID
GO

------------------------------------------------------------
------------------------------------------------------------

-- 7.	(2 pts) Escribe una consulta que muestre 
-- el nombre del producto y un campo calculado 
-- con CASE que lo clasifique como 
-- Barato (<10), Medio (10–50) o Caro (>50).

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

-- 8.	(2 pts) A partir de la tabla Orders, 
-- escribe una consulta que muestre el número de pedido,
-- el cliente y un campo calculado que indique si está 
-- Enviado o Pendiente. Explica cómo funciona la condición.

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

-- 9.	(2 pts) Escribe una consulta que muestre 
-- los clientes y el total de sus compras, 
-- ordenados de mayor a menor. 
-- ¿Qué función de agregación utilizaste y por qué?

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

-- 10.	(2 pts) Usando UNION, combina en una sola lista 
-- los nombres de los productos vendidos y los nombres 
-- de las categorías. Explica qué condición debe cumplirse 
-- para que UNION funcione correctamente.

SELECT ProductName AS 'Nombre'
FROM Products
UNION
SELECT CategoryName
FROM Categories
GO

------------------------------------------------------------
------------------------------------------------------------





