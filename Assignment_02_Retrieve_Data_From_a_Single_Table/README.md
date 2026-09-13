# Assignment 02: Retrieve Data From a Single Table

This assignment covers foundational SQL querying techniques against a single table, focusing on filtering, pattern matching, scalar functions, calculated columns, and sorting using MySQL Workbench.

## Database Overview

* **RDBMS / Tool:** MySQL / MySQL Workbench
* **Database:** `imdb`
* **Table:** `mytable` (Movie attributes including titles, duration, genres, release year, IMDB scores, and social media metrics)

---

## Repository Structure

```text
Assignment_02_Retrieve_Data_From_a_Single_Table/
├── docs/
│   ├── Retrieving_Data_Worksheet.pdf     # Output report with queries and execution grids
│   └── Indeed_database.xlsx              # Reference dataset
├── scripts/
│   ├── 01_IMDB_script.sql                # DDL & DML script to create and populate table
│   └── 02_Worksheet_Retrieving_Data.sql  # SQL solutions for tasks 1–13
└── README.md
```
## Tasks Summary

* **Task 1: Full table retrieval**  
  Selects all columns and rows from `mytable`.

* **Task 2: Year filtering**  
  Retrieves movies released in `2013` using `WHERE title_year = 2013`.

* **Task 3: Duration threshold**  
  Filters movies with runtime greater than 160 minutes using `WHERE duration > 160`.

* **Task 4: Compound filtering**  
  Combines multiple conditions using boolean logic: `WHERE title_year = 2013 AND duration > 160`.

* **Task 5: Null handling**  
  Identifies records missing runtime data using `WHERE duration IS NULL`[cite: 5].

* **Task 6: Pattern matching & numeric filters**  
  Filters titles starting with 'A' or 'T' using Regular Expressions (`REGEXP '^[AT]'`) combined with `imdb_score > 8`.

* **Task 7: Discrete list matching & sorting**  
  Filters specific release years using `IN (2008, 2012, 2015)` sorted in descending order (`ORDER BY title_year DESC`).

* **Task 8: Calculated columns & aliasing**  
  Calculates a 20% increase on duration (`duration * 1.2`) aliased as `Duration with ads`.

* **Task 9: String concatenation**  
  Concatenates actor names with engagement metrics using `CONCAT()` for specified release years.

* **Task 10: String manipulation**  
  Extracts leading substring characters using `LEFT(movie_title, 3)`.

* **Task 11: Numeric rounding**  
  Rounds ratings to the nearest integer using scalar `ROUND(imdb_score)`.

* **Task 12: Duplicate elimination**  
  Extracts unique country names while excluding missing values (`DISTINCT` and `IS NOT NULL`).

* **Task 13: Range filtering**  
  Retrieves titles with ratings within a closed interval using `BETWEEN 5 AND 8` (57 rows returned).

---

## How to Run

1. Open **MySQL Workbench** and connect to your database server.
2. Execute `scripts/01_IMDB_script.sql` to initialize the `imdb` database and populate `mytable`.
3. Execute `scripts/02_Worksheet_Retrieving_Data.sql` to verify each query against the worksheet requirements.

