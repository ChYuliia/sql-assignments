--------------------------------------------------------------------------------------
-- Name       : Functions (Chapters 9)
-- Author     : Yuliia Chernysheva
-- Course     : CIS 2268 SQL Programming
--------------------------------------------------------------------------------------
USE ot;

-- 1. Calculate the total for each order_item (quantity * unit_price) and format the total to two digits
SELECT order_id, FORMAT(quantity * unit_price, 2) AS total 
FROM order_items;

-- 2. Using the employees table, concatenate the first to the last name with a comma, then the job_title
SELECT CONCAT_WS(', ', (CONCAT_WS(' ', first_name, last_name)), job_title) AS 'Employee/Title'
FROM employees;

-- 3. Using employees table, generate a login name according to these rules
SELECT UPPER(CONCAT(
				LEFT(first_name,1), 
				last_name, 
				LPAD(TRUNCATE(RAND()*100, 0), 2, '0')
		)) AS Login 
FROM employees;

-- 4. Using the customer table, what is the longest address?
SELECT MAX(LENGTH(address)) AS 'the longest address'
FROM customers;

-- 5. Using the customers table, locate the first comma in the address column whose name starts with a letter O
SELECT name AS NAME, LOCATE(',', address)
FROM customers
WHERE REGEXP_LIKE(name, '^O');

-- 6. Using the products table, subtract standard cost from list price and round the total to zero decimal places
SELECT product_name, 
       ROUND(list_price-standard_cost, 0) AS profit 
FROM products;

-- 7. Take your birthdate and display the day of the week you were born
SELECT DAYNAME(str_to_date('17.03.1981', '%d.%m.%Y')) AS 'My birth day of the week';

-- 8. Use the CASE function to add an action item for each of the statuses in the order tables
SELECT order_id, customer_id, status, 
       CASE status
           WHEN 'Shipped' THEN 'send invoice'
           When 'Pending' THEN 'OK'
           WHEN 'Canceled' THEN 'follow up'
       END AS 'action needed'        
FROM orders;

-- 9. Use the IF statement to add a column to the query results showing whether a country is US or not
-- Show all locations
SELECT location_id, country_id,
       IF(country_id='US', 'Domestic', 'International') AS Travel
FROM locations;

-- 10. Using the employees table, calculate the number of years from hire date to now
SELECT hire_date, 
       CURRENT_DATE AS 'current_date',
       Year(CURRENT_DATE()) - YEAR(hire_date)  AS 'length of employment'
FROM employees;

-- 11. Create a query that displays the rank and dense rank for the credit limit of customers
SELECT RANK() OVER (ORDER BY credit_limit DESC) AS 'rank', 
       DENSE_RANK() OVER(ORDER BY credit_limit DESC) AS 'dense rank',
       credit_limit, customer_id, name
FROM customers;