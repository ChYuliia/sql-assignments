USE ot;

SET autocommit = 0;

-- 1. Create a view of the employees table
-- Limit the view to just employees whose first name starts with a S or T. 
-- Sort the results by last name, descending. 
CREATE OR REPLACE VIEW view_employees_s_t AS
	SELECT employee_id, first_name, last_name 
	FROM employees
	WHERE first_name REGEXP "^[S,T]"
	ORDER BY last_name DESC;
    
SELECT * 
FROM view_employees_s_t;

-- 2. Create a view from the order_items table.
-- Multiply the quantity by the unit_price and name the column "total".  
-- Limit the output to the top 15 totals.
CREATE OR REPLACE VIEW view_top_15_order_items_total AS
	SELECT order_id, item_id, quantity * unit_price AS Total 
	FROM order_items
	ORDER BY Total DESC
	LIMIT 15;
    
SELECT * 
FROM view_top_15_order_items_total;

-- 3. Create a view of joined tables.
-- Join warehouses to locations to countries 
-- to get the list of where the warehouses are.
CREATE OR REPLACE VIEW view_warehouse_locations AS
	SELECT w.warehouse_name, l.city, l.state, c.country_name
	FROM warehouses w
	JOIN locations l USING (location_id)
	JOIN countries c USING (country_id);

SELECT *
FROM view_warehouse_locations;

-- 4. Using the view,  
-- update the city of the Bombay warehouse to "North Bombay".
UPDATE view_warehouse_locations
SET city = "North Bombay"
WHERE city = "Bombay";

SELECT *
FROM view_warehouse_locations;

-- 5. Create a view that calculates the profit by product name from the products table.
-- Profit is the list price minus the cost. Name the column "profit".
CREATE OR REPLACE VIEW product_profit AS
	SELECT product_name, (list_price - standard_cost) AS profit
	FROM products;

SELECT *
FROM product_profit;

-- 6. Using the view update the profit for the "Crucial" product to 1000.
-- What happened?  Look up the error code and explain
UPDATE product_profit
SET profit = 1000
WHERE product_name = "Crucial";

/*
What happened:
The query failed with Error Code: 1348 (Column 'profit' is not updatable).

Explanation:
Because profit is derived from a calculation, MySQL cannot determine how 
to update the original columns (list_price or standard_cost), 
making this column read-only.
*/

-- 7. Create a view of the quantity in the warehouses.
-- Include the product_id, product_name, warehouse_id, quantity.  
-- Only show those quantities that are less than 5.  Add a CHECK option.
CREATE OR REPLACE VIEW low_stock_warehouses AS
	SELECT i.product_id, p.product_name, w.warehouse_id, i.quantity
	FROM warehouses w
	JOIN inventories i USING (warehouse_id)
	JOIN products p USING (product_id)
	WHERE quantity < 5
WITH CHECK OPTION;
    
SELECT *
FROM low_stock_warehouses;

-- 8. Using the above view, try to update the "Crucial" product by changing the quantity to 10.
-- What happened and why?
UPDATE low_stock_warehouses
SET quantity = 10
WHERE product_name = "Crucial";

SELECT *
FROM low_stock_warehouses;

-- 9. Create a view that displays the region_id and region_name from the regions table.
-- Using the view, add Iceland, region_id=10 to the table.
-- Using the view delete Iceland from the table.
CREATE VIEW view_regions AS 
	SELECT region_id, region_name
	FROM regions;
    
INSERT INTO view_regions
	(region_id, region_name)
VALUES
	(10, "Iceland");
    
SELECT *
FROM view_regions;

DELETE FROM view_regions
WHERE region_id = 10;

SELECT *
FROM view_regions;

-- 10. Clean up your database
-- Did your ROLLBACK work or did you have to reload the script to build the database?
ROLLBACK;

-- Option A: If everything looks correct, make the changes permanent
COMMIT;

-- Option B: If you made an error, undo everything back to step 1
