# Assignment 03: Retrieve Data From 2 or More Tables

This assignment demonstrates multi-table relational queries, table joins, data filtering, and anti-join logic using MySQL Workbench.

## Database Overview

* **RDBMS / Tool:** MySQL / MySQL Workbench
* **Sample Schema:** Oracle Tutorial (OT) Sample Database
* **Core Tables:** `regions`, `countries`, `locations`, `warehouses`, `employees`, `product_categories`, `products`, `customers`, `orders`, `order_items`, `inventories`

The database diagram is located at `docs/Oracle Tutorial ERD.png`.

![ERD](docs/Oracle%20Tutorial%20ERD.png)

---

## Repository Structure

```text
Assignment_03_Retrieve_Data_From_2_or_More_Tables/
├── docs/
│   ├── Oracle Tutorial ERD.png                 # Relational schema diagram
│   └── RetrievingData2_Worksheet.pdf           # Submission report with queries and result grids
├── scripts/
│   ├── 01_create_Oracle_Tutorial_database.sql   # DDL schema creation script
│   ├── 02_populate_Oracle_Tutorial_tables.sql   # DML data population script
│   └── 03_Worksheet_Retrieving_Data2.sql        # SQL solutions for tasks 3–10
└── README.md
```
## Tasks Summary

* **Task 3: List all countries and their regions**  
  Joins `countries` and `regions` using `region_id` (25 rows returned).

* **Task 4: Products in inventory, stock levels, and categories**  
  Joins `products`, `inventories`, and `product_categories` with `quantity > 0` (1000 rows returned by default).

* **Task 5: Products in inventory, location, and categories**  
  Multi-table join across `products`, `inventories`, `product_categories`, `warehouses`, and `locations` filtering out `NULL` states and sorting by `state` (925 rows returned).

* **Task 6: Products purchased by customers**  
  * **Part 1:** Lists customers and their ordered products (665 rows returned).
  * **Part 2:** Lists distinct names of purchased products ordered alphabetically (216 rows returned).

* **Task 7: Warehouses supplying sold items**  
  Identifies distinct warehouses associated with sold items, ordered by warehouse name.

* **Task 8: Employees who have sold items**  
  Finds distinct sales representatives with recorded order positions (9 rows returned).

* **Task 9: Employees without orders**  
  Anti-join using `LEFT JOIN ... WHERE o.salesman_id IS NULL`, ordered by last name (97 rows returned).

* **Task 10: Products without orders**  
  Anti-join between `products` and `order_items` to identify unpurchased items (32 rows returned).

