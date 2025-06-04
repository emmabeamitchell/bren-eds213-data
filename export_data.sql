-- export data sql
-- Exporting data from a database

-- the whole database 

EXPORT DATABASE 'export_adsn'; -- not available in all systems

-- one table
COPY Species TO 'species_test.csv' (HEADER, DELIMITER ',');

-- specific query
COPY (SELECT COUNT(*) FROM Species) TO 'species_count.csv' (HEADER, DELIMITER ',');