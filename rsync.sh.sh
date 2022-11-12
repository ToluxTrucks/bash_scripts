#!/bin/bash
#Purpose:Incomplete rsync function script
#Website: Toluxtrucks.com
#Created Date: Mon Nov 7 12:22:29 EST 2022
#Author: Tolulope Gbadamosi

#!/bin/bash

rsync_f_d()
{
    PRACTISEDIR="/Users/dc/bash_project/sample_backup"
    SRC=$1
    DEST=$2
    RUNNER=$3
    BACKUP_TYPE=$4
    KEY_NAME=$5
    DEST_DIR=$6
    DEST_SERVER=$7 ##The destination server hostname and IP address
    DEST_SCRIPT="/home/admin/scripts"
    TS=`date +%m%d%y%S`
    
    #Creating the log file for the function 
    LOG_DIR=${PRACTISEDIR}/${DEST}/${RUNNER}/${BACKUP_TYPE}/log/${TS}
    mkdir -p ${LOG_DIR}
    LOG_FILE=${PRACTISEDIR}/${DEST}/${RUNNER}/${BACKUP_TYPE}/log/${TS}/control_script.log
    touch ${LOG_FILE}


    #SSHing into the server to see if the destination directory exist, if not, it creates it.
    echo "SSHing into the remote server"
    ssh -i ${KEY_DIR}/${KEY_NAME} ${DEST_SERVER} "${DEST_SCRIPT}/check_dir.sh ${DEST_DIR} ${RUNNER} ${TS}"
    #Checking the exit status of the SSH command
    if [[ $? == 0 ]]
    then 
        echo "SSH into remote server and backup directory setup successful"
    else
        echo "SSH into remote server and backup directory setup failed"
        exit
    fi
        
    ##SCP the file or directory to the destination server

    rsync  -avzh -e "ssh -i ${KEY_NAME}" ${SRC} ${DEST_SERVER}:${DEST_DIR}/${RUNNER}/${TS}
    if [[ $? == 0 ]]
    then
        echo "RSYNC to remote server successful"
    else
        echo "RYSNC to remote server failed"
        exit
    fi

    echo "Ending file or directory copy"


}


rsync_f_d sample_backup backup/AWSJUL2022 tolux23 f "/Users/dc/bash_project/sonar.pem" /backup admin@10.0.0.72