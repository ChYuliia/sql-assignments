/*******************************************************************************
- Course:      CIS 2268 - SQL Programming / Data Analytics
- Topic:       Topic 13 (Chapter 16) - Transactions and Triggers
- Script:      01_worksheet_triggers_events.sql
- Description: Demonstrates manual transaction control with error handling inside
-              a stored procedure, and implements BEFORE/AFTER UPDATE triggers
-              for inventory warnings and employee job title history auditing.
 ******************************************************************************/

USE ot;

-- =============================================================================
-- TASK 1: TRANSACTION CONTROL IN A STORED PROCEDURE
-- =============================================================================

-- Disable autocommit to allow manual transaction control in the current session
SET autocommit=0; 

-- Create a stored procedure that inserts records within a transaction
-- and outputs whether the changes were committed or rolled back  
DROP PROCEDURE IF EXISTS test_insert;

DELIMITER //

CREATE PROCEDURE test_insert()
BEGIN
	DECLARE sql_error BOOL DEFAULT FALSE;
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
		SET sql_error = TRUE;
        
	START TRANSACTION;   
    
    -- Insert 2 valid records
    INSERT INTO locations (location_id, address, postal_code, city, state, country_id)
    VALUES (27, 'to delete', 'postal', 'Dayton', 'OH', 'US');
    INSERT INTO locations (location_id, address, postal_code, city, state, country_id)
    VALUES (28, 'to delete', 'postal', 'Dayton', 'OH', 'US');
    -- Insert 1 duplicate record to trigger a primary key constraint error (Error 1062)
	INSERT INTO locations (location_id, address, postal_code, city, state, country_id)
    VALUES (27, 'to delete', 'postal', 'Dayton', 'OH', 'OH');    
    
    IF sql_error = FALSE THEN
		COMMIT;
        SELECT 'THE TRANSACTION WAS COMMITTED';
	ELSE
		ROLLBACK;
        SELECT 'THE TRANSACTION WAS ROLLED BACK';
	END IF;
END //

DELIMITER ;

-- Execute the stored procedure and verify that rolled-back rows were not saved
CALL test_insert;

SELECT * FROM locations WHERE location_id IN (27,28);

-- Restore default autocommit behavior for subsequent tasks
SET autocommit = 1;

-- =============================================================================
-- TASK 2: BEFORE UPDATE TRIGGER (INVENTORY LOW-STOCK WARNING)
-- =============================================================================

-- 1. Add the inv_warning column to the inventories table
ALTER TABLE inventories
ADD COLUMN inv_warning VARCHAR(20);

-- 2. Create a trigger to flag low inventory (< 50) upon record updates
DROP TRIGGER IF EXISTS inventories_before_update;

DELIMITER //

CREATE TRIGGER inventories_before_update
	BEFORE UPDATE ON inventories
    FOR EACH ROW
BEGIN
	IF NEW.quantity < 50 THEN
		SET NEW.inv_warning = 'LOW INVENTORY';
	ELSE
		SET NEW.inv_warning = NULL;
    END IF;  
END //

DELIMITER ;

-- 3. Decrease quantity by 30 for product_id = 2 and warehouse_id = 6
UPDATE inventories
SET quantity = quantity - 30
WHERE product_id = 2 
  AND warehouse_id = 6;

-- 4. Verify the trigger output
SELECT * 
FROM inventories
WHERE product_id = 2 
  AND warehouse_id = 6;
  
-- =============================================================================
-- TASK 3: AFTER UPDATE TRIGGER (JOB TITLE CHANGE AUDIT LOG)
-- =============================================================================

-- 1. Create an empty audit table based on the employees table structure
DROP TABLE IF EXISTS old_job_titles;

CREATE TABLE old_job_titles AS 
SELECT * FROM employees
WHERE 1 = 0;

-- 2. Remove unnecessary contact columns from the audit table
ALTER TABLE old_job_titles
DROP COLUMN phone,
DROP COLUMN email;

-- 3. Add a timestamp column to track when the job title was updated
ALTER TABLE old_job_titles
ADD COLUMN updated_at DATETIME;

-- Verify the structure of the new audit table
SELECT * 
FROM old_job_titles;

-- 4. Create a trigger to archive previous employee details only when job_title changes
DROP TRIGGER IF EXISTS employees_after_update;

DELIMITER //

CREATE TRIGGER employees_after_update
	AFTER UPDATE ON employees
    FOR EACH ROW
BEGIN
	 IF NOT(NEW.job_title <=> OLD.job_title) THEN
		INSERT INTO old_job_titles (
            employee_id,
            first_name,
            last_name,
            hire_date,
            manager_id,
            job_title,
            updated_at
        )VALUES
		(OLD.employee_id, OLD.first_name, OLD.last_name, OLD.hire_date,
		OLD.manager_id, OLD.job_title, NOW());
	END IF;
END //

DELIMITER ;

-- 5. Update an employee's job title and verify both tables
UPDATE employees 
SET job_title = 'Stock Assistant'
WHERE employee_id = 26;

SELECT * 
FROM employees
WHERE employee_id = 26;

SELECT * 
FROM old_job_titles;

-- Execute the stored procedure
ROLLBACK;

-- Restore autocommit to default state
SET autocommit = 1;