# Assignment 13: Triggers and Events

This assignment covers implementing atomic transaction control inside stored procedures (`SET autocommit = 0`, `START TRANSACTION`, `COMMIT`, `ROLLBACK` with `SQLEXCEPTION` handlers) and building automated row-level `BEFORE UPDATE` and `AFTER UPDATE` database triggers (`FOR EACH ROW`) in MySQL Workbench using *Murach's MySQL* concepts (Chapter 16).

---

## Database Overview

- **RDBMS / Tool:** MySQL 8.0 / MySQL Workbench
- **Sample Schema:** Oracle Tutorial (`OT`)
- **Core Tables:** `locations`, `inventories`, `employees`, `old_job_titles`

---

## Repository Structure

```text
Assignment_13_Triggers_and_Events/
├── docs/
│   └── Triggers_and_Events_Worksheet.pdf       # Submission report with SQL code and output screenshots
├── scripts/
│   └── 01_worksheet_triggers_events.sql        # Transaction procedure, BEFORE/AFTER UPDATE triggers, and test queries
└── README.md
```
---

## Tasks Summary

- **Task 1: Transaction Control & Rollback Validation (`locations` Table)**  
  Disables session autocommit (`SET autocommit = 0`) and implements the stored procedure `test_insert()` on the `locations` table using a boolean error flag (`DECLARE sql_error BOOL DEFAULT FALSE`) paired with a `DECLARE CONTINUE HANDLER FOR SQLEXCEPTION`. Wraps two valid `INSERT` statements (`location_id` `27` and `28`) followed by an intentional duplicate primary key insert (`location_id = 27`, Error 1062) inside `START TRANSACTION`. Validates atomic rollback behavior by confirming the status output (`THE TRANSACTION WAS ROLLED BACK`) and querying `locations` to verify that neither record persisted.

- **Task 2: `BEFORE UPDATE` Low-Inventory Warning Trigger (`inventories` Table)**  
  Modifies the `inventories` table structure by adding an `inv_warning VARCHAR(20)` status column (`ALTER TABLE ... ADD COLUMN`). Implements the row-level trigger `inventories_before_update` (`BEFORE UPDATE ON inventories FOR EACH ROW`) evaluating `NEW.quantity < 50` to automatically populate `NEW.inv_warning` with `'LOW INVENTORY'` or reset it to `NULL` when stock is replenished. Tests the trigger by decreasing `quantity` by `30` for `product_id = 2` and `warehouse_id = 6` (reducing stock to `28`) and verifying the updated warning flag.

- **Task 3: `AFTER UPDATE` Job Title Audit Trigger (`employees` & `old_job_titles` Tables)**  
  Creates an empty history table `old_job_titles` modeled on `employees` (`CREATE TABLE ... AS SELECT * FROM employees WHERE 1 = 0`), drops contact columns (`phone`, `email`), and adds an `updated_at DATETIME` audit timestamp. Builds the row-level trigger `employees_after_update` (`AFTER UPDATE ON employees FOR EACH ROW`) using the null-safe comparison operator (`NOT (NEW.job_title <=> OLD.job_title)`) so historical records are archived only when `job_title` actually changes. Verifies trigger execution by updating `employee_id = 26` (*Leon Powell*) from `'Stock Clerk'` to `'Stock Assistant'` and confirming that the prior title and timestamp (`NOW()`) are logged in `old_job_titles`.

---

## How to Run

### Using MySQL Workbench (GUI)
1. Open **MySQL Workbench** and establish a connection to your local MySQL server.
2. Ensure the Oracle Tutorial (`OT`) database schema is loaded and selected as the active schema (`USE ot;`).
3. Open `scripts/01_worksheet_triggers_events.sql` in a new SQL query tab and execute the script sequentially by task block using the **Execute (all or selection)** button:
   - **Task 1:** Disables autocommit (`SET autocommit = 0`), compiles `test_insert()` using a custom delimiter (`DELIMITER //`), executes the procedure, and verifies that the duplicate key insert triggers a `ROLLBACK` (`locations` IDs `27` and `28` remain absent).
   - **Task 2:** Adds the `inv_warning` column to `inventories`, compiles `inventories_before_update`, decreases stock for `product_id = 2` and `warehouse_id = 6` by `30`, and verifies the `'LOW INVENTORY'` flag.
   - **Task 3:** Creates the empty audit table `old_job_titles`, compiles `employees_after_update`, updates `job_title` for `employee_id = 26`, and confirms the archived title and timestamp in `old_job_titles`.
4. Verify all status messages, updated records, and audit log entries in the Result Grid, and compare them against the SQL code and execution screenshots documented in `docs/Triggers_and_Events_Worksheet.pdf`.
