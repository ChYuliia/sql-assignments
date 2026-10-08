--------------------------------------------------------------------------------------
-- Name       : Design and Create Databases, Tables and Indexes (Chapters 10 and 11)
-- Author     : Yuliia Chernysheva
-- Course     : CIS 2268 SQL Programming
--------------------------------------------------------------------------------------

-- create the database
DROP DATABASE IF EXISTS food_tracking_db;
CREATE DATABASE food_tracking_db;

-- select the datebase
USE food_tracking_db;

-- create the tables
CREATE TABLE judgements
(
	judgement_id 	INT		PRIMARY KEY		AUTO_INCREMENT,
    judgement 		VARCHAR(10)
);

CREATE TABLE food_items
(
	calorie_id 		INT 			PRIMARY KEY	AUTO_INCREMENT,
    food 			VARCHAR(50) 	NOT NULL 	UNIQUE,
    unit   			VARCHAR(10) 	NOT NULL,
    unit_measure 	VARCHAR(20) 	NOT NULL,
    calories 		INT 			NOT NULL,
    judgement_id 	INT 			NOT NULL
);

CREATE TABLE consumption
(
	calorie_id 		INT,
    how_many_units 	INT  	NOT NULL,
    dates 			DATE
);

-- Add composite primary key to the consumption table
ALTER TABLE consumption
ADD CONSTRAINT consumption_pk
	PRIMARY KEY (calorie_id, dates);
 
-- Add foreign key constraint to food_items referencing judgements
ALTER TABLE food_items
ADD CONSTRAINT food_items_fk_judgements
	FOREIGN KEY (judgement_id) REFERENCES judgements(judgement_id);

-- Add foreign key constraint to consumption referencing food_items    
ALTER TABLE consumption
ADD CONSTRAINT consumption_fk_food_items
	FOREIGN KEY (calorie_id) REFERENCES food_items (calorie_id);

-- Add check constraint to ensure consumed units are greater than zero
ALTER TABLE consumption
ADD CONSTRAINT consumption_chk_units
	CHECK (how_many_units > 0);
  
-- insert rows
INSERT INTO judgements VALUES
	(DEFAULT,'very bad'),
	(DEFAULT,'better'),
	(DEFAULT,'excellent');
    
INSERT INTO food_items VALUES
		(DEFAULT,'twizzlers','3','piece',120,1),
        (DEFAULT,'rice pudding','1/2','cup',302,1),
        (DEFAULT,'marshmallows','5','piece',124,1),
        (DEFAULT,'cashew','1','oz',155,2),
        (DEFAULT,'almonds','1','cup',546,2),
        (DEFAULT,'broccoli','1','bunch',207,3),
        (DEFAULT,'green beans','1','cup',34,3);
        
INSERT INTO consumption VALUES
	(1,2,str_to_date('10/4/2025','%m/%d/%Y')),
    (5,1,str_to_date('10/4/2025','%m/%d/%Y')),
    (2,1,str_to_date('9/30/2025','%m/%d/%Y')),
    (7,1,str_to_date('9/26/2025','%m/%d/%Y'));