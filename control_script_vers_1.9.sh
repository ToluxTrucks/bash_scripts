#!/bin/bash
#Purpose:Checks if the backup directory exists
#Website: Toluxtrucks.com
#Created Date: Sat Nov 5 23:57:31 EDT 2022
#Author: Tolulope Gbadamosi


PRACTISEDIR="/Users/dc/bash_project/sample_backup"
SRC=$1
DEST=$2
RUNNER=$3
BACKUP_TYPE=$4
TS=`date +%m%d%y`

if [[ $4 == "f" ]]
then
    BACKUP_TYPE="FILE"
else   
    BACKUP_TYPE="DIRECTORY"
fi

FINAL_BK_LOC="${PRACTISEDIR}/${DEST}/${RUNNER}/${BACKUP_TYPE}/${TS}"




if [[ $# -ne 4 ]]
then
    echo "Required command line arugument incomplete"
    echo "The first command line argumnent should be: 'SOURCE FILE OR DIRECTORY'
          The second command line argumnent should be: 'DESTINATION DIRECTORY'
          The third command line argumnent should be: 'RUNNER(Your name)'"
    exit
else
    # Creating a new directory called myfirstdir
    echo "Starting control script"
    if [[ -d ${FINAL_BK_LOC} ]]
    then
        echo "Directory Exists"
        exit
    else
        echo "Directory does not exist, creating new Directory: ${FINAL_BK_LOC}"
         mkdir -p ${FINAL_BK_LOC}
        if [[ $? -ne 0 ]]
        then
            echo "Creation of ${FINAL_BK_LOC} failed"
            exit
        else
            echo "Directory creation successful"
        fi

    fi
    # Copying source file into destination directory
    echo "Copying ${SRC} to ${FINAL_BK_LOC}"
    cp -r ${SRC} ${FINAL_BK_LOC}
    if [[ $? -ne 0 ]]
    then
        echo "The copy command failed"
        exit
    else
        echo "The file was copied successfully"
    fi

    # Listing the content of ${PRACTISEDIR}/${DEST}
    echo "Listing the content of ${FINAL_BK_LOC} directory"
    ls -ltr ${FINAL_BK_LOC}

    # Counting the content of ${PRACTISEDIR}/${DEST}
    echo "Counting the content of${FINAL_BK_LOC} directory"
    ls -ltr ${FINAL_BK_LOC}|wc -l
fi