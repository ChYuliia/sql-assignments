-- Yuliia Chernysheva
-- September 5, 2026
-- CSC 2268 - SQL PROGRAMMING
-- Chapter 3 of Murach's MySQL "How to retrieve data from a single table"
USE imdb;

-- 1. Display all the rows and columns
SELECT *
FROM mytable;

-- 2. Display the movie_title and title_year for movies with a title year of 2013
SELECT movie_title, title_year
FROM mytable
WHERE title_year = 2013;

-- 3. Display the movie title, duration, and genres for movies with duration of greater than 160 minutes
SELECT movie_title, duration, genres
FROM mytable
WHERE duration > 160;

-- 4. Display all rows that have a title year of 2013 and are longer than 160 minutes
SELECT movie_title, duration, genres
FROM mytable
WHERE title_year = 2013
	AND duration > 160;

-- 5. Display all rows that have a null in the duration column
SELECT 
	movie_title AS 'MOVIE_TITLE', 
    genres AS 'GENRES'
FROM mytable
WHERE duration IS NULL;

-- 6. Display all rows whose title begins with an A or a T and also an imbd_score greater than 8
SELECT movie_title, imdb_score, genres
FROM mytable
WHERE movie_title REGEXP '^[AT]'
	AND imdb_score > 8;
    
-- 7.Display all rows whose title year is 2008, 2012, or 2015 (use the IN function)
SELECT movie_title, title_year
FROM mytable
WHERE title_year IN (2008, 2012, 2015)
ORDER BY title_year DESC;

-- 8. Add 20% to each of the movie durations and alias the column name as "Duration with ads"
SELECT 
	movie_title, 
    duration, 
    duration*1.2 AS 'Duration with ads'
FROM mytable;

-- 9. Concatenate actor_1_name with the text "likes = " and with their Facebook likes
-- Only select movies from 2008, 2015, 2012.  Order by title_year, descending. 
SELECT CONCAT(actor_1_name, ' likes = ', actor_1_facebook_likes) AS 'Facebook likes'
FROM mytable
WHERE title_year IN (2008, 2015, 2012)
ORDER BY title_year DESC;

-- 10. Display the first 3 letters of the movie_title
SELECT LEFT(movie_title,3) AS 'first 3 letters'
FROM mytable;

-- 11. Round the value of each IMDB_score
SELECT movie_title, imdb_score, ROUND(imdb_score) AS 'rounded number'
FROM mytable;

-- 12. Remove duplicate countries but do not display any nulls
SELECT distinct country
FROM mytable
WHERE country IS NOT NULL;

-- 13. Display all movies that have a IMDB score between 5 and 8
SELECT movie_title, imdb_score
FROM mytable
WHERE imdb_score BETWEEN 5 AND 8;

