\# Assignment 02: Retrieve Data From a Single Table



This assignment covers foundational SQL querying techniques against a single table, focusing on filtering, pattern matching, scalar functions, calculated columns, and sorting using MySQL Workbench.



\## Database Overview

\* \*\*RDBMS / Tool:\*\* MySQL / MySQL Workbench

\* \*\*Database:\*\* `imdb`

\* \*\*Table:\*\* `mytable` (Movie attributes including titles, duration, genres, release year, IMDB scores, and social media metrics)



\---



\## Repository Structure



```text

Assignment\_02\_Retrieve\_Data\_From\_a\_Single\_Table/

├── docs/

│   ├── Retrieving\_Data\_Worksheet.pdf      # Output report with queries and execution grids

│   └── Indeed\_database.xlsx              # Reference dataset

├── scripts/

│   ├── 01\_IMDB\_script.sql                # DDL \& DML script to create and populate table

│   └── 02\_Worksheet\_Retrieving\_Data.sql  # SQL solutions for tasks 1–13

└── README.md



\## Tasks Summary



\* \*\*Task 1: Full table retrieval\*\*  

&#x20; Selects all columns and rows from `mytable`\[cite: 5, 7].



\* \*\*Task 2: Year filtering\*\*  

&#x20; Retrieves movies released in `2013` using `WHERE title\_year = 2013`\[cite: 5, 7].



\* \*\*Task 3: Duration threshold\*\*  

&#x20; Filters movies with runtime greater than 160 minutes using `WHERE duration > 160`\[cite: 5, 7].



\* \*\*Task 4: Compound filtering\*\*  

&#x20; Combines multiple conditions using boolean logic: `WHERE title\_year = 2013 AND duration > 160`\[cite: 5, 7].



\* \*\*Task 5: Null handling\*\*  

&#x20; Identifies records missing runtime data using `WHERE duration IS NULL`\[cite: 5, 7].



\* \*\*Task 6: Pattern matching \& numeric filters\*\*  

&#x20; Filters titles starting with 'A' or 'T' using Regular Expressions (`REGEXP '^\[AT]'`) combined with `imdb\_score > 8`\[cite: 5, 7].



\* \*\*Task 7: Discrete list matching \& sorting\*\*  

&#x20; Filters specific release years using `IN (2008, 2012, 2015)` sorted in descending order (`ORDER BY title\_year DESC`)\[cite: 5, 7].



\* \*\*Task 8: Calculated columns \& aliasing\*\*  

&#x20; Calculates a 20% increase on duration (`duration \* 1.2`) aliased as `Duration with ads`\[cite: 5, 7].



\* \*\*Task 9: String concatenation\*\*  

&#x20; Concatenates actor names with engagement metrics using `CONCAT()` for specified release years\[cite: 5, 7].



\* \*\*Task 10: String manipulation\*\*  

&#x20; Extracts leading substring characters using `LEFT(movie\_title, 3)`\[cite: 5, 7].



\* \*\*Task 11: Numeric rounding\*\*  

&#x20; Rounds ratings to the nearest integer using scalar `ROUND(imdb\_score)`\[cite: 5, 7].



\* \*\*Task 12: Duplicate elimination\*\*  

&#x20; Extracts unique country names while excluding missing values (`DISTINCT` and `IS NOT NULL`)\[cite: 5, 7].



\* \*\*Task 13: Range filtering\*\*  

&#x20; Retrieves titles with ratings within a closed interval using `BETWEEN 5 AND 8` (57 rows returned)\[cite: 5, 7].



\---



\## How to Run



1\. Open \*\*MySQL Workbench\*\* and connect to your database server.

2\. Execute `scripts/01\_IMDB\_script.sql` (or `IMDB script.sql`) to initialize the `imdb` database and populate `mytable`\[cite: 6].

3\. Execute `scripts/02\_Worksheet\_Retrieving\_Data.sql` to verify each query against the worksheet requirements\[cite: 5].

