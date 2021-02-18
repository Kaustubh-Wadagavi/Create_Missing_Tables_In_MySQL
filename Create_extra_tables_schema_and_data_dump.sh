#! /bin/bash

DB_NAME=os_mysql
DB_USER=os_tester
DB_PASS=secrete
DB_EXTRA_TABLES_SCHEMA_FILE=os_extra_tables_schema.sql
DB_DATA_FILE=data.sql
FINAL_DB_FILE=DP_extra_tables_schema_and_data_dump.sql
IGNORED_TABLES_STRING="";

while read PRESENT_TABLES
do
 IGNORED_TABLES_STRING+=" --ignore-table=os_mysql.${PRESENT_TABLES}"
done < os_tables.csv

# Exports extra tables schema
mysqldump -u$DB_USER -p$DB_PASS --single-transaction --skip-lock-tables --no-data --routines --complete-insert ${IGNORED_TABLES_STRING} $DB_NAME > $DB_EXTRA_TABLES_SCHEMA_FILE

# Exports data dump
mysqldump -u$DB_USER -p$DB_PASS --no-create-info --complete-insert  $DB_NAME > $DB_DATA_FILE

#Appends the data dump file with extra tables schema and creates zip of new sql
cat $DB_EXTRA_TABLES_SCHEMA_FILE $DB_DATA_FILE > temp.sql && mv temp.sql $FINAL_DB_FILE && zip $FINAL_DB_FILE.zip $FINAL_DB_FILE

#Removes the sql files
rm $DB_EXTRA_TABLES_SCHEMA_FILE $DB_DATA_FILE $FINAL_DB_FILE

