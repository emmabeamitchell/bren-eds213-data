-- start with sql
SELECT * FROM Site;
-- sql is case-insensitive, but uppercase is the tradition

-- SELECT *: all rows, all columns

-- LIMIT clause
SELECT *
    FROM Site
    LIMIT 3
    OFFSET 3;

-- selecting distinct items
SELECT * FROM Bird_nests LIMIT 1;
SELECT Species FROM Bird_nests;
SELECT DISTINCT Species FROM Bird_nests;
-- add ordering
SELECT DISTINCT Species, Observer
    FROM Bird_nests
    ORDER BY Species, Observer DESC;

-- look at site table
SELECT * FROM Site;

-- select distinct locations from site table
SELECT DISTINCT location FROM Site
    ORDER By location;

-- add limit clause to return 3 results
-- when was the limit applied?

SELECT DISTINCT location 
    FROM Site
    ORDER By location
    LIMIT 3;

