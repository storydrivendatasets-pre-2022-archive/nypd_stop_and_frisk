/*
SELECT
    year
    , MIN(datestop)
    , MAX(datestop)
FROM collated
WHERE datestop != ""
GROUP BY year
ORDER BY year ASC ;

| year | MIN(datestop) | MAX(datestop) |
| ---- | ------------- | ------------- |
| 2003 | 01012003      | 12312003      |
| 2004 | 01012004      | 12312004      |
| 2005 | 10012005      | 9302005       |
| 2006 |               | 2006-12-31    |
| 2007 | 01012007      | 12312007      |
| 2008 | 01012008      | 12312008      |
| 2009 | 10012009      | 9302009       |
| 2010 | 10012010      | 9302010       |
| 2011 | 10012011      | 9302011       |
| 2012 | 10012012      | 9302012       |
| 2013 | 10012013      | 9302013       |
| 2014 |  7012014      | 6302014       |
| 2015 | 10012015      | 9302015       |
| 2016 |               | 9302016       |
| 2017 | 01/01/2017    | 12/31/2017    |
| 2018 | 01/01/2018    | 12/31/2018    |


| datelength | MIN(datestop) | MAX(datestop) | n       |
| ---------- | ------------- | ------------- | ------- |
| 1          |               |               | 3       |
| 7          | 1012005       | 9302016       | 2413861 |
| 8          |  7012014      | 12312016      | 2144795 |
| 10         | 01/01/2017    | 2006-12-31    | 529126  |



------
-- Dealing with single-digit month, e.g. 9302016, i.e. 2016-09-30
------

SELECT
    DISTINCT(datestop)
    , SUBSTR(datestop, -4) || '-'
        || '0' || SUBSTR(datestop, 1, 1)
        || '-' || SUBSTR(datestop, 2, 2 )
        AS new_datestop
FROM collated
WHERE LENGTH(datestop) = 7
ORDER BY new_datestop ASC

-----
-- 8 digit string , e.g. 12312016, i.e. 2016-12-31
-----

SELECT
    DISTINCT(datestop)
    , SUBSTR(datestop, -4) || '-'
        || SUBSTR(datestop, 1, 2)
        || '-' || SUBSTR(datestop, 3, 2 )
        AS new_datestop
FROM collated
WHERE LENGTH(datestop) = 8
ORDER BY new_datestop ASC

---
-- 10 character string with slashes, e.g. 01/01/2017
---

SELECT
    DISTINCT(datestop)
    , SUBSTR(datestop, -4) || '-'
        || SUBSTR(datestop, 1, 2)
        || '-' || SUBSTR(datestop, 4, 2 )
        AS new_datestop
FROM collated
WHERE LENGTH(datestop) = 10
    AND datestop LIKE '%/%'
ORDER BY new_datestop ASC



-- All together

SELECT
    DISTINCT datestop
    , CASE
        WHEN LENGTH(datestop) = 7
        THEN SUBSTR(datestop, -4) || '-'
            || '0' || SUBSTR(datestop, 1, 1)
            || '-' || SUBSTR(datestop, 2, 2 )

        WHEN LENGTH(datestop) = 8
        THEN SUBSTR(datestop, -4) || '-'
            || SUBSTR(datestop, 1, 2)
            || '-' || SUBSTR(datestop, 3, 2 )

        WHEN datestop LIKE '%/%'
        THEN SUBSTR(datestop, -4) || '-'
        || SUBSTR(datestop, 1, 2)
        || '-' || SUBSTR(datestop, 4, 2 )

        ELSE datestop
        END AS new_datestop

FROM collated
ORDER BY new_datestop ASC;



-- Create a view


CREATE VIEW
    datestring
AS SELECT
    DISTINCT datestop AS old
    , CASE
        WHEN LENGTH(datestop) = 7
        THEN SUBSTR(datestop, -4) || '-'
            || '0' || SUBSTR(datestop, 1, 1)
            || '-' || SUBSTR(datestop, 2, 2 )

        WHEN LENGTH(datestop) = 8
        THEN SUBSTR(datestop, -4) || '-'
            || SUBSTR(datestop, 1, 2)
            || '-' || SUBSTR(datestop, 3, 2 )

        WHEN datestop LIKE '%/%'
        THEN SUBSTR(datestop, -4) || '-'
        || SUBSTR(datestop, 1, 2)
        || '-' || SUBSTR(datestop, 4, 2 )

        ELSE datestop
        END AS new

FROM collated
ORDER BY new ASC
;




-- double check irregularities

SELECT
    LENGTH(new) AS newlen
    , COUNT(1)
FROM datestring
GROUP BY newlen


| newlen | COUNT(1) |
| ------ | -------- |
| 0      | 1        |
| 10     | 5846     |


SELECT
    SUBSTR(new, 1, 4)
      AS year
    , COUNT(1)
FROM datestring
GROUP BY year
ORDER BY year ASC
;

| year     | COUNT(1) |
| -------- | -------- |
|          | 1        |
| 1900     | 2        |
| 2003     | 365      |
| 2004     | 366      |
| 2005     | 365      |
| 2006     | 365      |
| 2007     | 365      |
| 2008     | 366      |
| 2009     | 365      |
| 2010     | 365      |
| 2011     | 365      |
| 2012     | 366      |
| 2013     | 365      |
| 2014     | 365      |
| 2015     | 365      |
| 2016     | 366      |
| 2017     | 365      |
| 2018     | 365      |



-- ... month

SELECT
    SUBSTR(new, 6, 2) AS month
    , COUNT(1)
FROM datestring
GROUP BY month
ORDER BY month ASC
;

| datepart | COUNT(1) |
| -------- | -------- |
|          | 1        |
|  7       | 31       |
|  8       | 31       |
|  9       | 30       |
| 01       | 496      |
| 02       | 452      |
| 03       | 496      |


-- ...NEed to find the bad things...


SELECT
    old
    , new
FROM datestring
WHERE SUBSTR(new, 6, 2) LIKE ' %'
;


|       old | new        |
| --------- | ---------- |
|   7012014 | 2014- 7-01 |
|   7022014 | 2014- 7-02 |
|   7032014 | 2014- 7-03 |
|   7042014 | 2014- 7-04 |
|   7052014 | 2014- 7-05 |


-- back to the create view step


DROP VIEW IF EXISTS datestring;
CREATE VIEW
    datestring
AS

WITH trimdate AS (
    SELECT
        DISTINCT TRIM(datestop) AS datestop
    FROM collated
    )

SELECT
    datestop AS old
    , CASE
        WHEN LENGTH(datestop) = 7
        THEN SUBSTR(datestop, -4) || '-'
            || '0' || SUBSTR(datestop, 1, 1)
            || '-' || SUBSTR(datestop, 2, 2 )

        WHEN LENGTH(datestop) = 8
        THEN SUBSTR(datestop, -4) || '-'
            || SUBSTR(datestop, 1, 2)
            || '-' || SUBSTR(datestop, 3, 2 )

        WHEN datestop LIKE '%/%'
        THEN SUBSTR(datestop, -4) || '-'
        || SUBSTR(datestop, 1, 2)
        || '-' || SUBSTR(datestop, 4, 2 )

        ELSE datestop
        END AS new

FROM trimdate
ORDER BY new ASC
;


Now re do it:

SELECT
    SUBSTR(new, 6, 2) AS month
    , COUNT(1)
FROM datestring
GROUP BY month
ORDER BY month ASC
;


| month | COUNT(1) |
| ----- | -------- |
|       | 1        |
| 01    | 496      |
| 02    | 452      |
| 03    | 496      |
| 04    | 480      |
| 05    | 496      |
| 06    | 480      |
| 07    | 496      |
| 08    | 496      |
| 09    | 480      |
| 10    | 496      |
| 11    | 480      |
| 12    | 498      |



SELECT
    SUBSTR(new, 10, 2) AS day
    , COUNT(1)
FROM datestring
GROUP BY day
ORDER BY day ASC
;

| day | COUNT(1) |
| --- | -------- |
|     | 1        |
| 01  | 192      |
| 02  | 192      |
| 03  | 192      |
| 04  | 192      |
| 05  | 192      |
| 06  | 192      |
| 07  | 192      |
| 08  | 192      |
| 09  | 192      |
| 10  | 192      |
| 11  | 192      |
| 12  | 192      |
| 13  | 192      |
| 14  | 192      |
| 15  | 192      |
| 16  | 192      |
| 17  | 192      |
| 18  | 192      |
| 19  | 192      |
| 20  | 192      |
| 21  | 192      |
| 22  | 192      |
| 23  | 192      |
| 24  | 192      |
| 25  | 192      |
| 26  | 192      |
| 27  | 192      |
| 28  | 192      |
| 29  | 180      |
| 30  | 176      |
| 31  | 114      |


*/

