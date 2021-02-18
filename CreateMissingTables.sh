#! /bin/bash

IGNORED_TABLES_STRING="";

while read PRESENT_TABLES
do
 IGNORED_TABLES_STRING+=" --ignore-table=os_mysql.${PRESENT_TABLES}"
done < os_tables.csv

mysqldump -uos_tester -psecrete --single-transaction --skip-lock-tables --no-data --routines --complete-insert ${IGNORED_TABLES_STRING} os_mysql > /home/krishagni/Desktop/os-api-tests/src/test/resources/distribution_protocols/os_extra_tables.sql

sed -i 's#<parameter name="schemaDump" value="/schema.sql"></parameter>.*#<parameter name="schemaDump" value="/schema.sql,<Enter Directory Name>/os_extra_tables.sql"></parameter>#' <Enter full path to specific suite.xml file>
