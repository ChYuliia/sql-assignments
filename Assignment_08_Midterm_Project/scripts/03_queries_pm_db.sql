--------------------------------------------------------------------------------------
-- Name       : Complex Queries and Data Analytics (Project Management Database)
-- Author     : Yuliia Chernysheva
-- Course     : CIS 2268 SQL Programming
--------------------------------------------------------------------------------------

USE pm_db;

-- ===================================================================================
-- SECTION 11: AGGREGATE FUNCTIONS AND GROUP BY CLAUSES
-- Demonstrating SUM, AVG, COUNT, MIN, MAX, and HAVING filter capabilities.
-- ===================================================================================

-- 1. SUM and AVG with GROUP BY
-- Business Purpose: Evaluates total and average financial allocation across project statuses.
SELECT status, 
	round(sum(budget),2) AS total_budget,
    round(avg(budget),2) AS avg_budget
FROM projects
GROUP BY status;

-- 2. COUNT with GROUP BY
-- Business Purpose: Calculates total headcount assigned to each organizational department.
SELECT d.department_name, 
	COUNT(e.employee_id) AS total_employees
FROM employees e
JOIN departments d USING (department_id)
GROUP BY d.department_id, d.department_name;

-- 3. MIN and MAX with GROUP BY
-- Business Purpose: Identifies the compensation spread (minimum and maximum hourly rates) per department.
SELECT d.department_name, 
	MAX(e.hourly_rate) AS max_hourly_rate, 
    MIN(e.hourly_rate) AS min_hourly_rate
FROM employees e
JOIN departments d USING (department_id)
GROUP BY d.department_id, d.department_name;

-- 4. HAVING clause with GROUP BY
-- Business Purpose: Filters for high-effort projects that accumulated over 10 total logged hours.
SELECT p.project_id,
	p.project_name, 
    SUM(tl.hours_spent) AS total_hours_spent
FROM tasks t
JOIN time_logs tl USING (task_id)
JOIN projects p USING (project_id)
GROUP BY p.project_id, p.project_name
HAVING total_hours_spent > 10;

-- ===================================================================================
-- SECTION 12: DATA FILTERING, SORTING, ARITHMETIC, AND SCALAR FUNCTIONS
-- Demonstrating criteria filtering, text concatenation, string, and math functions.
-- ===================================================================================

-- a) Range Criteria (BETWEEN)
-- Retrieves employees earning an hourly rate within the $40.00 to $60.00 range.
SELECT employee_id, first_name, last_name, hourly_rate
FROM employees
WHERE hourly_rate BETWEEN 40.00 AND 60.00;

-- b) IN Operator
-- Filters active projects matching specific strategic workflow states.
SELECT project_code, project_name, status
FROM projects
WHERE status IN ('In Progress', 'Planning', 'On Hold')
ORDER BY status;

-- c) LIKE Operator (Compound OR logic)
-- Searches for employees whose last name starts with 'W' OR who possess corporate email accounts.
SELECT employee_id, first_name, last_name, email
FROM employees
WHERE last_name LIKE 'W%'
	OR email LIKE '%@techcorp.com';

-- d) Column Aliases & Sorting
-- Displays full staff names alongside custom-labeled compensation columns.
SELECT CONCAT(first_name,' ',last_name) AS 'Full Name',
	hourly_rate AS 'Hourly Rate ($)'
FROM employees
ORDER BY last_name, first_name;

-- e) Basic Arithmetic Operations
-- Projects expected financial expense by multiplying estimated hours by the assigned employee's rate.
SELECT t.task_id, t.task_title, e.hourly_rate, t.estimated_hours,
	ROUND( e.hourly_rate * t.estimated_hours, 2) AS estimated_task_cost
FROM tasks t
JOIN employees e ON t.assigned_to = e.employee_id 
ORDER BY t.task_id;

-- f) String Concatenation
-- Combines discrete first and last name fields into a unified full name string.
SELECT CONCAT(first_name,' ',last_name) AS 'Full Name'
FROM employees
ORDER BY last_name, first_name;

