# Assignment 11: Stored Programs and Procedural Logic

This assignment covers creating and executing stored procedures, managing custom statement delimiters (`DELIMITER //`), defining input parameters, declaring local variables, calculating business metrics via `SELECT ... INTO`, and implementing conditional branching (`IF ... ELSE`) in MySQL Workbench using *Murach's MySQL* concepts (Chapter 13).

---

## Database Overview

- **RDBMS / Tool:** MySQL 8.0 / MySQL Workbench
- **Sample Schema:** Oracle Tutorial (`OT`)
- **Core Tables:** `products`

---

The database diagram is located at `docs/Oracle Tutorial ERD.png`.

![ERD](docs/Oracle%20Tutorial%20ERD.png)

---

## Repository Structure

```text
Assignment_11_Stored_Programs/
├── docs/
│   ├── Stored_Programs_Worksheet.pdf     # Submission report with SQL statements and output screenshots
│   └── Oracle Tutorial ERD.png           # Relational schema ERD diagram
├── scripts/
│   └── 01_worksheet_stored_programs.sql  # Stored procedure definitions, parameter handling, and test calls
└── README.md
```
---

## Tasks Summary

- **Task 1: Basic Stored Procedure Definition & Execution**  
  Creates and executes a parameterless stored procedure (`first_procedure`) that returns a literal string message (`'I love MySQL'`), utilizing `DELIMITER //` management to handle statement boundaries within the `BEGIN ... END` block.

- **Task 2: Hardcoded Calculation & Conditional Control Flow**  
  Implements the `check_product_margin` procedure, declaring a local variable (`margin DECIMAL(9,4)`) and using `SELECT ... INTO` to calculate the profit ratio `(list_price - standard_cost) / list_price` for `product_id = 16`. Applies procedural branching (`IF ... ELSE`) against a `0.2` threshold to output either `'good margin'` or an alert message.

- **Task 3: Dynamic Parameterization & String Concatenation**  
  Constructs a reusable procedure (`calculate_product_margin`) accepting an input parameter (`IN product_id_in INT`). Evaluates dynamic product margins and builds diagnostic output messages using `CONCAT()` across multiple test executions (`product_id = 10` and `product_id = 16`).

---

## How to Run

### Using MySQL Workbench (GUI)
1. Open **MySQL Workbench** and establish a connection to your local MySQL server.
2. Ensure the Oracle Tutorial (`OT`) database schema is loaded and set as the default schema (`USE ot;`).
3. Open `scripts/01_Worksheet_Stored_Programs.sql` in a new SQL query tab.
4. Execute the script (or run each procedure block sequentially) using the **Execute (all or selection)** button. Note that statements utilize custom delimiters (`DELIMITER //`) to compile procedural blocks without premature termination.
5. Verify procedure execution outputs from the `CALL` statements in the Result Grid and compare against the screenshots and specifications documented in `docs/Stored_Programs_Worksheet.pdf`.
