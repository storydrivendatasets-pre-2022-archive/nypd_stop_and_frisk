# #!/bin/sh
# DB_NAME=$1
# DEST_DIR=$(dirname $1)
# SRC_DIR=data/stashed/nypd/csv


# echo "Generating schemas from ${SRC_DIR}"
# echo "  into database: ${DB_NAME}"


# find ${SRC_DIR}/20*.csv | while read -r fname; do
#     year=$(basename ${fname%.*})
#     tblname="${year}"
#     echo "Generating schema for table: ${tblname}"
#     if [ "${year}" -eq "2016" ]; then
#         # wtf nypd?
#         encod="utf-8-sig"
#     else
#         encod="latin1"
#     fi

#     head ${fname} | csvsql  \
#          --encoding ${encod} \
#          --no-constraints --no-inference \
#          --snifflimit 100000 \
#          --db sqlite:///${DB_NAME} \
#          --tables ${tblname}

#     echo ".schema ${tblname}" \
#         | sqlite3 ${DB_NAME} \
#         > ${DEST_DIR}/${tblname}.sql
# done