-- g) DISTINCT Keyword
-- Extracts a unique list of corporate clients without duplication.
SELECT DISTINCT client_name
FROM projects
ORDER BY client_name;

-- h) Sorting Output (ORDER BY DESC)
-- Orders the portfolio from highest to lowest allocated budget.
SELECT project_code, project_name, budget
FROM projects
ORDER BY budget DESC;

-- i) NULL Values Handling
-- Identifies ongoing projects lacking an end date OR team members without assigned managers.
SELECT p.project_code, p.project_name, p.end_date, e.manager_id
FROM projects p
LEFT JOIN employees e ON p.lead_employee_id = e.employee_id
WHERE p.end_date IS NULL 
	OR e.manager_id IS NULL;

-- j) Date Extraction (MONTH)
-- Extracts the numerical hire month for employee tenure analytics.
SELECT CONCAT(first_name, ' ',last_name) AS full_name,
	hire_date,
	MONTH(hire_date) AS hire_month
FROM employees
ORDER BY hire_month;

-- k) SUBSTR Function
-- Extracts the leading 3-character prefix from unique project codes.
SELECT project_code, 
	SUBSTR(project_code, 1 ,3) AS project_prefix
FROM projects;

-- l) String Length (LENGTH)
-- Calculates character length of project titles for data validation.
SELECT project_name, 
	LENGTH(project_name) AS project_name_length
FROM projects
ORDER BY project_name_length DESC;

-- m) Numeric Rounding (ROUND to 1 decimal place)
-- Computes average organizational hourly rate rounded strictly to 1 decimal place.
SELECT ROUND(AVG(hourly_rate), 1) AS avg_hourly_rate_rounded
FROM employees;

-- ===================================================================================
-- SECTION 13: CONDITIONAL SELECTION AND NULL TRANSFORMATION
-- Demonstrating CASE statements and IFNULL conditional functions.
-- ===================================================================================

-- a) CASE Statement
-- Categorizes project portfolio into budget tiers for executive decision-making.
SELECT project_name, budget,
	CASE 
		WHEN budget > 100000 THEN 'High Budget'
        WHEN budget BETWEEN 50000 AND 100000 THEN 'Medium Budget'
        ELSE 'Low Budget'
	END AS budget_category
FROM  projects
ORDER BY budget DESC;

-- b) IFNULL Function
-- Replaces unassigned project end dates with descriptive operational statuses.
SELECT project_code, status, 
	IFNULL(end_date, 'In Progress / Ongoing') AS actual_end_date
FROM projects;

-- ===================================================================================
-- SECTION 14: MULTI-TABLE JOINS AND SET OPERATIONS
-- Demonstrating INNER JOIN, LEFT JOIN, multi-table relationships, and UNION.
-- ===================================================================================

-- a) Join 3 Tables with Filtering
-- Connects projects, tasks, and employees to review high-priority task assignments.
SELECT p.project_name, t.task_title, t.priority, 
	CONCAT(e.first_name, ' ', e.last_name) AS assigned_employee
FROM tasks t
JOIN projects p USING(project_id)
JOIN employees e ON t.assigned_to = e.employee_id
WHERE t.priority IN ('Critical', 'High')
ORDER BY t.priority;

-- b) LEFT OUTER JOIN
-- Displays all employees regardless of whether they currently have assigned tasks.
SELECT CONCAT(e.first_name, ' ', e.last_name) AS full_name,
	t.task_title
FROM employees e
LEFT JOIN tasks t ON e.employee_id = t.assigned_to 
ORDER BY full_name;

-- c) INNER JOIN
-- Links employee records with department entities to output organizational roles.
SELECT CONCAT(e.first_name, ' ', e.last_name) AS full_name,
	d.department_name, e.hourly_rate
FROM employees e
INNER JOIN departments d USING(department_id)
ORDER BY d.department_name;

-- d) Set Operation (UNION)
-- Combines client names and department titles into a single unified directory.
SELECT client_name AS entity_name, 'Client' AS entity_type
FROM projects
UNION 
SELECT department_name AS entity_name, 'Department' AS entity_type
FROM departments
ORDER BY entity_name;