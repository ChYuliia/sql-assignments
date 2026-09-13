# SQL Programming Coursework (Sinclair Community College)

This repository contains SQL coursework, assignments, and database exercises completed as part of the **CIS / SQL Programming** curriculum at **Sinclair Community College**, based on *Murach's MySQL*.

The projects cover practical relational database concepts ranging from single-table data filtering and scalar transformation to complex multi-table joins, anti-joins, schema creation, and database modeling.

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

* **Assignment 04: Upcoming Assignment**
  * **Schema:** TBD
  * **Key Concepts:** Summary queries, aggregate functions (`GROUP BY`, `HAVING`), subqueries.
  * **Status:** In Progress

---

## Execution Guide

Each assignment directory is completely self-contained with its own schema initialization scripts, data loads, and query solutions:

1. **Select an Assignment Directory:**  
   Navigate into the desired module directory (e.g., `Assignment_02_Retrieve_Data_From_a_Single_Table/` or `Assignment_03_Retrieve_Data_From_2_or_More_Tables/`).

2. **Initialize & Populate the Database:**  
   Open **MySQL Workbench** and execute the setup scripts located in the `scripts/` subfolder in numerical order:
   * Run the DDL script (`01_...sql`) to define the schema, create tables, and establish primary/foreign key constraints.
   * Run the DML script (`02_...sql`, if present) to seed the tables with sample records.

3. **Run Query Solutions:**  
   Open and execute the worksheet solution script (e.g., `02_Worksheet_Retrieving_Data.sql` or `03_Worksheet_Retrieving_Data2.sql`) to reproduce all task outputs and result grids.

4. **Verify Results:**  
   Compare the output sets against the compiled reports and execution screenshots available in the `docs/` folder of each module.
