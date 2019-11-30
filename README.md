# NYPD Stop and Frisk


# The data

Note: This repo does not contain the extracted CSVs from zip files 2005-2012, because they are too large (100MB+ each). Run the default [Makefile](Makefile) task:

```sh
$ make
# i.e. `make sqlize`
```

# The scripts and stuff

Note: The shell scripts used to build the import SQL is in src/sqlite/genscripts. It's a kind of meta script, if you will


## Census and Precinct data

Courtesy of John Keefe, from this Fusion Table:
https://fusiontables.google.com/DataSource?dsrcid=749930

https://johnkeefe.net/nyc-police-precinct-and-census-data

The joined data is here:
https://fusiontables.google.com/DataSource?dsrcid=767562#rows:id=1


## Consolidating the precincts

https://www.nytimes.com/2017/03/17/nyregion/nypd-precincts.html

> Notable precinct number changes over the years have included the elimination of the 74th Precinct in Brooklyn, which covered only Prospect Park and Brooklyn Botanic Garden (both are now covered by the 78th Precinct).

https://www1.nyc.gov/site/nypd/bureaus/patrol/find-your-precinct.page


# Tasks

- How to explore and consolidate schemas across different years
- How to reconcile changing boundaries
- Joining to demographic data

## Basic

- Count number of incidents by precinct by race/ethnicity by year

## Advanced

- Join with demographic data
- Explore the schemas and import/clean as many common fields as possible


----------------

# Draft structure

## Phase 1: broad wrangling

- Reading the articles
- Reading the documentation
- Downloading the data
- Bulk importing the data
- Quick introspection of common columns
    - PRAGMA_INFO
    - Concatenation
    - Find columns with 14 commonalities


## Phase 2 Quick collation

- CREATE TABLE AS SELECT, UNION ALL
- Manually rename fields for 2017 and 2018
- Confirm general numbers for year and race
    
    ```sql
    SELECT year, 
    COUNT(1) AS n 
    FROM quick_unified
    GROUP BY year 
    ORDER BY year;

    SELECT YEAR, race,
    COUNT(1) AS n 
    FROM quick_unified
    GROUP BY year, race 
    ORDER BY year, race;
    ```

## Phase 3: Detailed collation

Get as many common fields as possible

- Location information (street address)
- physical description: weight, height, age
- Use of force flags
- Reasons for stop flags
- Reasons for frisk flags
- Reasons for search flags
- Suspected crime description


## Phase 4: Wrangling by field

- datestop
- timestop
- race 
- flag fields

- Find inconsistencies in common columns
- Per table data cleaning rules
    - date/time cleaning
    - renaming columns


## Phase 4.5 wrangling w/ lookup tables

- Lookup tables for crime codes
