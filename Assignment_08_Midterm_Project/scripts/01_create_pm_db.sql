--------------------------------------------------------------------------------------
-- Name       : Design and Create Databases, Tables and Indexes (Project Management)
-- Author     : Yuliia Chernysheva
-- Course     : CIS 2268 SQL Programming
--------------------------------------------------------------------------------------
-- ===================================================================================
-- SCHEMA CREATION & DATA INTEGRITY RULES (SECTIONS 3–7)
-- Architecture Overview:
--   1. Relational Design : 5 interconnected core tables with Primary Keys & Foreign Keys
--   2. Referential Safety: Cascading rules (ON DELETE CASCADE / SET NULL)
--   3. Business Rules    : NOT NULL attributes, DEFAULT initializations, & UNIQUE keys
--   4. Data Validation   : Standardized ANSI CHECK constraints for status & range checks
-- ===================================================================================
-- create the database
DROP DATABASE IF EXISTS pm_db;
CREATE DATABASE pm_db;

-- select the datebase
USE pm_db;

-- create the tables
CREATE TABLE departments 
(
	department_id 		INT				PRIMARY KEY		AUTO_INCREMENT,
    department_name 	VARCHAR(50)		NOT NULL		UNIQUE,
    location 			VARCHAR(50)		NOT NULL,
    budget_allocation 	DECIMAL(12,2),
    CONSTRAINT departments_chk_budget_allocation
		CHECK (budget_allocation>0)
);

CREATE TABLE employees
(
	employee_id 	INT				PRIMARY KEY		AUTO_INCREMENT,
    first_name		VARCHAR(50)		NOT NULL,
    last_name		VARCHAR(50)		NOT NULL,
    email			VARCHAR(50)		NOT NULL		UNIQUE,
    hourly_rate		DECIMAL(6,2)	NOT NULL,
    department_id	INT,
    manager_id		INT,
    hire_date 		DATE			NOT NULL		DEFAULT(CURRENT_DATE),
    is_active 		BOOLEAN			NOT NULL		DEFAULT 1,
    CONSTRAINT fk_manager_id
		FOREIGN KEY (manager_id) REFERENCES employees (employee_id)
        ON DELETE SET NULL,
    CONSTRAINT employees_chk_email
		CHECK(email like '%@%.%'),
	CONSTRAINT employees_chk_hourly_rate
		CHECK(hourly_rate>=15.00)
);

CREATE TABLE projects
(
	project_id			INT				PRIMARY KEY		AUTO_INCREMENT,
    project_code		VARCHAR(10)		NOT NULL		UNIQUE,
    project_name		VARCHAR(100)	NOT NULL,
    client_name			VARCHAR(100)	NOT NULL,
    budget				DECIMAL(12,2)	NOT NULL,
    start_date			DATE			NOT NULL,
    end_date			DATE,
    status				VARCHAR(20)		NOT NULL		DEFAULT 'Planning',
    lead_employee_id	INT,
    CONSTRAINT projects_chk_budget
		CHECK(budget>0),
	CONSTRAINT projects_chk_end_date
		CHECK(end_date IS NULL OR end_date>=start_date),
	CONSTRAINT projects_chk_status
		CHECK(status IN ('Planning', 'In Progress', 'On Hold', 'Completed', 'Cancelled'))
);

CREATE TABLE tasks
(
	task_id			INT				PRIMARY KEY		AUTO_INCREMENT,
    project_id		INT,
    assigned_to		INT,
    task_title		VARCHAR(150)	NOT NULL,
    priority	   	VARCHAR(10)		NOT NULL,
    estimated_hours	DECIMAL(5,2)	NOT NULL,
    completion_pct	INT				NOT NULL		DEFAULT 0,
    created_at		date			NOT NULL		DEFAULT(CURRENT_DATE),
    CONSTRAINT tasks_chk_priority
		CHECK(priority IN('Low', 'Medium', 'High', 'Critical')),
	CONSTRAINT tasks_chk_estimated_hours
		CHECK(estimated_hours>0),
	CONSTRAINT tasks_chk_completion_pct
		CHECK(completion_pct BETWEEN 0  AND 100)
);

CREATE TABLE time_logs
(
	log_id				INT				PRIMARY KEY		AUTO_INCREMENT,
    task_id				INT,
    employee_id			INT,
    hours_spent			DECIMAL(4,2)	NOT NULL,
    log_date			DATE			NOT NULL	DEFAULT(CURRENT_DATE),
    work_description	VARCHAR(255)	NOT NULL,
    is_billable			BOOLEAN			NOT NULL	DEFAULT 1,
    CONSTRAINT time_logs_chk_hours_spent
		CHECK(hours_spent>0 AND hours_spent<=24.00)
);

-- add Foreign Key constraints via ALTER TABLE
ALTER TABLE employees
ADD CONSTRAINT employees_fk_departments
		FOREIGN KEY (department_id) REFERENCES departments (department_id)
        ON DELETE SET NULL;
        
ALTER TABLE projects
ADD CONSTRAINT projects_fk_employees
	FOREIGN KEY (lead_employee_id) REFERENCES employees(employee_id)
    ON DELETE SET NULL;
    
ALTER TABLE tasks
ADD CONSTRAINT tasks_fk_projects
	FOREIGN KEY (project_id) REFERENCES projects(project_id)
    ON DELETE CASCADE;
    
ALTER TABLE tasks
ADD CONSTRAINT tasks_fk_employees
	FOREIGN KEY (assigned_to) REFERENCES employees(employee_id)
    ON DELETE SET NULL;
    
ALTER TABLE time_logs
ADD CONSTRAINT time_logs_fk_tasks
	FOREIGN KEY (task_id) REFERENCES tasks(task_id)
    ON DELETE CASCADE;
    
ALTER TABLE time_logs
ADD CONSTRAINT time_logs_fk_employees
	FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
    ON DELETE CASCADE;