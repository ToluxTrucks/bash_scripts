#!/bin/bash 
FILE='/Users/dc/bash_project/test.sh'
while :
do 
    echo "Checking if EC2 instance has started running"
    sleep 2
    if [[ -e ${FILE} ]]
    then
        break
    fi
done
echo "EC2 Instance started"