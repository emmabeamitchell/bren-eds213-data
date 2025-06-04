-- Thursday Week 4 in class
CREATE TABLE Snow_cover (
    Site VARCHAR NOT NULL,
    Year INTEGER NOT NULL CHECK (Year BETWEEN 1990 and 2018),
    Date DATE NOT NULL,
    Location VARCHAR NOT NULL,
    Plot VARCHAR NOT NULL,
    Snow_cover REAL CHECK (Snow_cover BETWEEN 0 AND 130),
    Water_cover REAL CHECK (Water_cover BETWEEN 0 AND 130),
    Land_cover REAL CHECK (Land_cover BETWEEN 0 AND 130),
    Total_cover REAL CHECK (Total_cover BETWEEN 0 AND 130),
    Observer VARCHAR,
    Notes VARCHAR,
    PRIMARY KEY (Site, Plot, Location, Date),
    FOREIGN KEY (Site) REFERENCES Site(Code)
);

-- don't run these -- just example of NAS vs NULLS
COPY Snow_cover FROM "../ASDN_csv/snow_survey_fixed.csv" (header TRUE);
SELECT * FROM Snow_cover LIMIT 10;

--- The notes column has NAs -- SQL only knows NULL -- thinks NA is just text

COPY Snow_cover FROM "../ASDN_csv/snow_survey_fixed.csv" (header TRUE, nullstr "NA");
SELECT * FROM Snow_cover LIMIT 10;

-- question 1: what is the average snow cover at each site?

SELECT Site, AVG(Snow_cover) AS avg_snow_cover
    FROM Snow_cover
    GROUP BY Site
    ORDER BY avg_snow_cover DESC;

-- question 2: top five most snowy sites

SELECT Site, AVG(Snow_cover) AS avg_snow_cover
    FROM Snow_cover
    GROUP BY Site
    ORDER BY avg_snow_cover DESC
    LIMIT 5;

-- question 3: save this as a view

CREATE VIEW Site_avg_snow_cover AS (SELECT Site, AVG(Snow_cover) AS avg_snow_cover
    FROM Snow_cover
    GROUP BY Site
    ORDER BY avg_snow_cover DESC
    LIMIT 5);

SELECT * FROM Site_avg_snow_cover;

--- DANGER ZONE AKA updating data
--- We found that 0s at Plot = 'brw0' with snow_cover == 0 are actually no data (NULL)

-- create temp table to try with backup
CREATE TEMP TABLE Snow_cover_backup AS (SELECT * FROM Snow_cover);
UPDATE Snow_cover_backup SET Snow_cover = NULL WHERE Plot = 'brw0' AND Snow_cover = 0;

-- it worked like we wanted so update real data
UPDATE Snow_cover SET Snow_cover = NULL WHERE Plot = 'brw0' AND Snow_cover = 0;

