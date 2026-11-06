# Assignment 10: Views and Transaction Management

This assignment covers creating and querying database views, updating base tables through views, enforcing data integrity using `WITH CHECK OPTION`, handling non-updatable derived expressions, and analyzing transaction behavior under DDL-triggered implicit commits using MySQL Workbench and *Murach's MySQL* concepts (Chapter 12).

## Database Overview

- **RDBMS / Tool:** MySQL 8.0 / MySQL Workbench

- **Sample Schema:** Oracle Tutorial (`OT`)

- **Core Tables:** `employees`, `order_items`, `warehouses`, `locations`, `countries`, `products`, `inventories`, `regions`

---

The database diagram is located at `docs/Oracle Tutorial ERD.png`.

![ERD](docs/Oracle%20Tutorial%20ERD.png)

---

## Repository Structure

```text
Assignment_10_Views_and_Transactions/
├── docs/
│   ├── Views_Worksheet.pdf              # Submission report with answers, code, error codes, and result screenshots
│   └── Oracle Tutorial ERD.png          # Relational schema ERD diagram
├── scripts/
│   └── 01_worksheet_views.sql           # Complete view definitions, DML modifications, and transaction tests
└── README.md
```
---

## Tasks Summary

- **Task 1: Employees Name Filtering and Sorting**  
  Creates a view on the `employees` table filtering records whose first name starts with 'S' or 'T' using regular expressions (`REGEXP '^[S,T]'`), sorted by `last_name DESC`.

- **Task 2: Top Line-Item Total Value Calculation**  
  Defines a view on `order_items` that calculates the total amount per item (`quantity * unit_price AS Total`) and isolates the top 15 highest transactions using `ORDER BY Total DESC LIMIT 15`.

- **Task 3: Multi-Table Warehouse Location Directory**  
  Constructs a relational view joining `warehouses`, `locations`, and `countries` via natural key bindings (`USING (location_id)`, `USING (country_id)`) to map warehouse facilities to their cities, states, and nations.

- **Task 4: Base Table Data Modification via View Abstraction**  
  Updates the city for the Bombay facility to 'North Bombay' directly through the `view_warehouse_locations` view, demonstrating DML propagation to underlying base tables.

- **Task 5: Product Profit Margin Calculation**  
  Builds the `product_profit` view from the `products` table computing unit margin (`list_price - standard_cost AS profit`) for each catalog item.

- **Task 6: Derived Column Immutability Evaluation (Error 1348)**  
  Attempts to update the calculated profit column through the view (`UPDATE product_profit SET profit = 1000 WHERE product_name = 'Crucial'`), triggering `Error Code: 1348` and verifying that derived expressions without direct physical column mapping remain strictly read-only.

- **Task 7: Warehouse Inventory Threshold View with CHECK OPTION**  
  Creates a multi-table inventory monitoring view (`low_stock_warehouses`) joining `warehouses`, `inventories`, and `products` for quantities strictly under 5 (`WHERE quantity < 5`), appending `WITH CHECK OPTION` to enforce domain integrity.

- **Task 8: Constraint Enforcement via WITH CHECK OPTION (Error 1369)**  
  Attempts to update a Crucial inventory record to a quantity of 10 through the view, triggering `Error Code: 1369 (CHECK OPTION failed)` due to violating the boundary predicate defined in the view schema.

- **Task 9: Simple View DML Insertion and Deletion Pipeline**  
  Creates a lightweight view on `regions` (`region_id`, `region_name`) and executes sequential `INSERT` and `DELETE` operations for region 10 ('Iceland') via view queries.

- **Task 10: Transaction Management & Implicit DDL Commit Analysis**  
  Evaluates transaction rollbacks under `SET autocommit = 0;`, documenting that intermediate DDL statements (`CREATE OR REPLACE VIEW`) trigger implicit `COMMIT` operations that permanently persist changes and render subsequent `ROLLBACK` commands ineffective.

---

## How to Run

### Using MySQL Workbench (GUI)
1. Open **MySQL Workbench** and establish a connection to your local MySQL server.
2. Ensure the Oracle Tutorial (`OT`) database schema is loaded and set as the default schema (`USE ot;`).
3. Ensure transaction autocommit behavior is controlled before executing DML tests (`SET autocommit = 0;`).
4. Open and execute `scripts/01_worksheet_views.sql` to execute view definitions, query selections, DML updates, `WITH CHECK OPTION` constraint tests, and transaction statements sequentially.
5. Verify your live query results, view projections, and expected error code outputs (`Error Code: 1348` and `Error Code: 1369`) against the compiled worksheet report, task explanations, and execution screenshots available in `docs/Views_Worksheet.pdf`.
