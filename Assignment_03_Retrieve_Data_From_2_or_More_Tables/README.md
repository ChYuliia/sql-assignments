\# Assignment 03: Retrieve Data From 2 or More Tables



This assignment demonstrates multi-table relational queries, table joins, data filtering, and anti-join logic using MySQL Workbench.



\## Database Overview

\* \*\*RDBMS / Tool:\*\* MySQL / MySQL Workbench

\* \*\*Sample Schema:\*\* Oracle Tutorial (OT) Sample Database

\* \*\*Core Tables:\*\* `regions`, `countries`, `locations`, `warehouses`, `employees`, `product\_categories`, `products`, `customers`, `orders`, `order\_items`, `inventories`



The database diagram is located at `docs/Oracle Tutorial ERD.png`.
![ERD](docs/Oracle%20Tutorial%20ERD.png)


\---



\## Repository Structure



```text

Assignment_03_Retrieve_Data_From_2_or_More_Tables/

├── docs/

│   ├── Oracle Tutorial ERD.png            # Relational schema diagram

│   └── RetrievingData2\_Worksheet.pdf      # Submission report with queries and result grids

├── scripts/

│   ├── 01\_create\_Oracle\_Tutorial\_database.sql  # DDL schema creation script

│   ├── 02\_populate\_Oracle\_Tutorial\_tables.sql  # DML data population script

│   └── 03\_Worksheet\_Retrieving\_Data2.sql       # SQL solutions for tasks 3–10

└── README.md



\## Tasks Summary



\* \*\*Task 3: List all countries and their regions\*\*  

&#x20; Joins `countries` and `regions` using `region\_id` (25 rows returned).



\* \*\*Task 4: Products in inventory, stock levels, and categories\*\*  

&#x20; Joins `products`, `inventories`, and `product\_categories` with `quantity > 0` (1000 rows returned by default).



\* \*\*Task 5: Products in inventory, location, and categories\*\*  

&#x20; Multi-table join across `products`, `inventories`, `product\_categories`, `warehouses`, and `locations` filtering out `NULL` states and sorting by `state` (925 rows returned).



\* \*\*Task 6: Products purchased by customers\*\*  

&#x20; \* \*\*Part 1:\*\* Lists customers and their ordered products (665 rows returned).

&#x20; \* \*\*Part 2:\*\* Lists distinct names of purchased products ordered alphabetically (216 rows returned).



\* \*\*Task 7: Warehouses supplying sold items\*\*  

&#x20; Identifies distinct warehouses associated with sold items, ordered by warehouse name.



\* \*\*Task 8: Employees who have sold items\*\*  

&#x20; Finds distinct sales representatives with recorded order positions (9 rows returned).



\* \*\*Task 9: Employees without orders\*\*  

&#x20; Anti-join using `LEFT JOIN ... WHERE o.salesman\_id IS NULL`, ordered by last name (97 rows returned).



\* \*\*Task 10: Products without orders\*\*  

&#x20; Anti-join between `products` and `order\_items` to identify unpurchased items (32 rows returned).



\---



\## How to Run



1\. Open \*\*MySQL Workbench\*\* and connect to your database instance.

2\. Execute `scripts/01\_create\_Oracle\_Tutorial\_database.sql` to create all tables and foreign key constraints.

3\. Execute `scripts/02\_populate\_Oracle\_Tutorial\_tables.sql` to insert the sample data records.

4\. Run `scripts/03\_Worksheet\_Retrieving\_Data2.sql` to verify each query against the assignment tasks.

