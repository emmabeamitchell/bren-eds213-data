-- Section EDS 213 Database Creating

-- Creating Tables
CREATE TABLE Country (
    country VARCHAR NOT NULL,
    nation_code INTEGER NOT NULL,
    location_code VARCHAR NOT NULL,
    PRIMARY KEY (country, nation_code, location_code)
);

COPY Country FROM 

CREATE TABLE Solar (
    data_id VARCHAR NOT NULL,
    sunfrac_at_planting REAL,
    daylength_at_planting REAL,
    dsw_at_planting REAL,
    PRIMARY KEY (data_id)
);

CREATE TABLE SnowData (
    data_id VARCHAR NOT NULL,
    ndays_since_snowfrac_0_5 INTEGER,
    ndays_since_snowfrac_0_1 INTEGER,
    ndays_since_snowfrac_0_05 INTEGER,
    ndays_since_snowfrac_0 INTEGER,
    PRIMARY KEY (data_id)
);

CREATE TABLE CropYields (
     data_id VARCHAR NOT NULL,
     crop VARCHAR NOT NULL,
     full_crop_name VARCHAR NOT NULL,
     qualifier VARCHAR,
     level VARCHAR,
     location_code VARCHAR,
     lat_avg REAL,
     lon_avg REAL,
     harvested_area REAL,
     notes VARCHAR,
     PRIMARY KEY (data_id)
     FOREIGN KEY (location_code) REFERENCES Country(location_code)
);

CREATE TABLE Precipitation (
    data_id VARCHAR NOT NULL,
    crop VARCHAR NOT NULL,
    precip_average REAL,
    precip_min REAL,
    precip_max REAL,
    precip_min_month VARCHAR,
    precip_max_month VARCHAR,
    precip_at_planting REAL,
    precip_over_pet_min REAL,
    precip_over_pet_min_day INTEGER,
    precip_over_pet_max REAL,
    precip_over_pet_max_day INTEGER,
    precip_over_pet_at_planting REAL,
    apr_to_sept_precip_frac,
    precip_growing_season REAL,
    PRIMARY KEY (data_id)

);

CREATE TABLE Planting (
    data_id VARCHAR NOT NULL,
    crop VARCHAR NOT NULL,
    plant_start VARCHAR,
    plant_start_date VARCHAR,
    plant_end VARCHAR,
    plant_end_date VARCHAR,
    plant_median VARCHAR,
    plant_range VARCHAR,
    PRIMARY KEY (data_id),
    FOREIGN KEY (crop) REFERENCES Precip(crop),
    FOREIGN KEY (crop) REFERENCES CropYields(crop)

);

CREATE TABLE ColdStress(
    data_id VARCHAR NOT NULL,
    ndays_growing_season_below_0 INTEGER,
    ndays_growing_season_below_5 INTEGER,
    ndays_growing_season_below_10 INTEGER,
    ndays_growing_season_below_12 INTEGER,
    ndays_growing_season_below_15 INTEGER,
    ndays_growing_season_below_17 INTEGER,
    ndays_below_0 INTEGER,
    ndays_below_5 INTEGER,
    ndays_below_10 INTEGER,
    ndays_below_12 INTEGER,
    ndays_below_15 INTEGER,
    ndays_below_17 INTEGER,
    PRIMARY KEY (data_id)
);

CREATE TABLE SeasonLength(
    data_id VARCHAR NOT NULL,
    lgp INTEGER,
    lgp_t REAL,
    lgp_p REAL,
    lgp_tmin5_tmax100 REAL,
    lgp_t_min5_max100 REAL,
    lgp_p_tmin5_tmax100 REAL,
    PRIMARY KEY (data_id)
);

CREATE TABLE Products(
    domain_code VARCHAR,
    domain VARCHAR,
    area_code_m49 INTEGER,
    country VARCHAR,
    element_code INTEGER,
    element VARCHAR,
    item_code_cpc INTEGER,
    crop VARCHAR NOT NULL,
    year_code INTEGER,
    year INTEGER,
    unit VARCHAR,
    value REAL,
    flag VARCHAR,
    flag_description VARCHAR,
    PRIMARY KEY (crop, domain_code, country, element),
    FOREIGN KEY (crop) REFERENCES CropYields(crop),
    FOREIGN KEY (crop) REFERENCES Planting(crop),
    FOREIGN KEY (crop) REFERENCES Precip(crop)
);

CREATE TABLE Temperature (
    data_id VARCHAR NOT NULL,
    tmin_day_avg REAL,
    temp_average REAL,
    temp_min REAL,
    temp_max REAL,
    temp_min_month VARCHAR,
    temp_max_month VARCHAR,
    temp_at_planting REAL,
    apr_to_sept_temp_anomaly REAL,
    temp_growing_season REAL,
    PRIMARY KEY (data_id)
);

CREATE TABLE Harvest(
    data_id VARCHAR NOT NULL,
    crop VARCHAR NOT NULL,
    harvest_start VARCHAR,
    harvest_start_date VARCHAR,
    harvest_end VARCHAR, 
    harvest_end_date VARCHAR,
    harvest_median VARCHAR,
    harvest_range VARCHAR,
    PRIMARY KEY (data_id),
    FOREIGN KEY (crop) REFERENCES CropYields(crop),
    FOREIGN KEY (crop) REFERENCES Planting(crop),
    FOREIGN KEY (crop) REFERENCES Precip(crop),
    FOREIGN KEY (crop) REFERENCES Products(crop)
);

CREATE TABLE GrowingDegreeDays (
    data_id VARCHAR NOT NULL,
    gdd_base_0 REAL,
    gdd_base_4 REAL,
    gdd_base_5 REAL,
    gdd_base_8 REAL,
    gdd_base_10 REAL,
    gdd_base_0_from_plant_until_cold REAL,
    gdd_base_4_from_plant_until_cold REAL,
    gdd_base_5_from_plant_until_cold REAL,
    gdd_base_8_from_plant_until_cold REAL,
    gdd_base_10_from_plant_until_cold REAL,
    PRIMARY KEY (data_id)
);
