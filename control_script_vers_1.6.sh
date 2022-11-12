#!/bin/bash
#Purpose:This requires your script to check for the correct number of command line arguments and give a Utilization description to a user when the wrong command line arguments are passed.
#Website: Toluxtrucks.com
#Created Date: Sat Nov 5 23:30:26 EDT 2022
#Author: Tolulope Gbadamosi


PRACTISEDIR="/Users/dc/bash_project/sample_backup"
SRC=$1
DEST=$2
RUNNER=$3
TS=`date +%m%d%y`
FINAL_BK_LOC="${PRACTISEDIR}/${DEST}/${RUNNER}/${TS}"

if [[ $# -ne 3 ]]
then
    echo "Required command line arugument incomplete"
    echo "The first command line argumnent should be: 'SOURCE FILE OR DIRECTORY'
          The second command line argumnent should be: 'DESTINATION DIRECTORY'
          The third command line argumnent should be: 'RUNNER(Your name)'"
    exit
else
    # Creating a new directory called myfirstdir
    echo "Starting control script"
    mkdir -p ${FINAL_BK_LOC}

    # Copying source file into destination directory
    echo "Copying ${SRC} to ${FINAL_BK_LOC}"
    cp -r ${SRC} ${FINAL_BK_LOC}/${SRC}_${TS}

    # Listing the content of ${PRACTISEDIR}/${DEST}
    echo "Listing the content of ${FINAL_BK_LOC} directory"
    ls -ltr ${FINAL_BK_LOC}

    # Counting the content of ${PRACTISEDIR}/${DEST}
    echo "Counting the content of${FINAL_BK_LOC} directory"
    ls -ltr ${FINAL_BK_LOC}|wc -l
fi