#!/bin/bash
#Purpose:This script allows you to run this script automatically or manually depending on how it is called.
#Website: Toluxtrucks.com
#Created Date: Mon Nov 7 10:48:41 EST 2022
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
    LOG_DIR=${PRACTISEDIR}/${DEST}/${RUNNER}/${BACKUP_TYPE}/delete_log/${TS}
    mkdir -p ${LOG_DIR}
    LOG_FILE=${PRACTISEDIR}/${DEST}/${RUNNER}/${BACKUP_TYPE}/delete_log/${TS}/control_script.log
    touch ${LOG_FILE}
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
    TS=`date +%m%d%y%H%M%S`
    echo "Ending the script at ${TS}">>${LOG_FILE}
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
        delete_f_d ${SRC} ${DEST} ${RUNNER} ${BACKUP_TYPE}
    fi
elif [[ ${CONTROL_FLAG} == "not_scheduled" ]]
then

    read -p "What do you want do?
    Enter 1 for file or directory backup
    Enter 2 for file or directory delete
    Enter 3 for database logical backup
    Entry:   " DECISION

    read -p "Enter the source file or directory" SRC
    read -p "Enter the backup directory" DEST
    read -p "Enter the Runner" RUNNER
    read -p "Enter the type of file enter 'd' for directory and 'f' for file " BACKUP_TYPE


    case ${DECISION} in 
    1) echo "You selected the file or directory copy function"
       backup_f_d ${SRC} ${DEST} ${RUNNER} ${BACKUP_TYPE}
        ;;
    2) echo "You selected the delete function"
    delete_f_d ${SRC} ${DEST} ${RUNNER} ${BACKUP_TYPE}
        ;;
    3) echo "You selected the third option";;
    *) echo "You selected an invalid option"
    esac
fi