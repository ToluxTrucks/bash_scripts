#!/bin/bash

# Creating a new directory called myfirstdir
echo "Starting control script"
mkdir /Users/dc/bash_project/sample_backup

# Copying source file into destination directory
echo "Copying /Users/dc/Mike_Python/python-scripts/dummy.py to /Users/dc/bash_project/sample_backup"
cp  /Users/dc/Mike_Python/python-scripts/dummy.py /Users/dc/bash_project/sample_backup

# Listing the content of sample_backup directory
echo "Listing the content of myfirstdir directory"
ls -ltr /Users/dc/bash_project/sample_backup