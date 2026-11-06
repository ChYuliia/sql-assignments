/*******************************************************************************
 * Course: CIS SQL Programming / Data Analytics
 * Topic: Topic 11 (Chapter 13) - Stored Programs (Procedures & Control Flow)
 * Script: stored_programs_worksheet.sql
 * Description: Implementation of basic stored procedures, input parameters,
 *              local variable declarations, and IF-ELSE conditional logic 
 *              using the 'ot' (Oracle sample) database in MySQL.
 ******************************************************************************/
 USE ot;

-- =============================================================================
-- Task 1: Basic Stored Procedure
-- Objective: Write a procedure named 'first_procedure' that displays a simple 
--            message, then execute the procedure.
-- =============================================================================
DROP PROCEDURE IF EXISTS first_procedure;

DELIMITER //

CREATE PROCEDURE first_procedure()
BEGIN
	-- Return a simple literal string with an alias
	SELECT 'I love MySQL' AS message;
END //

DELIMITER ;

-- Execute procedure
CALL first_procedure();

-- =============================================================================
-- Task 2: Hardcoded Calculation & Conditional Logic
-- Objective: Calculate profit margin for product_id = 16.
-- Formula:   (list_price - standard_cost) / list_price
-- Threshold: If margin > 0.2 -> 'good margin', else -> 'not good margin'
-- =============================================================================
DROP PROCEDURE IF EXISTS check_product_margin;

DELIMITER //

CREATE PROCEDURE check_product_margin()
BEGIN
	-- Declare local variable with fixed precision for currency/ratio calculations
    DECLARE margin DECIMAL(9,4);
    
    -- Retrieve calculated margin into local variable
	SELECT (list_price - standard_cost) / list_price 
		INTO margin
	FROM products
	WHERE product_id = 16;
    
    -- Evaluate condition and display corresponding result message
    IF margin > 0.2 THEN
		SELECT 'good margin' AS message;
	ELSE
		SELECT '16 does not have a good margin' AS message;
	END IF;
END //

DELIMITER ;

-- Execute procedure for product 16
CALL check_product_margin();

-- =============================================================================
-- Task 3: Parameterized Stored Procedure
-- Objective: Rewrite procedure to accept dynamic product ID as an IN parameter.
-- Calls:     Execute for product_id = 10 and product_id = 16.
-- Note:      Computed margin for product 10 reflects current database state
--            (calculated dynamically from base table prices).
-- =============================================================================
DROP PROCEDURE IF EXISTS calculate_product_margin;

DELIMITER //

CREATE PROCEDURE calculate_product_margin(in product_id_in int)
BEGIN
	-- Declare local variable for calculated ratio
    DECLARE margin DECIMAL(9,4);
    
    -- Calculate margin for the given product ID passed as input
	SELECT (list_price - standard_cost) / list_price 
		INTO margin
	FROM products
	WHERE product_id = product_id_in;
    
    -- Output concatenated diagnostic message based on margin threshold
    IF margin > 0.2 THEN
		SELECT concat(product_id_in,' has a good margin of ', margin) AS message;
	ELSE
		SELECT concat(product_id_in, ' does not good margin') AS message;
	END IF;
END //

DELIMITER ;

-- Execute procedure for products 10 and 16
CALL calculate_product_margin(10);
CALL calculate_product_margin(16);

-- test
DELIMITER //