#! /bin/bash

DB_NAME=<ENTER DATABASE NAME HERE>
DB_USER=<ENTER DATABASE USER>
DB_PASS=<ENTER PASSWORD>
DB_EXTRA_TABLES_SCHEMA_FILE=os-extra-tables-schema.sql
DB_DATA_FILE=os-data.sql
IGNORED_TABLES_STRING="";

while read PRESENT_TABLES
do
 IGNORED_TABLES_STRING+=" --ignore-table=os_mysql.${PRESENT_TABLES}"
done < <ENTER os_table.csv FILE PATH HERE>

# Exports extra tables schema
mysqldump -u$DB_USER -p$DB_PASS --no-data --complete-insert ${IGNORED_TABLES_STRING} $DB_NAME > $DB_EXTRA_TABLES_SCHEMA_FILE

# Exports data dump.
mysqldump -u$DB_USER -p$DB_PASS --no-create-info --complete-insert $DB_NAME > $DB_DATA_FILE

# Appends the data dump file with extra tables schema and creates zip of new sql which contains the extra tables schema and data.
cat $DB_EXTRA_TABLES_SCHEMA_FILE $DB_DATA_FILE > temp.sql && mv temp.sql os_fresh.sql && zip os_fresh.zip os_fresh.sql

# Removes the sql files DB extra tables schema and data dump
rm $DB_EXTRA_TABLES_SCHEMA_FILE $DB_DATA_FILE 

