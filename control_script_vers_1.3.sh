
#!/bin/bash

PRACTISEDIR="/Users/dc/bash_project/sample_backup"
DEST=$1
SRC=$2
TS=`date +%s%M%H`

# Creating a new directory called myfirstdir
echo "Starting control script"
echo $TS
mkdir -p ${PRACTISEDIR}/${DEST}

# Copying source file into destination directory
echo "Copying ${SRC} to ${PRACTISEDIR}/${DEST}"
cp -r ${SRC} ${PRACTISEDIR}/${DEST}

# Listing the content of ${PRACTISEDIR}/${DEST}
echo "Listing the content of myfirstdir directory"
ls -ltr ${PRACTISEDIR}/${DEST}

# Counting the content of ${PRACTISEDIR}/${DEST}
echo "Counting the content of myfirstdir directory"
ls -ltr ${PRACTISEDIR}/${DEST}|wc -l