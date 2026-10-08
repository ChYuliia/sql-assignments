# Assignment 06: Functions, Conditional Expressions, and Window Functions

This assignment demonstrates advanced scalar functions, string manipulation, numeric formatting, date and time calculations, control flow logic (`IF`, `CASE`), and ranking window functions (`RANK`, `DENSE_RANK`) using MySQL Workbench and Murach's MySQL concepts.

## Database Overview

* **RDBMS / Tool:** MySQL / MySQL Workbench
* **Sample Schema:** Oracle Tutorial (`OT`) Sample Database & core enterprise tables (`employees`, `customers`, `products`, `orders`, `order_items`, `locations`)
* **Core Tables:** `order_items`, `employees`, `customers`, `products`, `orders`, `locations`

---

The database diagram is located at `docs/Oracle Tutorial ERD.png`.

![ERD](docs/Oracle%20Tutorial%20ERD.png)

---

## Repository Structure

```text
Assignment_06_Functions_and_Window_Functions/
├── docs/
│   └── Functions_Worksheet.pdf               # Submission report with queries and result grids
│   └── Oracle Tutorial ERD.png               # Relational schema
├── scripts/
│   └── 01_Worksheet_Functions.sql            # SQL solutions for functions, conditional expressions, and window functions
└── README.md
```
---

# Tasks Summary

* **Task 1: Order Item Total Calculation & Formatting**  
  Calculates the total cost for each order item (`quantity * unit_price`) and formats the resulting monetary value to two decimal places using the `FORMAT()` function.

* **Task 2: Employee Name and Title Concatenation**  
  Concatenates employee first and last names separated by a comma, followed by their job title using `CONCAT_WS()`.

* **Task 3: Dynamic Employee Login Generation**  
  Generates a standardized uppercase login name by combining the first letter of the employee's first name, their last name, and a randomized two-digit number (`LEFT()`, `CONCAT()`, `LPAD()`, `RAND()`, `UPPER()`).

* **Task 4: Longest Customer Address Analysis**  
  Finds the maximum character length among all customer street addresses in the `customers` table (`MAX(LENGTH())`).

* **Task 5: Comma Position in Customer Addresses (Names Starting with 'O')**  
  Locates the position of the first comma in the address column specifically for companies whose name starts with the letter 'O' (`LOCATE()`, `REGEXP_LIKE()`).

* **Task 6: Product Profit Calculation & Rounding**  
  Calculates product profit by subtracting standard cost from list price and rounds the result to zero decimal places (`ROUND()`).

* **Task 7: Birthdate Day of the Week Extraction**  
  Converts a date string into a date format and extracts the corresponding day of the week (`DAYNAME()`, `STR_TO_DATE()`).

* **Task 8: Conditional Order Action Assignment (`CASE`)**  
  Uses the `CASE` control flow function to assign operational action items based on order statuses (e.g., "send invoice" for shipped, "OK" for pending, "follow up" for canceled).

* **Task 9: Location Classification (`IF`)**  
  Uses the `IF` conditional statement to add a status column classifying location records as 'Domestic' (for US) or 'International' (for all other countries).

* **Task 10: Employee Employment Tenure Calculation**  
  Calculates the length of employment in full years from each employee's hire date to the current date (`YEAR()`, `CURRENT_DATE()`).

* **Task 11: Customer Credit Limit Ranking (`RANK` & `DENSE_RANK`)**  
  Applies advanced window functions (`RANK()` and `DENSE_RANK()`) ordered by customer credit limit across all customer records.

---

## How to Run

### Using MySQL Workbench (GUI)
1. Open **MySQL Workbench** and establish a connection to your local MySQL server.
2. Ensure the Oracle Tutorial (`OT`) database—containing core tables such as `order_items`, `employees`, `customers`, `products`, `orders`, and `locations`—is installed and active on your local instance.
3. Open and execute `scripts/01_Worksheet_Functions.sql` sequentially. Make sure the correct database context (`USE OT;`) is set before running queries involving scalar functions, string manipulation, numeric formatting, conditional logic (`IF`, `CASE`), date calculations, and ranking window functions (`RANK`, `DENSE_RANK`).
4. Verify your live results against the compiled report and execution screenshots available in the `docs/` folder.
