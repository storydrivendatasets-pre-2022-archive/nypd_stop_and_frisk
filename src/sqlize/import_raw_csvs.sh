#!/bin/sh
DB_NAME=$1
SRC_DIR=data/stashed/nypd/csv

echo "Importing raw data from ${SRC_DIR}"
echo "  into database: ${DB_NAME}"


find ${SRC_DIR}/20*.csv | while read -r fname; do
    year=$(basename ${fname%.*})
    tblname="raw_${year}"

    echo "Importing: ${fname} into table: ${tblname}"
    sqlite3 ${DB_NAME} <<SQL_HERE

.bail on
.changes on
.mode csv

DROP TABLE IF EXISTS ${tblname};
.import ${fname} ${tblname}

SQL_HERE

    # if [ "${year}" -eq "2016" ]; then
    #     # wtf nypd?
    #     encod="utf-8-sig"
    # else
    #     encod="latin1"
    # fi

    # csvsql ${fname} \
    #      --encoding ${encod} \
    #      --no-constraints --no-inference \
    #      --snifflimit 100000 --overwrite \
    #      --insert --db sqlite:///${DB_NAME} \
    #      --tables ${tblname}

done
