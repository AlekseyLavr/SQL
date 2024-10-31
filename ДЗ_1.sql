-- В каких странах проживают наши клиенты (таблица Customers)? Сколько уникальных стран вы получили в ответе?
SELECT COUNT(DISTINCT Country) as unique_countries
from Customers c ;

-- 21 unique_countries

-- Сколько клиентов проживает в Argentina?
SELECT COUNT(*) as  argentine_customers
FROM Customers c 
WHERE Country = 'Argentina';

-- 3 argentine_customers


-- Посчитайте среднюю цену и количество товаров в 8 категории (таблица Products ).
SELECT ROUND( AVG(Price), 2) as avg_price, COUNT(*) as total_products
FROM Products p 
WHERE CategoryID = 8;

-- 20.68 avg_price, 12 total_products

-- Вычислите средний возраст сотрудников на дату 2024-01-01.
SELECT AVG(AGE) AS AverageAge
FROM (
    SELECT (JULIANDAY('2024-01-01') - JULIANDAY(BirthDate)) / 365 AS AGE
    FROM Employees
) AS AgeTable;

-- 66,168 AverageAge


-- Вам необходимо получить заказы, которые сделаны в течении 35 дней до даты 2023-10-10 (то есть с 5
-- сентября до 10 октября включительно).  

SELECT *
FROM Orders
WHERE OrderDate BETWEEN '2023-09-05' AND '2023-10-10'
ORDER BY OrderDate;

--OrderID|CustomerID|EmployeeID|OrderDate |ShipperID|
---------+----------+----------+----------+---------+
--  10298|        37|         6|2023-09-05|        2|
--  10299|        67|         4|2023-09-06|        2|
--  10300|        49|         2|2023-09-09|        2|
--  10301|        86|         8|2023-09-09|        2|
--  10302|        76|         4|2023-09-10|        2|
--  10303|        30|         7|2023-09-11|        2|
--  10304|        80|         1|2023-09-12|        2|
--  10305|        55|         8|2023-09-13|        3|
--  10306|        69|         1|2023-09-16|        3|
--  10307|        48|         2|2023-09-17|        2|
--  10308|         2|         7|2023-09-18|        3|
--  10309|        37|         3|2023-09-19|        1|
--  10310|        77|         8|2023-09-20|        2|
--  10311|        18|         1|2023-09-20|        3|
--  10312|        86|         2|2023-09-23|        2|
--  10313|        63|         2|2023-09-24|        2|
--  10314|        65|         1|2023-09-25|        2|
--  10315|        38|         4|2023-09-26|        2|
--  10316|        65|         1|2023-09-27|        3|
--  10317|        48|         6|2023-09-30|        1|
--  10318|        38|         8|2023-10-01|        2|
--  10319|        80|         7|2023-10-02|        3|
--  10320|        87|         5|2023-10-03|        3|
--  10321|        38|         3|2023-10-03|        2|
--  10322|        58|         7|2023-10-04|        3|
--  10323|        39|         4|2023-10-07|        1|
--  10324|        71|         9|2023-10-08|        1|
--  10325|        39|         1|2023-10-09|        3|
--  10326|         8|         4|2023-10-10|        2|

-- Вам необходимо получить количество заказов за сентябрь месяц (тремя способами, через LIKE, сравнение начальной и конечной даты).

-- через LIKE:
SELECT COUNT(*) AS september_orders
FROM Orders
WHERE OrderDate LIKE '2023-09%';

-- сравнение начальной и конечной даты
SELECT COUNT(*) AS september_orders
FROM Orders
WHERE OrderDate >= '2023-09-01' AND OrderDate <= '2023-09-31';

SELECT COUNT(*) AS september_orders
FROM Orders
WHERE OrderDate >= '2023-09-01' AND OrderDate <= '2023-09-31';