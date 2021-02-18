#! /bin/bash

IGNORED_TABLES_STRING="";

while read PRESENT_TABLES
do
 IGNORED_TABLES_STRING+=" --ignore-table=os_mysql.${PRESENT_TABLES}"
done < <ENTER PATH TO CSV FILE>

mysqldump -uos_tester -psecrete --single-transaction --skip-lock-tables --no-data --routines --complete-insert ${IGNORED_TABLES_STRING} os_mysql > <ENTER FULL PATH OF SPECIFIC SUITE WITH FILE NAME>

sed -i 's#<parameter name="schemaDump" value="/schema.sql"></parameter>.*#<parameter name="schemaDump" value="/schema.sql,/<ENTER-SPECIFIC-SUITE-DIRECTORY-NAME>/os_extra_tables.sql"></parameter>#' <ENTER FULL PATH TO SPECIFIC SUITE.XML FILE>
