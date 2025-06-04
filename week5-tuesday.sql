-- scientific names are not unique
SELECT COUNT(*) FROM Species;
SELECT COUNT (DISTINCT Scientific_name) FROM Species;

SELECT Scientific_name, COUNT(*) AS Num_name_occurences
    FROM Species
    GROUP BY Scientific_name
    HAVING Num_name_occurences > 1;

CREATE TEMP TABLE t AS(
    SELECT Scientific_name, COUNT (*) AS Num_name_occurences
    FROM Species
    GROUP BY Scientific_name
    HAVING Num_name_occurences > 1
    );

SELECT * FROM t;
SELECT * FROM Species S JOIN t
    ON s.Scientific_name = t.Scientific_name
    OR (s.Scientific_name IS NULL AND t.Scientific_name IS NULL)

-- inserting data
INSERT INTO Species VALUES ('abcd', 'thing', 'scientific_name', NULL);
SELECT * FROM Species;
-- explicitly label columns (makes code less fragile)
INSERT INTO Species
    (Common_name, Scientific_name, Code, Relevance)
    VALUES
    ('thing 2', 'another scientific name', 'efgh', NULL);
SELECT * FROM Species;
-- take advantage if default values
INSERT INTO Species
    (Common_name, Code)
    VALUES
    ('thing 3', 'ijkl');
SELECT * FROM Species;

--UPDATES and DELETES will demolish the entire table unless limited to WHERE
DELETE FROM Bird_eggs;

-- strategies to save yourself?
-- doing select first
SELECT * FROM Bird_eggs WHERE Nest_ID LIKE 'z%';

SELECT * FROM Bird_nests;
-- try the technique to create a copy of the table
CREATE TABLE nest_temp AS (SELECT * FROM Bird_nests);
DELETE FROM nest_temp WHERE Site = 'chur';

-- other ideas
xDELETE FROM ... WHERE ...;
-- take out x once you've typed out the where clause

