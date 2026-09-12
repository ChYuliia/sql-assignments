-- Yuliia Chernysheva
-- September 11, 2026
-- CSC 2268 - SQL PROGRAMMING
-- Chapter 4 of Murach's MySQL "How to retrieve data from two or more tables"

-- 3. List all the countries and their regions
SELECT c.country_name, r.region_name
FROM countries c
	JOIN regions r USING (region_id);
    
-- 4. What products are in inventory, how much inventory is there, and what are their categories?
-- For a product to be in inventory, the quantity must be greater than zero.  
-- 3 tables will be used. The default 1000 rows will be returned (unless you have changed the default).
SELECT p.product_name, pc.category_name, i.quantity
FROM products p
	JOIN inventories i USING (product_id)
    JOIN product_categories pc USING (category_id)    
WHERE i.quantity > 0;

-- 5. What products are in inventory, where are they located in inventory, and what are their categories?
-- Exclude products where the state is NULL.   Order by state.  925 rows returned.
SELECT p.product_name, pc.category_name, l.state
FROM products p
    JOIN inventories i USING (product_id)
    JOIN product_categories pc USING (category_id)
    JOIN warehouses w USING (warehouse_id)
    JOIN locations l USING (location_id)
WHERE i.quantity > 0 
  AND l.state IS NOT NULL
ORDER BY l.state;

-- 6. What products have customers purchased? 665 rows returned.
SELECT c.name, p.product_name 
FROM products p	
    JOIN order_items USING (product_id)    
    JOIN orders USING (order_id)
    JOIN customers c USING (customer_id);

-- Now show just the names of the products that have been purchased.
-- Order by product name. 216 rows returned.	 
SELECT distinct p.product_name
FROM products p	
    JOIN order_items USING (product_id)       
ORDER BY p.product_name;

-- 7. Of the items sold, which warehouses supplied the items?
-- Order by warehouse name.
SELECT distinct w.warehouse_name
FROM orders o
	JOIN order_items USING (order_id)    
    JOIN inventories i USING (product_id)
    JOIN warehouses w USING (warehouse_id)
ORDER BY w.warehouse_name;

-- 8. Which employees have sold something? 9 rows returned.
SELECT distinct e.first_name, e.last_name
FROM employees e
	JOIN orders o ON e.employee_id = o.salesman_id 
    JOIN order_items oi ON o.order_id = oi.order_id;

-- 9. Which employees do not have orders?
-- Order the list by last name. 97 rows returned.
SELECT e.first_name, e.last_name, o.order_id, o.salesman_id, e.employee_id
FROM employees e
	LEFT JOIN orders o ON e.employee_id = o.salesman_id 
WHERE o.salesman_id is NULL
ORDER BY e.last_name;

-- 10. Which products do not have orders? 32 rows returned.
SELECT p.product_name, oi.order_id
FROM products p
	LEFT JOIN order_items oi USING (product_id)
WHERE order_id is NULL;