
delete_f_d() 
{
    PRACTISEDIR="/Users/dc/bash_project/sample_backup"
    RUNNER=$1
    TS=`date +%m%d%y%H%M%S`

    #Creating the log Directory
    LOG_DIR=${PRACTISEDIR}/${RUNNER}/log/${TS}
    mkdir -p ${LOG_DIR}
    if [[ $? -ne 0 ]]
    then
        echo "Log directory creation failed"
        exit 1
    else
        LOG_FILE=${PRACTISEDIR}/${RUNNER}/log/${TS}/control_script.log
        touch ${LOG_FILE}
        if [[ $? -ne 0 ]]
        then
            echo "Log directory creation failed"
            exit 1
        else
            ##Delete a file from a directory 
            read -p "Which Directory would you like to delete from: " FINAL_BK_LOC

            if [[ -d ${FINAL_BK_LOC} ]]
            then
                options=`ls ${FINAL_BK_LOC}`

                PS3="Please select file or directory to delete: "

                select options in ${options}
                do 
                echo "You have selected to delete:  '${options}'" 
                read -p "Are you sure you want to remove the file or directory '${options}' : " ANS
                if [[ $ANS == 'Y' || $ANS == 'y' || $ANS == 'yes' || $ANS == "YES" ]]
                then
                    echo "Removing ${options}"
                    rm -rf ${options}
                    echo "The remaining files in the directory are:" 
                    ls  ${FINAL_BK_LOC}|nl -s '] '
                elif [[ $ANS == 'N' || $ANS == 'n' || $ANS == 'no' || $ANS == "NO" ]]
                then
                    echo "File or directory deletion cancelled"
                else
                    echo "Invalid Option"
                fi
                exit
                done
            else
            echo "Specified directory does not exist"
            exit
            fi
        fi
    fi
            TS=`date +%m%d%y%H%M%S`
            echo "Ending the script at ${TS}">>${LOG_FILE}
}


scp_f_d()
{
    PRACTISEDIR="/Users/dc/bash_project/sample_backup"
    SRC=$1
    RUNNER=$2
    KEY_PATH=$3
    DEST_DIR=$4
    DEST_SERVER=$5 ##The destination server hostname and IP address
    DEST_SCRIPT="/home/admin/scripts"
    TS=`date +%m%d%y%S`
     
    #Creating the log Directory
    LOG_DIR=${PRACTISEDIR}/${RUNNER}/scp_log/${TS}
    mkdir -p ${LOG_DIR}
    if [[ $? -ne 0 ]]
    then
        echo "Log directory creation failed"
        exit 1
    else
        LOG_FILE=${PRACTISEDIR}/${RUNNER}/scp_log/${TS}/control_script.log
        touch ${LOG_FILE}
        if [[ $? -ne 0 ]]
        then
            echo "Log directory creation failed"
            exit 1
        else
        #SSHing into the server to see if the destination directory exist, if not, it creates it.
        echo "SSHing into the remote server"
        ssh -i ${KEY_PATH} ${DEST_SERVER} "${DEST_SCRIPT}/check_dir.sh ${DEST_DIR} ${RUNNER} ${TS}"
        #Checking the exit status of the SSH command
        if [[ $? == 0 ]]
        then 
            echo "SSH into remote server and backup directory setup successful"
        else
            echo "SSH into remote server and backup directory setup failed"
            exit
        fi
            
        ##SCP the file or directory to the destination server

        scp -r -i ${KEY_PATH} ${SRC} ${DEST_SERVER}:${DEST_DIR}/${RUNNER}/${TS}
        if [[ $? == 0 ]]
        then
            echo "SCP to remote server successful"
        else
            echo "SCP to remote server failed"
            exit
        fi

        echo "Ending file or directory copy"
       fi
    fi
}

scp_f_d dummy.py tolux /Users/dc/bash_project/sonar.pem /backup admin@10.0.0.72