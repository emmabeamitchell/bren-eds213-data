-- EDS 213 Week 4 HW Problem Two
-- Emma Bea Mitchell

SELECT Site_name, MAX(Area) FROM Site;

-- this throws an error that says "column 'Site_name' must appear in the GROUP BY clause"
-- the reason it says this is because it doesn't know how to show the max Area and Site_name at the same time
-- the reason for this is because it wants to create one row and doesn't know how to "pick" which observer should appear there

--- same thing
SELECT Site_name, AVG(Area) FROM Site;
SELECT Site_name, COUNT(*) FROM Site;
SELECT Site_name, SUM(Area) FROM Site;
---

-- Part Two
-- Find the site name and area of the site having the largest area. 
-- Do so by ordering the rows in a particularly convenient order, and using LIMIT to select just the first row. 

SELECT Site_name, MAX(Area) AS Max_area
    FROM Site
    GROUP BY Site_name
    ORDER BY Max_area DESC
    LIMIT 1;

 -- Part Three
 -- Do the same, but use a nested query. First, create a query that finds the maximum area. 
 -- Then, create a query that selects the site name and area of the site whose area equals the maximum. 

SELECT Site_name, Area 
FROM Site 
WHERE Area = (
    SELECT MAX(Area) 
    FROM Site
);


    


    
