# Assignment 09: Subqueries and Common Table Expressions

This assignment covers subqueries in `WHERE` clauses, scalar subqueries with aggregate functions (`AVG`), multi-table filtering using the `IN` operator and complex `JOIN` paths, and the design of single and multi-step Common Table Expressions (CTEs) using MySQL Workbench and Murach's MySQL concepts (Chapter 7).

## Database Overview

- **RDBMS / Tool:** MySQL / MySQL Workbench


- **Sample Schema:** Oracle Tutorial (`OT`)


- **Core Tables:** `order_items`, `products`, `warehouses`, `locations`, `countries`, `customers`


---

The database diagram is located at `docs/Oracle Tutorial ERD.png`.

![ERD](docs/Oracle%20Tutorial%20ERD.png)

---

## Repository Structure

```text
Assignment_09_Subqueries/
├── docs/
│   ├── Subqueries_Worksheet.docx              # Submission report with answers, code, and result screenshots
│   └── Oracle Tutorial ERD.png                # Relational schema ERD diagram
├── scripts/
│   └── 01_worksheet_subqueries.sql            # Subquery, CTE, and aggregated query solutions for worksheet tasks
└── README.md
```
---

## Tasks Summary

- **Task 1: Average Price Comparison and Grouping**  
  Calculates the overall average `unit_price` in `order_items`, then filters and groups items whose unit price exceeds the average, sorted by `item_id`.

- **Task 2: Product Name Join with Subquery Filtering**  
  Joins the filtered items query from Task 1 with the `products` table to display corresponding product names alongside item IDs and prices.

- **Task 3: Multi-Table Subquery Filtering**  
  Retrieves inventory stored in Mexico by chaining subqueries across `warehouses`, `locations`, and `countries` using the `IN` operator.

- **Task 4: CTE Refactoring for Warehouse Inventory**  
  Rewrites the Mexico inventory query using a Common Table Expression (`WITH`) to improve modularity and join readability.

- **Task 5: Above-Average Order Items Count**  
  Calculates the total amount (`quantity * unit_price`) for order items and counts how many individual items exceed the average order item amount using a CTE.

- **Task 6: Multi-CTE Order Amount Average Calculation**  
  Uses a multi-step CTE pipeline (`item_amounts` followed by `order_totals`) to compute the total sum per order and determine the overall average order amount.

- **Task 7: Low Credit Limit Customer Count**  
  Counts the total number of customers whose `credit_limit` falls below the calculated average credit limit across the customer base.

---

## How to Run

### Using MySQL Workbench (GUI)
1. Open **MySQL Workbench** and establish a connection to your local MySQL server.
2. Ensure the Oracle Tutorial (`OT`) database schema is loaded and available in your environment.
3. Open and execute `scripts/01_worksheet_subqueries.sql` to run all subquery, multi-table filter, and Common Table Expression (CTE) solutions sequentially.
4. Verify your live query results and result sets against the compiled worksheet report, task descriptions, and execution screenshots available in the `docs/` folder.
