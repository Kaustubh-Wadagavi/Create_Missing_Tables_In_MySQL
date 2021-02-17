#! /bin/bash

while read line
do
   echo "Record is : $line";
   mysqldump -uos_tester -p -no-data --ignore-tables=os_mysql.$line --complete-insert os_mysql > os_extra_tables.sql
done < os_tables.csv
