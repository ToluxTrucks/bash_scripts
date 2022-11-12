#!/bin/bash 
COUNTER=1

while read SCHEMA
do
    echo "Schema ${COUNTER} is ${SCHEMA}"
    (( COUNTER++ ))
    echo "userid=' / as sysdba'" >expdp_${SCHEMA}.par
    echo "schemas=${SCHEMA}">>expdp_${SCHEMA}.par
    echo "dumpfile=expdp_${SCHEMA}.dmp">>expdp_${SCHEMA}.par
    echo "logfile=expdp_${SCHEMA}.log">>expdp_${SCHEMA}.par
    echo "directory=DATA_EXPORT_IMPORT">>expdp_${SCHEMA}.par

done < /Users/dc/bash_project/db_user.log
