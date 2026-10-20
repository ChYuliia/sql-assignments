--------------------------------------------------------------------------------------
-- Name       : Subqueries (Chapters 7)
-- Author     : Yuliia Chernysheva
-- Course     : CIS 2268 SQL Programming
--------------------------------------------------------------------------------------

USE ot;

SET @@global.sql_mode := REPLACE(@@global.sql_mode, 'ONLY_FULL_GROUP_BY', '');

-- 1. What is the average unit_price in order_items?
SELECT AVG(unit_price)
FROM order_items;

-- Find all items whose unit_price is greater than the average. Group by item_id. Sort the output by item_id.
SELECT item_id, unit_price
FROM order_items
WHERE unit_price > 
	(SELECT AVG(unit_price)
	 FROM order_items)
GROUP BY item_id
ORDER BY item_id;

-- 2. Join the above query with products to display the name of the item.
SELECT oi.item_id, oi.unit_price, p.product_name
FROM order_items oi
JOIN products p USING(product_id)
WHERE oi.unit_price > 
	(SELECT AVG(unit_price)
	 FROM order_items)
GROUP BY oi.item_id
ORDER BY oi.item_id;

-- 3. List all the inventory that is stored in Mexico.
SELECT i.warehouse_id, p.product_id, p.product_name
FROM inventories i
JOIN products p USING(product_id)
WHERE i.warehouse_id IN 
	(SELECT w.warehouse_id 
	FROM warehouses w
    JOIN locations l USING (location_id)
	JOIN countries c USING (country_id)	
	WHERE c.country_name = 'Mexico');
    
-- 4. Rewrite the task above using a CTE.
WITH mexico_warehouses AS
(
	SELECT w.warehouse_id 
	FROM warehouses w
    JOIN locations l USING (location_id)
	JOIN countries c USING (country_id)	
	WHERE c.country_name = 'Mexico'
)
SELECT i.warehouse_id, p.product_id, p.product_name
FROM inventories i
JOIN products p USING(product_id)
JOIN mexico_warehouses USING (warehouse_id); 

-- 5. Count the number of orders_items that are higher than the average order_item amount
WITH amounts AS
(
	SELECT quantity * unit_price AS item_amount
	FROM order_items
)
SELECT COUNT(*) AS '# above average order items' 
FROM amounts
WHERE item_amount > (SELECT AVG(item_amount) FROM amounts);
    
-- 6. Calculate the average order amount.
-- 6.1.	Use CTE and create a table that sums the quantity * unit_price for each order. 
WITH amounts AS
(
	SELECT order_id, (quantity * unit_price) AS item_amount
	FROM order_items
)
SELECT SUM(item_amount) AS total_order_amount
FROM amounts
GROUP BY order_id;

-- 6.2.	Use the CTE to calculate the average for the orders
WITH item_amounts AS
(
	SELECT order_id, (quantity * unit_price) AS item_amount
	FROM order_items
),
order_totals AS
(
	SELECT order_id, SUM(item_amount) AS total_order_amount
	FROM item_amounts
	GROUP BY order_id
)
SELECT AVG(total_order_amount) AS 'Average order'
FROM order_totals;
 
-- 7. How many customers have a credit limit lower than the average?
SELECT COUNT(*) AS 'Low credit limit'
FROM customers
WHERE credit_limit <
	(SELECT AVG(credit_limit)
    FROM customers);