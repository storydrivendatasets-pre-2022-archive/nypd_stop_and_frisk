#!/bin/sh
# DB_NAME=$1
SRC_DIR=$1

>&2  echo "Creating import script using data files from ${SRC_DIR}..."
>&2  echo "--------------------------------------------------------------------------"
# >&2  echo "  into database: ${DB_NAME}"
echo .log stderr
echo .bail on
echo .echo on
echo .mode csv

find ${SRC_DIR}/20*.csv | while read -r fname; do
    year=$(basename ${fname%.*})
    tblname="raw_${year}"

    echo "DROP TABLE IF EXISTS ${tblname};"
    echo ".import ${fname} ${tblname}"


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
