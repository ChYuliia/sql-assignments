# SQL Programming Coursework (Sinclair Community College)

This repository contains SQL coursework, assignments, and database exercises completed as part of the **CIS / SQL Programming** curriculum at **Sinclair Community College**, based on *Murach's MySQL*.

The projects cover practical relational database concepts ranging from single-table data filtering and scalar transformation to complex multi-table joins, DML data modifications, summary queries, aggregate window functions, and database modeling.

---

## Technical Stack & Environment

* **RDBMS:** MySQL 8.0
* **IDE / Client:** MySQL Workbench
* **Textbook Reference:** *Murach's MySQL* (by Joel Murach)
* **Dialect:** ANSI / MySQL SQL

---

## Repository Structure

```text
sql_assignments/
│
├── Assignment_02_Retrieve_Data_From_a_Single_Table/
│   ├── docs/
│   │   ├── Retrieving_Data_Worksheet.pdf
│   │   └── Indeed_database.xlsx
│   ├── scripts/
│   │   ├── 01_IMDB_script.sql
│   │   └── 02_Worksheet_Retrieving_Data.sql
│   └── README.md
│
├── Assignment_03_Retrieve_Data_From_2_or_More_Tables/
│   ├── docs/
│   │   ├── Oracle Tutorial ERD.png
│   │   └── RetrievingData2_Worksheet.pdf
│   ├── scripts/
│   │   ├── 01_create_Oracle_Tutorial_database.sql
│   │   ├── 02_populate_Oracle_Tutorial_tables.sql
│   │   └── 03_Worksheet_Retrieving_Data2.sql
│   └── README.md
│
├── Assignment_04_DML_and_Summary_Queries/
│   ├── docs/
│   │   ├── DML_Statements_Worksheet.pdf
│   │   └── Oracle Tutorial ERD.png
│   ├── scripts/
│   │   ├── 01_create_Sinclair_db.sql
│   │   └── 02_Worksheet_DML_Statements.sql
│   └── README.md
│
├── Assignment_06_Functions_and_Window_Functions/
│   ├── docs/
│   │   └── Functions_Worksheet.pdf
│   │   └── Oracle Tutorial ERD.png
│   ├── scripts/
│   │   └── 01_Worksheet_Functions.sql
│   └── README.md
└── README.md
```
---

## Coursework & Modules

* **Assignment 02: Retrieve Data from a Single Table (Murach Ch. 3)**
  * **Schema:** `imdb` (`mytable`)
  * **Key Concepts:** Column expressions, arithmetic operations, `WHERE`, `IN`, `BETWEEN`, `REGEXP`, scalar functions (`ROUND`, `LEFT`, `CONCAT`), `IS NULL`, `ORDER BY`.
  * **Status:** Completed

* **Assignment 03: Retrieve Data from Two or More Tables (Murach Ch. 4)**
  * **Schema:** Oracle Tutorial (`OT`)
  * **Key Concepts:** `INNER JOIN`, `LEFT JOIN`, anti-joins (`WHERE ... IS NULL`), multi-table traversal, table aliasing, `USING` vs `ON`, `DISTINCT`, foreign key integrity.
  * **Status:** Completed

* **Assignment 04: DML Statements and Summary Queries (Murach Ch. 5 & 6)**
  * **Schema:** `Sinclair_db` & Oracle Tutorial (`OT`)
  * **Key Concepts:** DML operations (`INSERT`, `UPDATE`, `DELETE`, safe updates configuration), summary queries, aggregate functions (`SUM`, `AVG`, `MAX`, `MIN`, `COUNT`), `GROUP BY`, `HAVING` vs `WHERE`, aggregate window functions (`OVER`, `PARTITION BY`), frames (`ROWS`/`RANGE`), and named windows.
  * **Status:** Completed

* **Assignment 06: Functions, Conditional Expressions, and Window Functions (Murach Ch. 9)**
  * **Schema:** Oracle Tutorial (`OT`), `employees`, `customers`, `products`, `orders`
  * **Key Concepts:** String functions (`CONCAT`, `LEFT`, `LOCATE`), numeric formatting and rounding (`FORMAT`, `ROUND`), date/time functions (`DAYNAME`, `YEAR`), control flow logic (`IF`, `CASE`), and ranking window functions (`RANK`, `DENSE_RANK` with `OVER`).
  * **Status:** Completed
---

# Execution Guide

Each assignment directory in this repository is completely self-contained with its own schema initialization scripts, sample data loads, and documented query solutions. Follow the steps below to set up and run any module locally in **MySQL Workbench**.

---

## Step-by-Step Instructions

### 1. Select an Assignment Directory
Navigate into the desired module directory (e.g.,  
`Assignment_02_Retrieve_Data_From_a_Single_Table/`,  
`Assignment_03_Retrieve_Data_From_2_or_More_Tables/`,   
`Assignment_04_DML_and_Summary_Queries/`, or  
`Assignment_06_Functions_and_Window_Functions/`).

### 2. Initialize & Populate the Database
Open **MySQL Workbench** and execute the setup scripts located in the `scripts/` subfolder in numerical order:
* **Run the Schema/DDL script** (e.g., `01_...sql`) first to define the database schema, create tables, and establish primary/foreign key constraints.
* **Run subsequent data load or setup scripts** (e.g., `02_...sql` / `03_...sql`) if required by the specific module to populate sample records.

### 3. Run Query Solutions
Open and execute the worksheet solution script (e.g., `02_Worksheet_Retrieving_Data.sql`, `03_Worksheet_Retrieving_Data2.sql`, or `02_Worksheet_DML_Statements.sql`) to reproduce all task outputs, updates, and result grids.

### 4. Verify Results
Compare your live execution output sets against the compiled reports, worksheets, and execution screenshots available in the `docs/` folder of each module.

---

## Pro-Tips for MySQL Workbench
* Make sure your active connection is connected to your local MySQL server instance.
* Always check that the correct database is selected or set as default using the `USE database_name;` command before running queries.
* For modules involving `UPDATE` or `DELETE` statements (such as Assignment 04), ensure safe updates configuration (`SET sql_safe_updates = 0; / SET sql_safe_updates = 1;`) is managed properly around your transaction blocks.
