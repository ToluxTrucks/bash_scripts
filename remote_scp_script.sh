#!/bin/bash

BACKUP_LOC=$1
RUNNER=$2
TS=$3
if [[ -d ${BACKUP_LOC}/${RUNNER}/${TS} ]]
then
   echo "Directory exists"
   exit
else
   echo "Directory does not exist"
   echo "Creating the directory now"
   mkdir -p ${BACKUP_LOC}/${RUNNER}/${TS}
   if [[ $? == 0 ]]
   then
      echo "Directory creation successful"
   else
      echo "Directory creation failed"
      exit 1 
   fi
fi