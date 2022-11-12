#!/bin/bash
#Purpose: This script would create timestamped directories under the backup directory.
#Website: Toluxtrucks.com
#Created Date: Sat Nov 5 22:16:36 EDT 2022
#Author: Tolulope Gbadamosi


PRACTISEDIR="/Users/dc/bash_project/sample_backup"
SRC=$1
DEST=$2
RUNNER=$3
TS=`date +%m%d%y`
FINAL_BK_LOC="${PRACTISEDIR}/${DEST}/${RUNNER}/${TS}"


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
