DROP TABLE IF EXISTS collated;
CREATE TABLE collated AS
SELECT year, pct, datestop, timestop, race, sex, age, crimsusp, arstmade, arstoffn, frisked, searched, sector FROM raw_2003 UNION ALL
SELECT year, pct, datestop, timestop, race, sex, age, crimsusp, arstmade, arstoffn, frisked, searched, sector FROM raw_2004 UNION ALL
SELECT year, pct, datestop, timestop, race, sex, age, crimsusp, arstmade, arstoffn, frisked, searched, sector FROM raw_2005 UNION ALL
SELECT year, pct, datestop, timestop, race, sex, age, crimsusp, arstmade, arstoffn, frisked, searched, sector FROM raw_2006 UNION ALL
SELECT year, pct, datestop, timestop, race, sex, age, crimsusp, arstmade, arstoffn, frisked, searched, sector FROM raw_2007 UNION ALL
SELECT year, pct, datestop, timestop, race, sex, age, crimsusp, arstmade, arstoffn, frisked, searched, sector FROM raw_2008 UNION ALL
SELECT year, pct, datestop, timestop, race, sex, age, crimsusp, arstmade, arstoffn, frisked, searched, sector FROM raw_2009 UNION ALL
SELECT year, pct, datestop, timestop, race, sex, age, crimsusp, arstmade, arstoffn, frisked, searched, sector FROM raw_2010 UNION ALL
SELECT year, pct, datestop, timestop, race, sex, age, crimsusp, arstmade, arstoffn, frisked, searched, sector FROM raw_2011 UNION ALL
SELECT year, pct, datestop, timestop, race, sex, age, crimsusp, arstmade, arstoffn, frisked, searched, sector FROM raw_2012 UNION ALL
SELECT year, pct, datestop, timestop, race, sex, age, crimsusp, arstmade, arstoffn, frisked, searched, sector FROM raw_2013 UNION ALL
SELECT year, pct, datestop, timestop, race, sex, age, crimsusp, arstmade, arstoffn, frisked, searched, sector FROM raw_2014 UNION ALL
SELECT year, pct, datestop, timestop, race, sex, age, crimsusp, arstmade, arstoffn, frisked, searched, sector FROM raw_2015 UNION ALL
SELECT year, pct, datestop, timestop, race, sex, age, crimsusp, arstmade, arstoffn, frisked, searched, sector FROM raw_2016
UNION ALL
SELECT
    YEAR2 as year
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
    YEAR2 as year
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

CREATE INDEX year_race_idx_collated ON collated(year, race);
CREATE INDEX pct_idx_collated ON collated(pct);



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
