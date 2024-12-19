/*Задание: Создайте таблицу EmployeeDetails для хранения информации о
сотрудниках. Таблица должна содержать следующие столбцы:
● EmployeeID (INTEGER, PRIMARY KEY)
● EmployeeName (TEXT)
● Position (TEXT)
● HireDate (DATE)
● Salary (NUMERIC)
После создания таблицы добавьте в неё три записи с произвольными данными о
сотрудниках.*/

-- Создание таблицы
CREATE TABLE EmployeeDetails (
EmployeeID INTEGER PRIMARY KEY,
EmployeeName TEXT,
Position TEXT,
HireDate DATE,
Salary NUMERIC
);

-- Добавление данных
INSERT INTO EmployeeDetails (EmployeeID, EmployeeName, Position, HireDate, Salary) 
VALUES (1, 'Ivan Ivanov', 'Manager', '2022-08-31', 60000);
INSERT INTO EmployeeDetails (EmployeeID, EmployeeName, Position, HireDate, Salary)
VALUES (2, 'Boris Borisov', 'Marketing Specialist', '2022-10-01', 50000);
INSERT INTO EmployeeDetails (EmployeeID, EmployeeName, Position, HireDate, Salary)
VALUES (3, 'Stepan Stepanov', 'Software Engineer', '2024-03-22', 70000);

select * from EmployeeDetails


/*EmployeeID|EmployeeName   |Position            |HireDate  |Salary|
  ----------+---------------+--------------------+----------+------+
           1|Ivan Ivanov    |Manager             |2022-08-31| 60000|
           2|Boris Borisov  |Marketing Specialist|2022-10-01| 50000|
           3|Stepan Stepanov|Software Engineer   |2024-03-22| 70000|*/


/*Задание: Создайте представление HighValueOrders для отображения всех заказов,
сумма которых превышает 10000. В представлении должны быть следующие столбцы:
● OrderID (идентификатор заказа),
● OrderDate (дата заказа),
● TotalAmount (общая сумма заказа, вычисленная как сумма всех Quantity *
Price).
Используйте таблицы Orders, OrderDetails и Products.*/

CREATE VIEW HighValueOrders AS
SELECT
	o.OrderID,
	o.OrderDate,
	SUM(od.Quantity * p.Price) AS TotalAmount
FROM Orders o
JOIN OrderDetails od ON o.OrderID = od.OrderID
JOIN Products p ON od.ProductID = p.ProductID
GROUP BY o.OrderID, o.OrderDate
HAVING SUM(od.Quantity * p.Price) > 10000;

select * from HighValueOrders

/*OrderID|OrderDate |TotalAmount|
  -------+----------+-----------+
    10353|2023-11-13|      13402|
    10372|2023-12-04|      15300|
    10417|2024-01-16|      14061|
    10424|2024-01-23|      14327|*/

/*Задание: Удалите все записи из таблицы EmployeeDetails, где Salary меньше
60000. Затем удалите таблицу EmployeeDetails из базы данных.*/

-- Удаление данных
DELETE FROM EmployeeDetails WHERE Salary < 60000;

select * from EmployeeDetails

/*EmployeeID|EmployeeName   |Position         |HireDate  |Salary|
  ----------+---------------+-----------------+----------+------+
           1|Ivan Ivanov    |Manager          |2022-08-31| 60000|
           3|Stepan Stepanov|Software Engineer|2024-03-22| 70000|*/


-- Удаление таблицы
DROP TABLE EmployeeDetails;
