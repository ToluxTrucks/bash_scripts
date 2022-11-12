#!/bin/bash
#Purpose:This script has the copy function, delete function and the SCP function.
#Website: Toluxtrucks.com
#Created Date: Mon Nov 7 10:50:44 EST 2022
#Author: Tolulope Gbadamosi


backup_f_d() 
{
    PRACTISEDIR="/Users/dc/bash_project/sample_backup"
    SRC=$1
    DEST=$2
    RUNNER=$3
    BACKUP_TYPE=$4
    TS=`date +%m%d%y%H%M%S`

    if [[ $4 == "f" ]]
    then
        BACKUP_TYPE="FILE"
    else   
        BACKUP_TYPE="DIRECTORY"
    fi

    #Creating the log Directory
    LOG_DIR=${PRACTISEDIR}/${DEST}/${RUNNER}/${BACKUP_TYPE}/log/${TS}
    mkdir -p ${LOG_DIR}
    LOG_FILE=${PRACTISEDIR}/${DEST}/${RUNNER}/${BACKUP_TYPE}/log/${TS}/control_script.log
    touch ${LOG_FILE}
    echo "Starting the script at ${TS}" >>${LOG_FILE}
    echo "${RUNNER} Initiated the backup function at ${TS}">>${LOG_FILE}

    FINAL_BK_LOC="${PRACTISEDIR}/${DEST}/${RUNNER}/${BACKUP_TYPE}/${TS}"


    if [[ $# -ne 4 ]]
    then
        echo "Required command line arugument incomplete">>${LOG_FILE}
        echo "The first command line argumnent should be: 'SOURCE FILE OR DIRECTORY'
            The second command line argumnent should be: 'DESTINATION DIRECTORY'
            The third command line argumnent should be: 'RUNNER(Your name)'">>${LOG_FILE}
        exit
    else
        # Creating a new directory called myfirstdir
        echo "Starting control script">>${LOG_FILE}
        if [[ -d ${FINAL_BK_LOC} ]]
        then
            echo "Directory Exists">>${LOG_FILE}
            exit
        else
            echo "Directory does not exist, creating new Directory: ${FINAL_BK_LOC}">>${LOG_FILE}
            mkdir -p ${FINAL_BK_LOC}
            if [[ $? -ne 0 ]]
            then
                echo "Creation of ${FINAL_BK_LOC} failed">>${LOG_FILE}
                exit
            else
                echo "Directory creation successful">>${LOG_FILE}
            fi

        fi
        # Copying source file into destination directory
        echo "Copying ${SRC} to ${FINAL_BK_LOC}">>${LOG_FILE}
        cp -r ${SRC} ${FINAL_BK_LOC}
        if [[ $? -ne 0 ]]
        then
            echo "The copy command failed">>${LOG_FILE}
            exit
        else
            echo "The file was copied successfully">>${LOG_FILE}
        fi

    fi
    TS=`date +%m%d%y%H%M%S`
    echo "Ending the script at ${TS}">>${LOG_FILE}
}

delete_f_d() 
{
    if [[ $# -ne 1 ]]
    then
        echo "Wrong command line arguments, One command line argument is required (RUNNER)"
    else
        PRACTISEDIR="/Users/dc/bash_project/sample_backup"
        RUNNER=$1
        TS=`date +%m%d%y%H%M%S`

        #Creating the log Directory
        LOG_DIR=${PRACTISEDIR}/${RUNNER}/delete_log/${TS}
        mkdir -p ${LOG_DIR}
        if [[ $? -ne 0 ]]
        then
            echo "Log directory creation failed"
            exit 1
        else
            LOG_FILE=${PRACTISEDIR}/${RUNNER}/delete_log/${TS}/control_script.log
            touch ${LOG_FILE}
            if [[ $? -ne 0 ]]
            then
                echo "Log directory creation failed"
                exit 1
            else
                echo "Starting the script at ${TS}" >>${LOG_FILE}
                echo "${RUNNER} Initiated the delete function at ${TS}">>${LOG_FILE}
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
        echo "Starting the script at ${TS}" >>${LOG_FILE}
        echo "${RUNNER} Initiated the SCP function at ${TS}">>${LOG_FILE}
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





CONTROL_FLAG=$1
if [[ ${CONTROL_FLAG} == "scheduled_copy" ]]
then 
    if [[ $# -ne 5 ]]
    then
        echo "Incomplete command line arguments"
        exit
    elif [[ $# -eq 5 ]]
    then
        SRC=$2
        DEST=$3
        RUNNER=$4
        BACKUP_TYPE=$5
        backup_f_d ${SRC} ${DEST} ${RUNNER} ${BACKUP_TYPE}
    fi
elif [[ ${CONTROL_FLAG} == "scheduled_delete" ]]
then 
    if [[ $# -ne 2 ]]
    then
        echo "Incomplete command line arguments"
        exit
    elif [[ $# -eq 2 ]]
    then
        RUNNER=$1

        delete_f_d ${RUNNER}
    fi

elif [[ ${CONTROL_FLAG} == "scheduled_scp" ]]
then 
    if [[ $# -ne 6 ]]
    then
        echo "Incomplete command line arguments"
        exit
    elif [[ $# -eq 6 ]]
    then
        SRC=$2
        RUNNER=$3
        KEY_PATH=$4
        DEST_DIR=$5
        DEST_SERVER=$6 ##The destination server hostname and IP address

        scp_f_d ${SRC} ${RUNNER} ${KEY_PATH} ${DEST_DIR} ${DEST_SERVER}
    fi


elif [[ ${CONTROL_FLAG} == "not_scheduled" ]]
then

    read -p "What do you want do?
    Enter 1 for file or directory backup
    Enter 2 for file or directory delete
    Enter 3 for for SCP into remote server
    Entry:   " DECISION

    if [[ ${DECISION} == 1 ]]
    then
        read -p "Enter the source file or directory: " SRC
        read -p "Enter the backup directory: " DEST
        read -p "Enter the Runner: " RUNNER
        read -p "Enter the type of file enter 'd' for directory and 'f' for file " BACKUP_TYPE
    elif [[ ${DECISION} == 2 ]]
    then
        read -p "Please, Enter Your name: " RUNNER

    elif [[ ${DECISION} == 3 ]]
    then
        read -p "Enter the file or directory to be copied: " SRC
        read -p "Enter the Runner: " RUNNER
        read -p "Enter the full path of your key's location: " KEY_PATH
        read -p "Enter the remote backup destination: " DEST_DIR
        read -p "Enter the destination server's hostname and the IP addrress: " DEST_SERVER

    else 
        echo "Invalid selection"
    fi


    case ${DECISION} in 
    1) echo "You selected the file or directory copy function"
        backup_f_d ${SRC} ${DEST} ${RUNNER} ${BACKUP_TYPE}
        ;;
    2) echo "You selected the delete function"
        delete_f_d ${RUNNER} 
        ;;
    3) echo "You selected the Remote SCP option"
        scp_f_d ${SRC} ${RUNNER} ${KEY_PATH} ${DEST_DIR} ${DEST_SERVER}
        ;;
    *) echo "You selected an invalid option"
    esac
else
    echo "Invalid option"
fi


#delete_f_d not_scheduled

#scp_f_d dummy.py  backup/AWSJUL2022 tolux f /Users/dc/bash_project sonar.pem /backup admin@10.0.0.72

#bash  scheduled_scp dummy.py  backup/AWSJUL2022 tolux f /Users/dc/bash_project sonar.pem /backup admin@10.0.0.72

#bash control_script_vers_1.14.sh scheduled_scp sample_backup  backup/AWSJUL2022 tolux f /Users/dc/bash_project sonar.pem /backup admin@10.0.0.72

#scp_f_d dummy.py tolux /Users/dc/bash_project/sonar.pem /backup admin@10.0.0.72

#bash control_script_vers_1.14.sh scheduled_scp dummy.py tolux /Users/dc/bash_project/sonar.pem /backup admin@10.0.0.72