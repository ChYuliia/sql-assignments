# Assignment 12: Transactions, Locking, and Stored Procedures

This assignment covers implementing atomic database transactions (`START TRANSACTION`, `COMMIT`, `ROLLBACK`), controlling session autocommit behavior (`SET autocommit = 0`), handling runtime database errors via `SQLEXCEPTION` handlers, enforcing data integrity with `CHECK` constraints, and coding parameterized stored procedures in MySQL Workbench using *Murach's MySQL* concepts (Chapters 14 & 15).

---

## Database Overview

- **RDBMS / Tool:** MySQL 8.0 / MySQL Workbench
- **Sample Schemas:** Oracle Tutorial (`OT`) & `imdb`
- **Core Tables:** `locations`, `countries` (`OT`); `movies`, `actor`, `director` (`imdb`)

---

## Repository Structure

```text
Assignment_12_Transactions/
├── docs/
│   └── Transactions_Worksheet.pdf        # Submission report with SQL code, analysis, and output screenshots
├── scripts/
│   ├── 01_imdb_seed.sql                  # Creates and populates the initial flat IMDb dataset (50 rows)
│   ├── 02_imdb_add_pk.sql                # Adds an AUTO_INCREMENT primary key (movie_id)
│   ├── 03_imdb_normalize_tables.sql      # Normalizes actors and directors into separate tables and renames to 'movies'
│   └── 04_worksheet_transactions.sql     # Transaction control, exception handlers, CHECK constraint, and test calls
└── README.md
```
---

## Tasks Summary

- **Task 1: Debugging Transactions & Exception Handling (`OT` Schema)**  

  Diagnoses and repairs three defects in the starter procedure `adding_data()` on the `locations` table: declares the missing boolean flag (`SQL_ERROR BOOL DEFAULT FALSE`), adds an `EXIT HANDLER FOR SQLEXCEPTION` inside a nested `BEGIN ... END` block to trigger a `ROLLBACK` on runtime errors, and supplies the missing primary key (`location_id = 103`) in the third `INSERT` statement. Demonstrates `SET autocommit = 0` session behavior and confirms why an external `ROLLBACK` cannot undo changes once an internal `COMMIT` executes.

- **Task 2: Schema Normalization & Data Integrity Constraints (`imdb` Schema)**  

  Transforms a flat `mytable` import (`01_imdb_seed.sql`) into a normalized relational structure (`02_imdb_add_pk.sql`, `03_imdb_normalize_tables.sql`) by adding an `AUTO_INCREMENT` primary key (`movie_id`), extracting `actor` and `director` tables via `UNION ALL`, and renaming the base table to `movies`. Enforces domain integrity at the table level by adding a `CHECK` constraint (`movies_chk_imdb_score`) restricting `imdb_score` values to the `1`–`10` range.

- **Task 3: Parameterized Transactional Procedure & Rollback Validation (`imdb` Schema)**  

  Constructs the `UpdateAndAddMovie` procedure accepting an input parameter (`IN imdb_score_param DECIMAL(3,1)`) and wrapping three sequential DML operations—updating `imdb_score` for `movie_id IN (2, 3)`, increasing `movie_facebook_likes` by 10%, and inserting a new record (`movie_id = 9999`, *Children of Men*)—inside `START TRANSACTION` with a `CONTINUE HANDLER FOR SQLEXCEPTION`. Validates atomic behavior across two test calls: `CALL UpdateAndAddMovie(1);` commits all changes, whereas `CALL UpdateAndAddMovie(15);` violates `movies_chk_imdb_score` on the first `UPDATE` and rolls back the entire transaction.

---

## How to Run

### Using MySQL Workbench (GUI)
1. Open **MySQL Workbench** and establish a connection to your local MySQL server.
2. Ensure the Oracle Tutorial (`OT`) database schema is loaded (`USE ot;`), and create an empty `imdb` schema (`CREATE SCHEMA IF NOT EXISTS imdb; USE imdb;`) for the movie dataset.
3. Initialize and normalize the `imdb` schema by running the setup scripts in `scripts/` in numerical order using the **Execute (all or selection)** button:
   - `scripts/01_imdb_seed.sql`
   - `scripts/02_imdb_add_pk.sql`
   - `scripts/03_imdb_normalize_tables.sql`
4. Open `scripts/04_worksheet_transactions.sql` in a new SQL query tab and execute the script (or run each task block sequentially). Note that stored procedures utilize custom delimiters (`DELIMITER **` and `DELIMITER //`) to compile procedural blocks without premature termination.
5. Verify transaction status messages (`committed` vs. `rolled back`) and updated records in the Result Grid, and compare them against the screenshots and analysis documented in `docs/Transactions_Worksheet.pdf`.
