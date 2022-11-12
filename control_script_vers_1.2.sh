#!/bin/bash

PRACTISEDIR="/Users/dc/bash_project/sample_backup"
DEST=$1
SRC=$2

# Creating a new directory called myfirstdir
echo "Starting control script"
mkdir -p ${PRACTISEDIR}/${DEST}

# Copying source file into destination directory
echo "Copying ${SRC} to ${PRACTISEDIR}/${DEST}"
cp  ${SRC} ${PRACTISEDIR}/${DEST}

# Listing the content of sample_backup directory
echo "Listing the content of myfirstdir directory"
ls -ltr ${PRACTISEDIR}/${DEST}