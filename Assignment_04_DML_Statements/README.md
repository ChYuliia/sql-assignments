# Assignment 04: DML Statements and Summary Queries

This assignment demonstrates data modification language (DML) operations, summary queries, aggregate functions, grouping, filtering with HAVING, and aggregate window functions using MySQL Workbench and Murach's MySQL concepts.

## Database Overview

* **RDBMS / Tool:** MySQL / MySQL Workbench
* **Sample Schema:** `Sinclair_db` (custom student table) & Oracle Tutorial (`OT`) Sample Database
* **Core Tables:** `Sinclair`, `Sinclair_copy`, `inventories`, `warehouses`, `employees`, `products`, `product_categories`

The database diagram is located at `docs/Oracle Tutorial ERD.png`.

![ERD](docs/Oracle%20Tutorial%20ERD.png)

---

## Repository Structure

```text
Assignment_04_DML_and_Summary_Queries/
├── docs/
│   ├── DML_Statements_Worksheet.pdf          # Submission report with queries and result grids
│   └── Oracle Tutorial ERD.png               # Relational schema diagram
├── scripts/
│   ├── 01_create_Sinclair_db.sql             # DDL & DML script for custom Sinclair table
│   └── 02_Worksheet_DML_Statements.sql       # SQL solutions for DML and summary tasks
└── README.md
```
---

# Tasks Summary

* **Task 1 & 2: Table Creation and Data Population (Sinclair_db)**  
  Creates a custom Sinclair table with specified columns and populates it with student courses and additional required classes.

* **Task 3: Safe Updates and Data Modification**  
  Disables safe updates (sql_safe_updates = 0) and updates records to change the text "REMOTE" to "virtual" for class types and locations.

* **Task 4: Specific Record Update**  
  Updates credit hours to 1.5 specifically for the RES 1301 class.

* **Task 5: Table Duplication**  
  Creates a backup/copy table named Sinclair_copy using the CREATE TABLE ... AS SELECT statement.

* **Task 6: Inventory Summaries (Oracle Tutorial DB)**  
  * **Part A:** Calculates the total sum of item quantities on hand in the inventories table.
  * **Part B:** Groups and aggregates inventory quantities by each warehouse ID.

* **Task 7: Management Hierarchy Analysis**  
  Identifies records with NULL in the manager_id column of the employees table and explains the organizational hierarchy structure (the company president).

* **Task 8: Global Product Price Statistics**  
  Calculates the highest list price, lowest list price, and overall average list price across all products in a single statement.

* **Task 9: Categorized Product Statistics**  
  Groups the price statistics (MAX, MIN, AVG) by product category name via table joins.

* **Task 10: Advanced Summary & Window Functions**  
  Extends category-level aggregates by incorporating advanced window functions (OVER(), ANY_VALUE(), nested AVG(), or named windows) to display global benchmarks and compare category performance against overall averages.

---

## How to Run

### Using MySQL Workbench (GUI)
1. Open **MySQL Workbench** and establish a connection to your local MySQL server.
2. Open and execute `scripts/01_create_Sinclair_db.sql` to initialize the custom `Sinclair_db` database, create the table, and populate initial data.
3. Open `scripts/02_Worksheet_DML_Statements.sql`, ensure you switch to the required database contexts (`USE Sinclair_db;` then `USE OT;`), and execute scripts sequentially. Ensure safe updates settings are properly handled around `UPDATE` statements.
4. Verify your live results against the compiled report and execution screenshots available in the `docs/` folder.
