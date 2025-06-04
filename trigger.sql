-- in sqlite 3

-- .mode box -- makes table format show up
-- .headers on

SELECT * FROM Species;
.nullvalue -NULL- ---need to do this for NULL to show in table
CREATE TRIGGER Fix_up_species
AFTER INSERT ON Species
FOR EACH ROW
BEGIN
    UPDATE Species
        SET Scientific_name = NULL
        WHERE Code = new.Code AND Scientific_name = '';
END;

-- let's test it
INSERT INTO Species
    VALUES ('efgh', 'thing2', '', 'Study species');
SELECT * FROM Species;
.schema