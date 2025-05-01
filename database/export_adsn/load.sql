COPY Personnel FROM 'export_adsn/personnel.csv' (FORMAT 'csv', header 1, delimiter ',', quote '"', force_not_null ('Name', 'Abbreviation'));
COPY Site FROM 'export_adsn/site.csv' (FORMAT 'csv', header 1, delimiter ',', quote '"', force_not_null ('Site_name', 'Location', 'Latitude', 'Longitude', 'Area', 'Code'));
COPY Species FROM 'export_adsn/species.csv' (FORMAT 'csv', header 1, delimiter ',', quote '"', force_not_null ('Common_name', 'Code'));
COPY Bird_nests FROM 'export_adsn/bird_nests.csv' (FORMAT 'csv', header 1, delimiter ',', quote '"', force_not_null ('Year', 'Site', 'Species', 'Date_found', 'Nest_ID'));
COPY Camp_assignment FROM 'export_adsn/camp_assignment.csv' (FORMAT 'csv', header 1, delimiter ',', quote '"', force_not_null ('Year', 'Site', 'Observer'));
COPY Snow_cover FROM 'export_adsn/snow_cover.csv' (FORMAT 'csv', header 1, delimiter ',', quote '"', force_not_null ('Site', 'Year', 'Date', 'Location', 'Plot'));
COPY Bird_eggs FROM 'export_adsn/bird_eggs.csv' (FORMAT 'csv', header 1, delimiter ',', quote '"', force_not_null ('Year', 'Site', 'Nest_ID', 'Egg_num', 'Length', 'Width'));
