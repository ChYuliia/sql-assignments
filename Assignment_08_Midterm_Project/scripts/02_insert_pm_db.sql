--------------------------------------------------------------------------------------
-- Name       : Insert Data, Table Duplication, and Updates (Project Management)
-- Author     : Yuliia Chernysheva
-- Course     : CIS 2268 SQL Programming
--------------------------------------------------------------------------------------

USE pm_db;

-- ===================================================================================
-- SECTION 9: INSERT TEST DATA (At least 10 records in major tables)
-- ===================================================================================

-- 1. insert departments (5 records)
INSERT INTO departments VALUES
	(DEFAULT, 'Executive', 'Columbus - HQ', 500000.00),
	(DEFAULT, 'Software Engineering', 'Cincinnati - Tech Hub', 1200000.00),
	(DEFAULT, 'Quality Assurance', 'Cincinnati - Tech Hub', 350000.00),
	(DEFAULT, 'Marketing & Design', 'Dayton - Creative Office', 450000.00),
	(DEFAULT, 'Human Resources', 'Columbus - HQ', 250000.00);
    
-- 2. insert employees (12 records: Managers first, then staff)
-- insert Executives & Department Managers (manager_id = NULL)
INSERT INTO employees VALUES
	(DEFAULT,'Alexander', 'Wright', 'a.wright@techcorp.com', 85.00, 1, NULL, '2020-01-15', 1), 
	(DEFAULT,'Sophia', 'Chen', 's.chen@techcorp.com', 65.00, 2, 1, '2021-03-10', 1),           
	(DEFAULT,'Marcus', 'Vance', 'm.vance@techcorp.com', 55.00, 3, 1, '2021-06-01', 1),         
	(DEFAULT,'Emily', 'Watson', 'e.watson@techcorp.com', 50.00, 4, 1, '2022-02-15', 1),
    (DEFAULT,'Daniel', 'Miller', 'd.miller@techcorp.com', 45.00, 2, 2, '2022-05-10', 1),   
	(DEFAULT,'Olivia', 'Taylor', 'o.taylor@techcorp.com', 42.00, 2, 2, '2023-01-20', 1),   
	(DEFAULT,'Liam', 'Anderson', 'l.anderson@techcorp.com', 38.00, 3, 3, '2023-04-11', 1), 
	(DEFAULT,'Ava', 'Martinez', 'a.martinez@techcorp.com', 35.00, 3, 3, '2023-08-01', 1),  
	(DEFAULT,'Ethan', 'Thomas', 'e.thomas@techcorp.com', 40.00, 4, 4, '2024-01-15', 1),    
	(DEFAULT,'Isabella', 'White', 'i.white@techcorp.com', 30.00, 5, 1, '2024-03-01', 1),   
	(DEFAULT,'Lucas', 'Harris', 'l.harris@techcorp.com', 48.00, 2, 2, '2024-05-12', 1),   
	(DEFAULT,'Mia', 'Clark', 'm.clark@techcorp.com', 25.00, 5, 1, '2025-02-01', 0);         

-- 3. insert projects (10 records)
INSERT INTO projects VALUES
	(DEFAULT,'PRJ-2026-A', 'Enterprise ERP Portal', 'Nexus Global Corp', 150000.00, '2026-01-10', '2026-08-30', 'In Progress', 2),
	(DEFAULT,'PRJ-2026-B', 'Mobile Banking App Redesign', 'Apex Financial', 85000.00, '2026-02-01', '2026-06-15', 'In Progress', 2),
	(DEFAULT,'PRJ-2026-C', 'Cloud Infrastructure Migration', 'DataTech Systems', 120000.00, '2025-09-01', '2026-01-20', 'Completed', 1),
	(DEFAULT,'PRJ-2026-D', 'AI Customer Analytics Dashboard', 'RetailPulse Inc', 95000.00, '2026-03-15', '2026-11-30', 'In Progress', 2),
	(DEFAULT,'PRJ-2026-E', 'HR Automation Platform', 'Internal Operations', 40000.00, '2026-04-01', '2026-07-31', 'Planning', 4),
	(DEFAULT,'PRJ-2026-F', 'E-Commerce Payment Gateway', 'ShopQuick Inc', 110000.00, '2026-05-01', NULL, 'Planning', 2),
	(DEFAULT,'PRJ-2026-G', 'Security Audit & Compliance', 'Apex Financial', 30000.00, '2025-11-01', '2025-12-20', 'Completed', 3),
	(DEFAULT,'PRJ-2026-H', 'Brand Rebranding Campaign', 'Nexus Global Corp', 60000.00, '2026-02-15', '2026-05-31', 'On Hold', 4),
	(DEFAULT,'PRJ-2026-I', 'Legacy System Decommissioning', 'Internal Operations', 25000.00, '2026-01-01', '2026-03-01', 'Cancelled', 1),
	(DEFAULT,'PRJ-2026-J', 'IoT Smart Warehouse Portal', 'LogiTrans Logistics', 175000.00, '2026-06-01', '2026-12-31', 'Planning', 2);

