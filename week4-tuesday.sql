-- Continuing with SQL
-- Somewhat arbitray but illustrative query
SELECT Nest_ID, COUNT(*) FROM Bird_eggs
   GROUP BY Nest_ID;
.maxrows 8
SELECT Species FROM Bird_nests WHERE Site = 'nome';
SELECT Species, COUNT(*) AS Nest_count
   FROM Bird_nests
   WHERE Site = 'nome'
   GROUP BY Species
   ORDER BY Species
   LIMIT 2;
-- can nest queries
SELECT Scientific_name, Nest_count FROM
   (SELECT Species, COUNT(*) AS Nest_count
   FROM Bird_nests
   WHERE Site = 'nome'
   GROUP BY Species
   ORDER BY Species
   LIMIT 2) JOIN Species ON Species = Code;
-- outer joins
CREATE TEMP TABLE a (cola INTEGER, common INTEGER);
   INSERT INTO a VALUES (1, 1), (2, 2), (3, 3);
   SELECT * FROM a;
   CREATE TEMP TABLE b (common INTEGER, colb INTEGER);
   INSERT INTO b VALUES (2, 2), (3, 3), (4, 4), (5, 5);
   SELECT * FROM b;
-- the joins we've been doing so far have been "inner" joins
SELECT * FROM a JOIN b USING (common);
-- same thing as saying
SELECT * FROM a JOIN b ON a.common = b.common;

-- by doing an "outer" join --- either "left" or "right" --- we'll add certain missing rows
SELECT * FROM a LEFT JOIN b ON a.common = b.common;
SELECT * FROM a RIGHT JOIN b ON a.common = b.common;

-- a running example: what species does *not* have any nest data
SELECT COUNT(*) FROM Species;
SELECT COUNT(DISTINCT Species) FROM Bird_nests; -- only have nest data for 19 species
SELECT Code FROM Species
    WHERE Code NOT IN (SELECT DISTINCT Species FROM Bird_nests); -- method one
SELECT Code FROM Species
    WHERE Code NOT IN (SELECT Species FROM Bird_nests); -- gives same results but less efficient


SELECT Code, Species FROM Species LEFT JOIN Bird_nests 
    ON Code = Species; -- fills with null if the species doesn't match
-- method 2
SELECT Code, Species FROM Species LEFT JOIN Bird_nests 
    ON Code = Species
    WHERE Species IS NULL; -- finds only where species are null -- which does *not* have any nest data

-- it's also possible to join a table with itself, a so-called "self-join"

-- understanding a limitation of duckdb
SELECT Nest_ID, COUNT(*) AS Num_eggs
    FROM Bird_nests JOIN Bird_eggs
    USING(Nest_ID)
    WHERE Nest_ID LIKE '13B%'
    GROUP BY Nest_ID; 
    -- grouped bird nest table with bird eggs table by nest id and only looking for ids starting with 13B

-- Let's add in Observer (same display but want to see the observer)
SELECT Nest_ID, Observer, COUNT(*) AS Num_eggs
     FROM Bird_nests JOIN Bird_eggs
    USING(Nest_ID)
    WHERE Nest_ID LIKE '13B%'
    GROUP BY Nest_ID; -- throws an error "must appear in the GROUP BY clause" 
-- there could only be one value for observer because we grouped by primary key -- duckdb is not smart enough to know that


SELECT * FROM Bird_nests JOIN Bird_eggs
    USING (NEST_ID)
    WHERE Nest_ID LIKE '13B%'; 

-- duck db solution #1:
SELECT Nest_ID, Observer, COUNT(*) As Num_eggs
    FROM Bird_nests JOIN Bird_eggs
    USING (Nest_ID)
    WHERE Nest_ID LIKE '13B%'
    GROUP BY Nest_ID, Observer;

-- duckdb solution #2:
SELECT Nest_ID, ANY_VALUE(Observer) AS Observer, COUNT(*) AS Num_eggs
    FROM Bird_nests JOIN Bird_eggs
    USING (Nest_ID)
    WHERE NEST_ID LIKE '13B%'
    GROUP BY Nest_ID;
-- support for sql in other places is deeper/richer than duckdb

-- views: a virtual table
-- temp table
-- what's the diff?
SELECT * FROM Camp_assignment;
SELECT Year, Site, Name, Start, "End"
   FROM Camp_assignment JOIN Personnel
   ON Observer = Abbreviation;
CREATE VIEW v AS
   SELECT Year, Site, Name, Start, "End"
   FROM Camp_assignment JOIN Personnel
   ON Observer = Abbreviation;
-- a view looks just like a table, but it's not real
-- if you want to only run it once, you can create a table or temp table
-- if you want to run the data as is for convenience or to see updated data, use view

-- what about modifications (inserts, updates, deletes) on a view? Possible?
-- it depends 
-- whether it's theoretically possible 
-- how smart the database is

-- last topic; set operations
-- UNION, UNION ALL, INTERSECT, EXCEPT

SELECT * FROM Bird_eggs LIMIT 5;

SELECT Book_page, Year, Site, Nest_ID, Egg_num, Length*25.4 AS Length, Width*25.4 AS Width
    WHERE Book_page = 'b14.6'
UNION
SELECT Book_page, Year, Site, Nest_ID, Egg_num, Length, Width 
    FROM Bird_eggs
   WHERE Book_page NOT LIKE 'b14.6';

-- union removes duplicates, union all keeps duplicates

-- method 3 for running example
SELECT Code FROM Species
EXCEPT
SELECT DISTINCT Species FROM Bird_nests;
