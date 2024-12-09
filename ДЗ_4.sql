/*Задание: Ранжируйте продукты в каждой категории на основе их средней цены
(AvgPrice). Используйте таблицы OrderDetails и Products.*/
with avg_price as (
	select 
		p.CategoryID ,
		p.ProductID ,
		p.ProductName ,
		avg(p.Price) as avg_price 
	from products p 
	join orderdetails od on p.ProductID = od.ProductID 
	group by p.CategoryID, p.ProductID, p.ProductName) 
select
	CategoryID,
	ProductID,
	ProductName,
	avg_price,
	rank() over (partition by CategoryID order by avg_price desc) as product_rank
from avg_price

-- CategoryID|ProductID|ProductName                     |avg_price|product_rank|
--   ----------+---------+--------------------------------+---------+------------+
--          1|       38|Côte de Blaye                   | 263.0000|           1|
--          1|       43|Ipoh Coffee                     |  46.0000|           2|
--          1|        2|Chang                           |  19.0000|           3|
--          1|        1|Chais                           |  18.0000|           4|
--          1|       76|Lakkalikööri                    |  18.0000|           4|
--          1|       35|Steeleye Stout                  |  18.0000|           4|
--          1|       39|Chartreuse verte                |  18.0000|           4|
--          1|       70|Outback Lager                   |  15.0000|           8|
--  ------------------------------------------------------------------------------
--         8|       40|Boston Crab Meat                |  18.0000|           6|
--         8|       73|Röd Kaviar                      |  15.0000|           7|
--         8|       58|Escargots de Bourgogne          |  13.0000|           8|
--         8|       46|Spegesild                       |  12.0000|           9|
--         8|       41|Jack's New England Clam Chowder |   9.0000|          10|
--         8|       45|Røgede sild                     |   9.0000|          10|
--         8|       13|Konbu                           |   6.0000|          12|


/*Задание: Рассчитайте среднюю сумму кредита (AvgCreditAmount) для каждого
кластера в каждом месяце и сравните её с максимальной суммой кредита
(MaxCreditAmount) за тот же месяц. Используйте таблицу Clusters.*/

with avg_credit as (
	select
		month,
		cluster,
		avg(credit_amount) as avg_credit_amount
	from clusters c 
	group by month, cluster),
max_credit as (
	select
		month,
		max(credit_amount) as max_credit_amount
	from clusters c
	group by month)
select 
	a.month,
	a.cluster,
	a.avg_credit_amount,
	m.max_credit_amount
from avg_credit a
join max_credit m on a.month = m.month

-- month|cluster|avg_credit_amount|max_credit_amount|
-- -----+-------+-----------------+-----------------+
--     1|      3|       22114.8649|           152000|
--     1|      4|       33714.2857|           152000|
--     1|      2|       39500.0000|           152000|
--     1|      0|       18000.0000|           152000|
--     2|      3|       25530.3030|           199000|
-- --------------------------------------------------
--    12|      4|       45308.3333|           292500|
--    12|      3|       23826.3889|           292500|
--    12|      2|       57400.0000|           292500|
--    12|      5|       49000.0000|           292500|
--    12|      1|       44000.0000|           292500|

/* Задание: Создайте таблицу с разницей (Difference) между суммой кредита и
предыдущей суммой кредита по месяцам для каждого кластера. Используйте таблицу
Clusters.*/
WITH CreditWithPrevious AS (
	SELECT
		month,
		cluster,
		credit_amount,
		LAG(credit_amount) OVER (PARTITION BY cluster ORDER by month) AS PreviousCreditAmount
	FROM Clusters
)
SELECT
	month,
	cluster,
	credit_amount,
	PreviousCreditAmount,
	COALESCE(credit_amount - PreviousCreditAmount, 0) AS Difference
FROM CreditWithPrevious

-- month|cluster|credit_amount|PreviousCreditAmount|Difference|
-- -----+-------+-------------+--------------------+----------+
--     1|      0|        30000|                    |         0|
--     1|      0|         8500|               30000|    -21500|
--     1|      0|        18000|                8500|      9500|
--     1|      0|         8000|               18000|    -10000|
--     1|      0|        15500|                8000|      7500|
-- ------------------------------------------------------------
--    10|      6|        53000|                8500|     44500|
--    10|      6|         9000|               53000|    -44000|
--    10|      6|        46000|                9000|     37000|
--    10|      6|       301000|               46000|    255000|
--    11|      6|         7500|              301000|   -293500|