-- 4. insert tasks (12 records)
INSERT INTO tasks VALUES
	(DEFAULT,1, 5, 'Database Schema Architecture Design', 'Critical', 40.00, 100, '2026-01-12'),
	(DEFAULT,1, 6, 'Backend REST API Implementation', 'High', 80.00, 65, '2026-01-20'),
	(DEFAULT,1, 7, 'API Integration Automated Testing', 'High', 35.00, 40, '2026-02-05'),
	(DEFAULT,2, 6, 'UI/UX Mobile Screen Wireframing', 'Medium', 30.00, 90, '2026-02-02'),
	(DEFAULT,2, 5, 'OAuth2 Authentication Setup', 'High', 25.00, 50, '2026-02-15'),
	(DEFAULT,3, 11, 'AWS S3 Bucket Migration', 'Medium', 50.00, 100, '2025-09-10'),
	(DEFAULT,4, 5, 'Machine Learning Model Integration', 'Critical', 100.00, 20, '2026-03-20'),
	(DEFAULT,4, 8, 'Data Pipeline Quality Verification', 'High', 45.00, 10, '2026-03-25'),
	(DEFAULT,5, 9, 'Employee Onboarding Portal UI', 'Low', 50.00, 0, '2026-04-02'),
	(DEFAULT,8, 9, 'Marketing Graphic Assets Creation', 'Medium', 35.00, 30, '2026-02-18'),
	(DEFAULT,1, 11, 'GraphQL Endpoint Optimization', 'High', 20.00, 15, '2026-03-01'),
	(DEFAULT,7, 8, 'Penetration Testing & Vulnerability Scan', 'Critical', 40.00, 100, '2025-11-05');

-- 5. insert time_Logs (12 records)
INSERT INTO time_logs VALUES
	(DEFAULT,1, 5, 8.00, '2026-01-15', 'Created relational ERD and defined foreign keys', 1),
	(DEFAULT,1, 5, 7.50, '2026-01-16', 'Optimized DDL indexes and check constraints', 1),
	(DEFAULT,2, 6, 6.00, '2026-01-22', 'Developed User Auth endpoints in Node.js', 1),
	(DEFAULT,2, 6, 8.00, '2026-01-23', 'Connected REST APIs with PostgreSQL driver', 1),
	(DEFAULT,3, 7, 5.00, '2026-02-08', 'Wrote integration unit tests with Jest', 1),
	(DEFAULT,4, 6, 4.50, '2026-02-04', 'Designed Figma mobile mockups for client', 1),
	(DEFAULT,5, 5, 6.00, '2026-02-17', 'Configured JWT tokens and refresh mechanisms', 1),
	(DEFAULT,6, 11, 8.00, '2025-09-15', 'Migrated 5TB S3 bucket data to AWS West', 1),
	(DEFAULT,7, 5, 7.00, '2026-03-22', 'Trained initial Scikit-Learn prediction model', 1),
	(DEFAULT,8, 8, 4.00, '2026-03-28', 'Validated clean sample data ingestion', 1),
	(DEFAULT,10, 9, 3.50, '2026-02-20', 'Internal meeting regarding logo rebranding', 0),
	(DEFAULT,12, 8, 8.00, '2025-11-10', 'Executed OWASP security audit suite', 1);
    
-- ===================================================================================
-- SECTION 8: CREATE TABLE FROM ANOTHER TABLE AND DROP IT
-- Requirement: Create a table from another table (structure & data), then drop it.
-- ===================================================================================
-- create a backup table 'active_employee_archive'
CREATE TABLE active_employee_archive 
	SELECT employee_id, first_name, last_name, email, hourly_rate, department_id
	FROM employees
	WHERE is_active = 1;
    
-- drop the created table
DROP TABLE active_employee_archive;

-- ===================================================================================
-- SECTION 10: UPDATE STATEMENTS
-- Requirement: Update at least three records.
-- ===================================================================================
-- update 1: Increase hourly rate by 10% for Software Engineering employees
UPDATE employees SET hourly_rate = hourly_rate * 1.1
WHERE department_id = (
SELECT department_id FROM departments 
WHERE department_name = 'Software Engineering');

-- update 2: Update completion status and percentage for Task #2
UPDATE tasks
SET completion_pct = 100, priority = 'Medium'
WHERE task_id = 2;

-- update 3: Complete project PRJ-2026-B and record today's date as end_dated
UPDATE projects
SET status = 'Completed',
	end_date = CURRENT_DATE()
WHERE project_code = 'PRJ-2026-B';