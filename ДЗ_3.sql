--Задание 1: Посчитать средний чек одного заказа

SELECT 
		o.orderid, ROUND(AVG(p.Price * od.Quantity), 2) as avg_sum
FROM Orders o 
JOIN OrderDetails od on od.OrderID = o.OrderID 
JOIN Products p on p.ProductID = od.ProductID 
GROUP BY o.OrderID
ORDER BY avg_sum DESC 

--OrderID|avg_sum|
---------+-------+
--  10353| 6713.5|
--  10424|4788.83|
--  10372| 3838.4|
--  10417| 3526.0|
--  10441| 2195.0|
--  10286| 1886.0|
--  10360|1848.85|
------------------
--  10415|   64.0|
--  10259|   63.0|
--  10422|  62.46|
--  10271|   60.0|
--  10288|   56.0|
--  10308|   55.5|
--  10281|  36.07|

/*Посчитать сколько заказов доставляет в месяц
каждая служба доставки.
Определите, сколько заказов доставила United
Package в декабре 2023 года*/

SELECT s.ShipperName, YEAR(o.OrderDate) as 'year' , MONTH(o.OrderDate) AS 'month', count(OrderID) AS 'cnt_orders' FROM orders o 
JOIN shippers s ON o.ShipperID = s.ShipperID
GROUP BY o.ShipperID, YEAR(o.OrderDate), MONTH(o.OrderDate), s.ShipperName
ORDER BY s.ShipperName, YEAR(o.OrderDate), MONTH(o.OrderDate); 




SELECT s.ShipperName, YEAR(o.OrderDate) as 'year' , MONTH(o.OrderDate) AS 'month', count(OrderID) AS 'cnt_orders' FROM orders o 
JOIN shippers s ON o.ShipperID = s.ShipperID
GROUP BY o.ShipperID, YEAR(o.OrderDate), MONTH(o.OrderDate), s.ShipperName
HAVING YEAR(o.OrderDate) = '2023' AND MONTH(o.OrderDate) = '12' AND s.ShipperName = 'United Package'
ORDER BY s.ShipperName, YEAR(o.OrderDate), MONTH(o.OrderDate); 




--Задание 3: Определить средний LTV покупателя (сколько денег покупатели 
--           в среднем тратят в магазине за весь период)
 

SELECT DISTINCT CustomerName, ROUND(SUM(Quantity * Price)/COUNT(DISTINCT CustomerName),2) AS ltv 
FROM customers c 
	JOIN orders o ON c.CustomerID =o.CustomerID
	JOIN orderdetails od ON od.OrderID = o.OrderID
	JOIN products p ON p.ProductID = od.ProductID
GROUP BY c.CustomerName 
ORDER BY ltv DESC ;
