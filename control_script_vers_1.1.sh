#!/bin/bash
#control_script_vers_1.0.sh

# SOURCE_FILE="/Users/dc/Mike_Python/python-scripts/dummy.py"
# DESTINATION_DIRECTORY="${DEST}"

# cp ${SOURCE_FILE} ${DESTINATION_DIRECTORY}
export PRACTISEDIR="/Users/dc/bash_project/sample_backup"
SRC=/Users/dc/Mike_Python/python-scripts/dummy.py
DEST="myfirstdir"

#!/bin/bash

# Creating a new directory called myfirstdir
echo "Starting control script"
mkdir -p ${PRACTISEDIR}/${DEST}


# Copying source file into destination directory
echo "${SRC} to ${DEST}"
cp  ${SRC} ${PRACTISEDIR}/${DEST}

# Listing the content of sample_backup directory
echo "Listing the content of myfirstdir directory"
ls -ltr ${PRACTISEDIR}/${DEST}