-- Who's the culprit
-- Emma Bea Mitchell

-- That is, looking at nest data for “nome” between 1998 and 2008 inclusive, 
-- and for which egg age was determined by floating, 
-- can you determine the (full) name of the observer who observed exactly 36 nests? 

-- end up with name and num of floated nests

SELECT Name, COUNT(*) AS Num_floated_nests
    FROM Bird_nests JOIN Personnel 
    ON Bird_nests.Observer = Personnel.Abbreviation
    WHERE Site = 'nome'
        AND Year BETWEEN 1998 AND 2008
        AND ageMethod = 'float'
    GROUP BY Name
    HAVING COUNT(*) = 36;