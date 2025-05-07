-- Missing Data
-- Emma Bea Mitchell

-- Which sites have no egg data? Please answer this question using all three techniques demonstrated in class. 
-- In doing so, you will need to work with the Bird_eggs table, the Site table, or both. 

-- using not in clause

SELECT Code FROM Site
    WHERE Code NOT IN (SELECT DISTINCT Site FROM Bird_eggs)
    ORDER BY Code;

-- Using an outer join with a WHERE clause that selects the desired rows

SELECT Code, Site FROM Site LEFT JOIN Bird_eggs 
    ON Code = Site
    WHERE Site IS NULL
    ORDER BY Code; 

-- Using the set operation EXCEPT

SELECT Code FROM Site
    EXCEPT
    SELECT DISTINCT Site FROM Bird_eggs
    ORDER BY Code;