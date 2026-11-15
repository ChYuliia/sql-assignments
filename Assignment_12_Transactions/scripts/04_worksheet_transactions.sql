/*******************************************************************************
 * Course:      CIS SQL Programming / Data Analytics
 * Topic:       Topic 12 (Chapters 14 & 15) - Transactions, Locking & Stored Procedures
 * Script:      04_worksheet_transactions.sql
 * Description: Implementation of atomic database transactions, autocommit control,
 *              SQLEXCEPTION handlers, CHECK constraints, and parameterized stored
 *              procedures using the 'ot' (Oracle Tutorial) and 'imdb' schemas.
 ******************************************************************************/

-- =============================================================================
-- TASK 1: ORACLE TUTORIAL (OT) DATABASE - TRANSACTION & ERROR HANDLING
-- =============================================================================
USE ot;

-- Inspect table structure and reference country codes before inserting records
DESCRIBE locations;
SELECT * FROM countries;

-- Disable autocommit to allow manual transaction control in the current session
SET autocommit=0;   

-- Check existing records in the target table
SELECT * FROM locations;

-- Drop the procedure if it already exists to allow clean re-creation
DROP PROCEDURE IF EXISTS adding_data;

DELIMITER **

/*
 * Procedure: adding_data()
 * Purpose:   Inserts three new location records into the 'locations' table as a
 *            single atomic unit of work.
 * Fixes applied to starter code:
 *   1. Declared local boolean flag 'SQL_ERROR' (default FALSE).
 *   2. Added 'EXIT HANDLER FOR SQLEXCEPTION' inside a nested block to catch errors.
 *   3. Supplied the missing primary key value (103) in the third INSERT statement.
 */
CREATE PROCEDURE adding_data()
BEGIN
	DECLARE SQL_ERROR BOOL DEFAULT FALSE;
    BEGIN
		DECLARE EXIT HANDLER FOR SQLEXCEPTION 
			SET SQL_ERROR = TRUE;			
		INSERT INTO locations
			VALUES(101,'101 First Street','45402','Dayton','OH','NL');
		INSERT INTO locations
			VALUES(102,'102 Second Street','45402','Dayton','OH','US');
		INSERT INTO locations
			VALUES(103,'102 Third Street','45402','Dayton','OH','US');
	END;
    
    -- Commit changes if all statements succeeded; otherwise, roll back
	IF SQL_ERROR = FALSE THEN 
		COMMIT;
		SELECT 'THE TRANSACTION WAS COMMITTED';
	ELSE
		ROLLBACK;
		SELECT 'THE TRANSACTION WAS ROLLED BACK';
	END IF;
END**
DELIMITER ;

-- Execute the stored procedure
CALL adding_data();

-- Execute the stored procedure
ROLLBACK;

-- Restore autocommit to default state
SET autocommit = 1;

-- =============================================================================
-- TASK 2: IMDB DATABASE - CHECK CONSTRAINT & PARAMETERIZED TRANSACTION
-- =============================================================================
USE imdb;

-- Enforce valid IMDb rating bounds (1.0 to 10.0) at the table level
ALTER TABLE movies
ADD CONSTRAINT movies_chk_imdb_score
	CHECK (imdb_score BETWEEN 1 AND 10);
    
-- Drop the procedure if it already exists
DROP PROCEDURE IF EXISTS UpdateAndAddMovie;

DELIMITER // 

/*
 * Procedure: UpdateAndAddMovie(imdb_score_param)
 * Purpose:   Executes three related DML operations within an explicit transaction:
 *              1. Updates 'imdb_score' for movie_id 2 and 3 to the passed parameter.
 *              2. Increases 'movie_facebook_likes' by 10% across all movies.
 *              3. Inserts a new movie record (movie_id = 9999, 'Children of Men').
 *            Rolls back the entire transaction if any statement violates constraints
 *            or raises a SQLEXCEPTION.
 */
CREATE PROCEDURE UpdateAndAddMovie
(
	imdb_score_param	DECIMAL(3,1)
)
BEGIN
	DECLARE sql_error BOOL DEFAULT FALSE;
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION	
		SET sql_error = TRUE;
        
	START TRANSACTION;
    
    -- Statement 1: Update IMDb score for specific movies
    -- NOTE: This statement fails when imdb_score_param = 15 (violates movies_chk_imdb_score: 1 to 10)
	UPDATE movies 
    SET imdb_score = imdb_score_param
    WHERE movie_id IN (2,3);   
    
    -- Statement 2: Increase Facebook likes by 10%
    UPDATE movies
    SET movie_facebook_likes = movie_facebook_likes * 1.1;    
    
    -- Statement 3: Insert new movie record
    INSERT INTO movies (movie_id,genres,movie_title,cast_total_facebook_likes,imdb_score,movie_facebook_likes)
    VALUES (9999,'apocalypse','Children of Men',25000,10,1000000);
    
    -- Commit if no exceptions occurred; otherwise, roll back all changes
    IF sql_error = FALSE THEN
		COMMIT;
        SELECT 'The transaction was committed.';
	ELSE
		ROLLBACK;
        SELECT 'The transaction was rolled back.';
	END IF;
END // 

DELIMITER ;

-- Test Case 1: Valid score (1) -> Passes CHECK constraint and commits transaction
call UpdateAndAddMovie(1);

-- Test Case 2: Out-of-range score (15) -> Triggers SQLEXCEPTION and rolls back transaction
call UpdateAndAddMovie(15);

SELECT * FROM  movies 
    WHERE movie_id IN (2,3);


