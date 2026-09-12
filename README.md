\# SQL Programming Coursework (Sinclair Community College)



This repository contains SQL coursework, assignments, and database exercises completed as part of the \*\*CIS / SQL Programming\*\* curriculum at \*\*Sinclair Community College\*\*, based on \*Murach's MySQL\*.



The projects cover practical relational database concepts ranging from single-table data filtering and scalar transformation to complex multi-table joins, anti-joins, schema creation, and database modeling.



\---



\## Technical Stack \& Environment



\* \*\*RDBMS:\*\* MySQL 8.0

\* \*\*IDE / Client:\*\* MySQL Workbench

\* \*\*Textbook Reference:\*\* \*Murach's MySQL\* (by Joel Murach)

\* \*\*Dialect:\*\* ANSI / MySQL SQL



\---



\## Repository Structure



```text

sql\_assignments/

│

├── Assignment\_02\_Retrieve\_Data\_From\_a\_Single\_Table/

│   ├── docs/                                  # Worksheet report (PDF) and reference dataset

│   ├── scripts/                               # Table DDL/DML script and solutions

│   └── README.md                              # Module-specific documentation

│

├── Assignment\_03\_Retrieve\_Data\_From\_2\_or\_More\_Tables/

│   ├── docs/                                  # ERD diagram and worksheet report (PDF)

│   ├── scripts/                               # Schema creation, seed data, and solutions

│   └── README.md                              # Module-specific documentation

│

└── README.md                                  # Root repository overview



\## Coursework \& Modules



| Assignment | Topic / Textbook Chapter | Database Schema | Key Concepts \& Techniques | Status |

| :--- | :--- | :--- | :--- | :---: |

| \*\*Assignment 02\*\* | How to Retrieve Data from a Single Table (\*Murach\* Ch. 3) | `imdb` (`mytable`) | Column expressions, arithmetic operations, `WHERE`, `IN`, `BETWEEN`, `REGEXP`, scalar functions (`ROUND`, `LEFT`, `CONCAT`), `IS NULL`, `ORDER BY` | Completed |

| \*\*Assignment 03\*\* | How to Retrieve Data from Two or More Tables (\*Murach\* Ch. 4) | Oracle Tutorial (`OT`) | `INNER JOIN`, `LEFT JOIN`, anti-joins (`WHERE ... IS NULL`), multi-table traversal, table aliasing, `USING` vs `ON`, `DISTINCT`, integrity constraints | Completed |

| \*\*Assignment 04\*\* | \*Upcoming Assignment\* | \*TBD\* | \*Summary queries, aggregate functions (`GROUP BY`, `HAVING`), subqueries\* | In Progress |



\---



\## Execution Guide



Each assignment folder is completely self-contained with its own schema initialization scripts, data loads, and query solutions:



1\. \*\*Select an Assignment Directory:\*\*  

&#x20;  Navigate into the desired module directory (e.g., `Assignment\_02\_Retrieve\_Data\_From\_a\_Single\_Table/` or `Assignment\_03\_Retrieve\_Data\_From\_2\_or\_More\_Tables/`).



2\. \*\*Initialize \& Populate the Database:\*\*  

&#x20;  Open \*\*MySQL Workbench\*\* and execute the setup scripts located in the `scripts/` subfolder in numerical order:

&#x20;  \* Run the DDL script (`01\_...sql`) to define the schema, create tables, and establish primary/foreign key constraints.

&#x20;  \* Run the DML script (`02\_...sql`, if present) to seed the tables with sample records.



3\. \*\*Run Query Solutions:\*\*  

&#x20;  Open and execute the worksheet solution script (e.g., `03\_Worksheet\_Retrieving\_Data.sql`) to reproduce all task outputs and result grids.



4\. \*\*Verify Results:\*\*  

&#x20;  Compare the output sets against the compiled reports and execution screenshots available in the `docs/` folder of each module.

