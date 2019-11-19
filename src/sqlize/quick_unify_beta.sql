DROP TABLE IF EXISTS quick_unified;
CREATE TABLE quick_unified AS
SELECT '2003' AS year, pct, datestop, timestop, race, sex, age, crimsusp, arstmade, arstoffn, frisked, searched, sector FROM raw_2003 UNION ALL
SELECT '2004' AS year, pct, datestop, timestop, race, sex, age, crimsusp, arstmade, arstoffn, frisked, searched, sector FROM raw_2004 UNION ALL
SELECT '2005' AS year, pct, datestop, timestop, race, sex, age, crimsusp, arstmade, arstoffn, frisked, searched, sector FROM raw_2005 UNION ALL
SELECT '2006' AS year, pct, datestop, timestop, race, sex, age, crimsusp, arstmade, arstoffn, frisked, searched, sector FROM raw_2006 UNION ALL
SELECT '2007' AS year, pct, datestop, timestop, race, sex, age, crimsusp, arstmade, arstoffn, frisked, searched, sector FROM raw_2007 UNION ALL
SELECT '2008' AS year, pct, datestop, timestop, race, sex, age, crimsusp, arstmade, arstoffn, frisked, searched, sector FROM raw_2008 UNION ALL
SELECT '2009' AS year, pct, datestop, timestop, race, sex, age, crimsusp, arstmade, arstoffn, frisked, searched, sector FROM raw_2009 UNION ALL
SELECT '2010' AS year, pct, datestop, timestop, race, sex, age, crimsusp, arstmade, arstoffn, frisked, searched, sector FROM raw_2010 UNION ALL
SELECT '2011' AS year, pct, datestop, timestop, race, sex, age, crimsusp, arstmade, arstoffn, frisked, searched, sector FROM raw_2011 UNION ALL
SELECT '2012' AS year, pct, datestop, timestop, race, sex, age, crimsusp, arstmade, arstoffn, frisked, searched, sector FROM raw_2012 UNION ALL
SELECT '2013' AS year, pct, datestop, timestop, race, sex, age, crimsusp, arstmade, arstoffn, frisked, searched, sector FROM raw_2013 UNION ALL
SELECT '2014' AS year, pct, datestop, timestop, race, sex, age, crimsusp, arstmade, arstoffn, frisked, searched, sector FROM raw_2014 UNION ALL
SELECT '2015' AS year, pct, datestop, timestop, race, sex, age, crimsusp, arstmade, arstoffn, frisked, searched, sector FROM raw_2015 UNION ALL
SELECT '2016' AS year, pct, datestop, timestop, race, sex, age, crimsusp, arstmade, arstoffn, frisked, searched, sector FROM raw_2016
UNION ALL
SELECT
    '2017' AS year
    , STOP_LOCATION_PRECINCT AS pct
    , STOP_FRISK_DATE AS datestop
    , "Stop Frisk Time" AS timestop
    , SUSPECT_RACE_DESCRIPTION AS race
    , SUSPECT_SEX as sex
    , SUSPECT_REPORTED_AGE as age
    , SUSPECTED_CRIME_DESCRIPTION AS crimsusp
    , SUSPECT_ARRESTED_FLAG as arstmade
    , SUSPECT_ARREST_OFFENSE AS arstoffn
    , FRISKED_FLAG AS frisked
    , SEARCHED_FLAG AS searched
    , STOP_LOCATION_SECTOR_CODE AS sector
    FROM raw_2017
UNION ALL
SELECT
    '2018' AS year
    , STOP_LOCATION_PRECINCT AS pct
    , STOP_FRISK_DATE AS datestop
    , "Stop Frisk Time" AS timestop
    , SUSPECT_RACE_DESCRIPTION AS race
    , SUSPECT_SEX as sex
    , SUSPECT_REPORTED_AGE as age
    , SUSPECTED_CRIME_DESCRIPTION AS crimsusp
    , SUSPECT_ARRESTED_FLAG as arstmade
    , SUSPECT_ARREST_OFFENSE AS arstoffn
    , FRISKED_FLAG AS frisked
    , SEARCHED_FLAG AS searched
    , STOP_LOCATION_SECTOR_CODE AS sector
    FROM raw_2018
;
/*
    SELECT
    year
    , pct
    , datestop
    , timestop
    , race
    , sex
    , arstmade
    , arstoffn
    , frisked
    , searched
    , sector
    , beat
    , post
FROM raw_200X
UNION ALL
*/
