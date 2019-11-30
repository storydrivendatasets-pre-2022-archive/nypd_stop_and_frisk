/*

SELECT race
    , COUNT(1) AS n
    , MIN(year)
    , MAX(year)
FROM collated
GROUP BY race
ORDER BY n DESC
;


| race                           | n       | MIN(year) | MAX(year) |
| ------------------------------ | ------- | --------- | --------- |
| B                              | 2624011 | 2003      | 2016      |
| Q                              | 1232944 | 2003      | 2016      |
| W                              | 501939  | 2003      | 2016      |
| P                              | 310672  | 2003      | 2016      |
| Z                              | 194241  | 2003      | 2016      |
| A                              | 156174  | 2003      | 2016      |
| U                              | 22883   | 2003      | 2016      |
| I                              | 19982   | 2003      | 2016      |
| BLACK                          | 12836   | 2017      | 2018      |
| WHITE HISPANIC                 | 4981    | 2017      | 2018      |
| X                              | 2137    | 2003      | 2005      |
| WHITE                          | 2051    | 2017      | 2018      |
| BLACK HISPANIC                 | 1975    | 2017      | 2018      |
| (null)                         | 335     | 2017      | 2018      |
| ASIAN / PACIFIC ISLANDER       | 221     | 2018      | 2018      |
| ASIAN/PAC.ISL                  | 206     | 2017      | 2017      |
|                                | 165     | 2003      | 2016      |
| AMERICAN INDIAN/ALASKAN NATIVE | 16      | 2018      | 2018      |
| AMER IND                       | 9       | 2017      | 2017      |
| MALE                           | 7       | 2017      | 2017      |


*/
