--------------------------------------------------------------------------------------
-- Name       : DML Statements & Summary Queries Worksheet (Chapters 5 & 6)
-- Author     : Yuliia Chernysheva
-- Course     : CIS 2268 SQL Programming
--------------------------------------------------------------------------------------

-- 3. Update the table by changing the word "remote" to "virtual".
SET sql_safe_updates = 0;

UPDATE Sinclair
SET class_type = 'virtual'
WHERE class_type = 'REMOTE';

UPDATE Sinclair
SET location = 'virtual'
WHERE location = 'REMOTE';

SELECT * 
FROM Sinclair;

-- 4. Update RES 1301 to be only 1.5 credit hours.
UPDATE Sinclair
SET credit_hours = 1.5
WHERE deptShort = 'RES'
AND class_number = 1301;

SELECT * 
FROM Sinclair;

-- 5. Create a new table called Sinclair_copy from the Sinclair table.
CREATE TABLE Sinclair_copy AS
SELECT * 
FROM Sinclair;

SELECT *
FROM Sinclair_copy;

SET sql_safe_updates = 1; -- Turn safe updates back ON for safety
--------------------------------------------------------
--  For the rest of the assignment you will use the Oracle Tutorial database
--------------------------------------------------------
USE OT;

-- 6a. Sum the quantity of items in the inventories
SELECT sum(quantity) AS 'total items on hand'
FROM inventories;

-- 6b. Group the quantities by warehouse
SELECT warehouse_id, SUM(quantity) AS 'number of items per warehouse'
FROM warehouses	JOIN inventories USING(warehouse_id)
GROUP BY warehouse_id;
    
-- 7. Are there any nulls in the manager_id column in the employees table?
SELECT * 
FROM employees
WHERE manager_id is NULL;

-- 8. In the products table, what is the most expensive list item, 
--    the least expensive item, and what is the average list price?
SELECT MAX(list_price) AS 'highest price',
	MIN(list_price) AS 'lowest price', 
    AVG(list_price) AS 'average list price'
FROM products;

-- 9. Take the results from above and group by category name (not id)
SELECT 
	category_name, 
	MAX(list_price) AS 'highest price',
	MIN(list_price) AS 'lowest price', 
    AVG(list_price) AS 'average list price'
FROM products JOIN product_categories USING(category_id)
GROUP BY category_name;

-- 10. Use the statement above and add an average column for all items 
-- 1118.99 = the average of one selected list_price value from each category.
SELECT
    pc.category_name,
    MAX(p.list_price) AS 'highest price',
    MIN(p.list_price) AS 'lowest price',
    AVG(p.list_price) AS 'average price by category',
    AVG(ANY_VALUE(p.list_price)) OVER() AS 'average of selected prices'
FROM products p JOIN product_categories pc USING(category_id)
GROUP BY pc.category_name;

-- 903.24 = the average list price of all products. 
-- The window function calculates the average before the GROUP BY is applied.
SELECT DISTINCT 
	pc.category_name, 
	MAX(p.list_price) OVER category_window AS 'highest price',
	MIN(p.list_price) OVER category_window AS 'lowest price', 
    AVG(p.list_price) OVER category_window AS 'average list price',
    AVG(p.list_price) OVER() AS 'Average price of all products'
FROM products p JOIN product_categories pc USING(category_id)
WINDOW category_window AS (PARTITION BY category_name ORDER BY category_id);

-- 957.64 = the average of the four category averages. 
-- Each category has equal weight, regardless of the number of products in the category.
SELECT 
    c.category_name,
    MAX(p.list_price) AS 'highest price',
    MIN(p.list_price) AS 'lowest price',
    AVG(p.list_price) AS 'average list price',
    AVG(AVG(p.list_price)) OVER () AS 'average of category averages'
FROM products p JOIN product_categories c USING (category_id)
GROUP BY c.category_name;