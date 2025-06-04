-- From last time, wound up:
SELECT DISTINCT Location
    FROM Site
    ORDER BY Location ASC
    LIMIT 3;

-- Filtering 
SELECT * FROM Site WHERE Area < 200;
-- Can be arbitrary expressions
SELECT * FROM Site WHERE Area < 200 AND Latitude > 60;
-- Not equal, classic operator is <>, but nowadays most databases support !=
SELECT * FROM Site WHERE Location <> 'Alaska, USA';
-- LIKE for string matching, uses % as wildcard character (not *)
SELECT * FROM Site WHERE Location LIKE '%Canada'; -- Any site that ends in Canada
-- Is this case sensitive matchin or not? Depends on the batabase 
SELECT * FROM Site WHERE Location LIKE '%canada'; 
-- LIKE is primitive matching, but nowadays everyone supports regex
-- Common pattern databases provide tons of functions
-- Regex for selecting any location that has 'west' in it
SELECT * FROM Site WHERE regexp_matches(Location, '.*west.*');

-- Select expression; i.e. you can do computation
SELECT Site_name, Area FROM Site;
Select Site_name, Area*2.47 FROM Site; -- convert to acres
SELECT Site_name, Area*2.47 AS Area_acres FROM Site; -- Can rename the column!


-- You can use your database as a calculator
SELECT 2+2; 

-- String concatenation operator: classic one is ||, others via functions
SELECT Site_name || 'in' || Location FROM Site;

-- AGGREGATION AND GROUPING
SELECT COUNT(*) FROM Species;
SELECT COUNT(*) AS num_rows FROM Site;
.help mode
.mode box
SELECT Site_name, Area*2.47 AS Area_acres FROM Site;
.mode duckbox
SELECT COUNT(Scientific_name) FROM Species;
SELECT DISTINCT Relevance FROM Species;
SELECT COUNT(DISTINCT Relevance) FROM Species;
-- MIN, MAX, AVG
SELECT AVG(Area) FROM Site;
-- grouping
SELECT * FROM Site;
SELECT Location, MAX(Area)
   FROM Site
   GROUP BY Location;
SELECT Location, COUNT(*)
   FROM Site
   GROUP BY Location;
SELECT Location, COUNT(*), MAX(Area)
    FROM SITE
    WHERE Location LIKE '%Canada'
    GROUP BY Location;

-- a WHERE clause limits the rows that are going in to the expression at the beginning
-- a HAVING filters the groups
SELECT Location, COUNT(*) AS Count, MAX(Area) as Max_area
    FROM Site
    WHERE Location LIKE '%Canada'
    GROUP BY Location
    HAVING COUNT > 1;

-- NULL processing
-- NULL indicates the absence of data in a table
-- But in an expression, it means unknown

SELECT COUNT(*) FROM Bird_nests;
SELECT COUNT(*) FROM Bird_nests WHERE floatAge > 5;
SELECT COUNT(*) FROM Bird_nests WHERE floatAge <= 5;
-- how can we find out which rows are null?
SELECT COUNT(*) FROM Bird_nests WHERE floatage IS NULL;
SELECT COUNT(*) FROM Bird_nests WHERE floatage IS NOT NULL;

-- Joins
SELECT * FROM Camp_assignment LIMIT 10;
SELECT * FROM Personnel;

-- JOINS, THE HEART AND SOUL OF RDBMS
- SELECT * FROM Camp_assignment;
-- but we want full names, not abbreviations
-- so follow linkage shown in ER diagram
- SELECT * FROM Camp_assignment JOIN Personnel
      ON Observer = Abbreviation
      LIMIT 10;
-- .mode csv, see all columns
-- return is a mega-table with all columns
-- (database doesn't actually do that unless required, is more efficient)
-- more commonly, ask for selected columns
-- notice denormalization that is happening
-- which is the idea: normalize for data organization/compactness
--- temporarily denormalize to relate data back together
-- most databases support , in place of JOIN but not DuckDB
-- or INNER JOIN to be verbose
-- may need to qualify by table name if ambiguous
SELECT * FROM Camp_assignment JOIN Personnel
      ON Camp_assignment.Observer = Personnel.Abbreviation
      LIMIT 10;
SELECT * FROM Camp_assignment AS ca JOIN Personnel p
      ON ca.Observer = p.Abbreviation
      LIMIT 10;

-- 3 way join:
SELECT * FROM Camp_assignment CA JOIN Personnel P
    ON CA.Observer = P.Abbreviation
    JOIN Site S ON CA.Site = S.Code
    LIMIT 10;
-- can add WHERE clauses, etc.: WHERE CA.Observer = 'lmckinnon'
-- order of operations follows order of clauses in statement

-- relational algebra and nested queries and subqueries
SELECT COUNT(*) FROM Bird_nests;
SELECT COUNT(*) FROM (SELECT COUNT(*) FROM Bird_nests);
-- create temp tables
CREATE TEMP TABLE nest_count AS SELECT COUNT(*) FROM Bird_nests;
.table
SELECT * FROM nest_count;
-- if you leave off temp it becomes a permanent table
DROP TABLE nest_count;
.table
-- another place to nest queries is IN clauses
SELECT Observer FROM Bird_nests;
SELECT * FROM Personnel ORDER BY Abbreviation;
SELECT * FROM Bird_nests
    WHERE Observer IN(
        SELECT Abbreviation FROM Personnel
        WHERE Abbreviation LIKE 'a%'
    );
























