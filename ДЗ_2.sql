-- 1. Вам необходимо проверить влияние семейного
--    положения (family_status) на средний доход
--    клиентов (income) и запрашиваемый кредит
--    (credit_amount) .

SELECT family_status, ROUND(AVG(income), 2) as avg_income, credit_amount
from Clusters c 
group by family_status
order by family_status;

--family_status|avg_income|credit_amount|
---------------+----------+-------------+
--Another      |  32756.04|         7000|
--Married      |  32272.52|        14500|
--Unmarried    |  33217.95|        10000|

--2. Сколько товаров в категории Meat/Poultry.
SELECT DISTINCT COUNT(ProductID) as cnt 
From Products p 
WHERE CategoryID IN 
(SELECT CategoryID
from Categories c 
WHERE CategoryName = 'Meat/Poultry');

--cnt|
-----+
--  6|

--3. Какой товар (название) заказывали в сумме в
--   самом большом количестве (sum(Quantity) в
--   таблице OrderDetails)
SELECT ProductName FROM Products p 
WHERE ProductID IN 
(SELECT ProductID FROM OrderDetails od 
WHERE Quantity = 
(SELECT MAX(Quantity) FROM orderdetails));

--ProductName       |
--------------------+
--PÃƒÂ¢tÃƒÂ© chinois|
