-- Who worked with whom
-- Emma Bea Mitchell

-- The Camp_assignment table lists where each person worked and when. 
--Your goal is to answer, Who worked with whom? 
-- That is, you are to find all pairs of people who worked at the same site, 
-- and whose date ranges overlap while at that site. 
--This can be solved using a self-join.

SELECT A.Site AS Site, A.Observer AS Observer_1, B.Observer AS Observer_2
    FROM Camp_assignment A JOIN Camp_assignment B
    ON A.Site = B.Site AND
    (A.Start <= B.End)  AND  (A.End >= B.Start) AND (B.Start <= A.End)
    WHERE A.Site = 'lkri' AND
    A.Observer < B.Observer;

-- bonus problem

SELECT 
    A.Site AS Site, 
    p1.Name AS Name_1, 
    p2.Name AS Name_2
FROM 
    Camp_assignment A 
JOIN 
    Camp_assignment B 
    ON A.Site = B.Site 
    AND A.Start <= B.End  
    AND A.End >= B.Start 
    AND A.Observer < B.Observer
JOIN 
    Personnel p1 
    ON A.Observer = p1.Abbreviation
JOIN Personnel p2
    ON B.Observer = p2.Abbreviation
WHERE 
    A.Site = 'lkri'
ORDER BY Name_2;
