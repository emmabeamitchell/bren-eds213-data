-- review of SQL select processing
SELECT Nest_ID, AVG(3.14/6*Width*Width*Length) AS Avg_volume
    FROM Bird_eggs
    WHERE Nest_ID LIKE '14%' -- this is what sql looks at first
    GROUP BY Nest_ID -- second evaluates rows and decides whether to keep it -- groups the rows
    HAVING Avg_volume > 10000
    ORDER BY Avg_volume DESC 
    LIMIT 3 OFFSET 17;

-- group by a whole expression
SELECT substring(NEST_ID, 1, 3), AVG(3.14/6*Width*Width*Length) AS Avg_volume
    FROM Bird_eggs
    WHERE Nest_ID LIKE '14%' -- this is what sql looks at first
    GROUP BY Nest_ID -- second evaluates rows and decides whether to keep it -- groups the rows
    HAVING Avg_volume > 10000
    ORDER BY Avg_volume DESC;

-- Joins: creates a new mega-table (does all its usually processing on this mega-table)
CREATE TABLE a (col INT);
INSERT INTO a VALUES (1), (2), (3), (4);
CREATE TABLE b (col INT);
INSERT INTO b VALUES (0), (1);
SELECT * FROM a;
SELECT * FROM b;
SELECT * FROM a JOIN b ON TRUE; -- every possible pairing of rows 
SELECT * FROM a JOIN b ON a.col = b.col;
SELECT * FROM a JOIN b ON NULL;
SELECT * FROM a JOIN b ON a.col = b.col OR a.col = b.col+1;
-- outer join adds in any rows not included by the condition
SELECT * FROM a LEFT JOIN b ON a.col=b.col OR a.col = b.col+1;
