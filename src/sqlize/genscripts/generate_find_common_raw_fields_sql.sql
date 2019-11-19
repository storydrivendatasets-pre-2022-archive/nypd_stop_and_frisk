SELECT
    'SELECT ' ||
    '''' || name || ''' ' ||
    'AS table_name, ' ||
    '* FROM PRAGMA_TABLE_INFO(' ||
    '''' || name || ''') ' ||
    'UNION ALL'
FROM sqlite_master
WHERE
    type = 'table'
    AND name LIKE 'raw_%'
;
/*
generated and edited output:
----------------------------

SELECT 'raw_2003' AS table_name, * FROM PRAGMA_TABLE_INFO('raw_2003') UNION ALL
SELECT 'raw_2004' AS table_name, * FROM PRAGMA_TABLE_INFO('raw_2004') UNION ALL
SELECT 'raw_2005' AS table_name, * FROM PRAGMA_TABLE_INFO('raw_2005') UNION ALL
SELECT 'raw_2006' AS table_name, * FROM PRAGMA_TABLE_INFO('raw_2006') UNION ALL
SELECT 'raw_2007' AS table_name, * FROM PRAGMA_TABLE_INFO('raw_2007') UNION ALL
SELECT 'raw_2008' AS table_name, * FROM PRAGMA_TABLE_INFO('raw_2008') UNION ALL
SELECT 'raw_2009' AS table_name, * FROM PRAGMA_TABLE_INFO('raw_2009') UNION ALL
SELECT 'raw_2010' AS table_name, * FROM PRAGMA_TABLE_INFO('raw_2010') UNION ALL
SELECT 'raw_2011' AS table_name, * FROM PRAGMA_TABLE_INFO('raw_2011') UNION ALL
SELECT 'raw_2012' AS table_name, * FROM PRAGMA_TABLE_INFO('raw_2012') UNION ALL
SELECT 'raw_2013' AS table_name, * FROM PRAGMA_TABLE_INFO('raw_2013') UNION ALL
SELECT 'raw_2014' AS table_name, * FROM PRAGMA_TABLE_INFO('raw_2014') UNION ALL
SELECT 'raw_2015' AS table_name, * FROM PRAGMA_TABLE_INFO('raw_2015') UNION ALL
SELECT 'raw_2016' AS table_name, * FROM PRAGMA_TABLE_INFO('raw_2016') UNION ALL
SELECT 'raw_2017' AS table_name, * FROM PRAGMA_TABLE_INFO('raw_2017') UNION ALL
SELECT 'raw_2018' AS table_name, * FROM PRAGMA_TABLE_INFO('raw_2018')
;

*/
