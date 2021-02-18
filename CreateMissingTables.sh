#! /bin/bash

IGNORED_TABLES_STRING="";

while read PRESENT_TABLES
do
 IGNORED_TABLES_STRING+=" --ignore-table=os_mysql.${PRESENT_TABLES}"
done < os_tables.csv

mysqldump -uos_tester -psecrete --single-transaction --skip-lock-tables --no-data --routines --complete-insert ${IGNORED_TABLES_STRING} os_mysql > os_extra_tables.sql

cat os_extra_tables.sql os_fresh.sql > temp.sql && mv temp.sql DP_extra_tables_and_data_dump.sql




