.log stderr
.bail on
.echo on
.mode csv
DROP TABLE IF EXISTS raw_2003;
.import data/stashed/nypd/csv/2003.csv raw_2003
DROP TABLE IF EXISTS raw_2004;
.import data/stashed/nypd/csv/2004.csv raw_2004
DROP TABLE IF EXISTS raw_2005;
.import data/stashed/nypd/csv/2005.csv raw_2005
DROP TABLE IF EXISTS raw_2006;
.import data/stashed/nypd/csv/2006.csv raw_2006
DROP TABLE IF EXISTS raw_2007;
.import data/stashed/nypd/csv/2007.csv raw_2007
DROP TABLE IF EXISTS raw_2008;
.import data/stashed/nypd/csv/2008.csv raw_2008
DROP TABLE IF EXISTS raw_2009;
.import data/stashed/nypd/csv/2009.csv raw_2009
DROP TABLE IF EXISTS raw_2010;
.import data/stashed/nypd/csv/2010.csv raw_2010
DROP TABLE IF EXISTS raw_2011;
.import data/stashed/nypd/csv/2011.csv raw_2011
DROP TABLE IF EXISTS raw_2012;
.import data/stashed/nypd/csv/2012.csv raw_2012
DROP TABLE IF EXISTS raw_2013;
.import data/stashed/nypd/csv/2013.csv raw_2013
DROP TABLE IF EXISTS raw_2014;
.import data/stashed/nypd/csv/2014.csv raw_2014
DROP TABLE IF EXISTS raw_2015;
.import data/stashed/nypd/csv/2015.csv raw_2015
DROP TABLE IF EXISTS raw_2016;
.import data/stashed/nypd/csv/2016.csv raw_2016
DROP TABLE IF EXISTS raw_2017;
.import data/stashed/nypd/csv/2017.csv raw_2017
DROP TABLE IF EXISTS raw_2018;
.import data/stashed/nypd/csv/2018.csv raw_2018
