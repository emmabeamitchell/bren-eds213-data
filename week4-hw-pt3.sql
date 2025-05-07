-- Week $ HW Assignment Part Three
-- Emma Bea Mitchell

-- average egg volumes
CREATE TEMP TABLE Averages AS
    SELECT Nest_ID, AVG((3.14/6) * (Width)^2 * Length) AS Avg_volume
        FROM Bird_eggs
        GROUP BY NEST_ID;

-- join with bird_nests table
SELECT Scientific_name, MAX(A.Avg_volume) AS Max_Avg_Volume
    FROM Bird_nests B
    JOIN Averages A ON B.Nest_ID = A.Nest_ID
    JOIN Species S ON B.Species = S.Code
    GROUP BY Scientific_name
    ORDER BY Max_Avg_Volume DESC;
    

