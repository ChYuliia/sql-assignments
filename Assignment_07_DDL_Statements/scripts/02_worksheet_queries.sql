--------------------------------------------------------------------------------------
-- Name       : Design and Create Databases, Tables and Indexes (Chapters 10 and 11)
-- Author     : Yuliia Chernysheva
-- Course     : CIS 2268 SQL Programming
--------------------------------------------------------------------------------------
USE food_tracking_db;

-- 1.	What is the judgement (not the id) of each of the food items?
SELECT fi.food, j. judgement
FROM food_items fi
JOIN judgements j ON j.judgement_id = fi.judgement_id;

-- 2.	Which food did I consume on October 4?  Include the name of the food and the judgement.
SELECT fi.food, j.judgement 
FROM food_items fi 
JOIN consumption c ON c.calorie_id = fi.calorie_id 
JOIN judgements j ON j.judgement_id = fi.judgement_id
WHERE MONTH(dates) = 10
	AND DAY(dates) = 4;