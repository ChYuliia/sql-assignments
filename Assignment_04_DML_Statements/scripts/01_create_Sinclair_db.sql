--------------------------------------------------------------------------------------
-- Name       : Sinclair_db Creation and Population Script
-- Author     : Yuliia Chernysheva
-- Course     : CIS 2268 SQL Programming
--------------------------------------------------------------------------------------

-- Create a new database
CREATE DATABASE IF NOT EXISTS Sinclair_db;

-- Switch to the new database for subsequent SQL commands
USE Sinclair_db;

---------------------------------------------------------------------------
-- Drop table if it exists (good practice for re-runs) and create Sinclair table
---------------------------------------------------------------------------
DROP TABLE IF EXISTS Sinclair;

CREATE TABLE Sinclair (
  classID INT(10),
  department VARCHAR(30),
  deptShort VARCHAR(3),
  class_number VARCHAR(4),
  section_number CHAR(3),
  class_type VARCHAR(10),
  credit_hours DOUBLE(4, 2),
  location VARCHAR(15),
  instructor VARCHAR(20)
);

-- Populate the table with classes
INSERT INTO Sinclair VALUES (001, 'REAL ESTATE', 'RES', '1101', 'RA1', 'REMOTE', 3, 'REMOTE', 'Gagnon');
INSERT INTO Sinclair VALUES (002, 'REAL ESTATE', 'RES', '1201', 'RB1', 'REMOTE', 3, 'REMOTE', 'Davis');
INSERT INTO Sinclair VALUES (003, 'REAL ESTATE', 'RES', '1301', 'RA1', 'REMOTE', 3, 'REMOTE', 'Ashton');
INSERT INTO Sinclair VALUES (004, 'CS', 'CIS', '2268', 'RN1', 'REMOTE', 3, 'REMOTE', 'Taylor');
INSERT INTO Sinclair VALUES (005, 'CS', 'CIS', '1202', '501', 'ONLINE', 3, 'ONLINE', 'Sommer');
