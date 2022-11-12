# userid="/ as sysdba"
# schemas=STACK_APR22_KOL
# dumpfile=expdp_otunba_stack_apr22_kol.dmp
# logfile=expdp_otunba_stack_apr22_kol.log
# directory=DATA_EXPORT_IMPORT


TS=`date +%m%d%y%H%M%S`
RUNNER=$1 #'/ as sysdba'
DB_NAME=$2
PAR_FILE_DIR=$3 #"/home/oracle/scripts/practicedir_shina_jul22/otunba/${TS}"
PAR_FILE=$4 #/home/oracle/scripts/practicedir_shina_jul22/otunba/${TS}/expdp_otunba.par
# USERID=$5
# SCHEMAS=$6
# DIRECTORY=$7
# DUMPFILE=$8
# LOG_FILE=$9


#checking if the database is up and running.
if ( ps -ef|grep pmon|grep ${DB_NAME} )
then
   echo "Database is up and running"
else
   echo "Database is down"
   exit
fi

#Pointing to the database APEXDB
echo ${DB_NAME} |. oraenv --stdin

#Preparing PARFILE Timestamped parfile LOCATION
mkdir -p ${PAR_FILE_DIR}
if [[ $? -ne 0 ]]
then
   echo "Parfile Directory failed"
   exit
else
   echo "Creating Parfile"
   touch ${PAR_FILE}
   if [[ $? -ne 0 ]]
   then
      echo "Parfile creation failed"
      exit
   else
      echo "Building the parfile configuration file"
      #Building the configuration file
       echo  "userid=${RUNNER}">>${PAR_FILE}
       echo  "schemas=STACK_APR22_KOL">>${PAR_FILE}
       echo  "dumpfile=expdp__otunba_stack_apr22_kol_${TS}.dmp">>${PAR_FILE}
       echo "logfile=expdp_otunba_stack_apr22_kol.${TS}.log">>${PAR_FILE}
       echo "directory=DATA_EXPORT_IMPORT">>${PAR_FILE}
   fi
fi

#Running the configuration file
expdp parfile=${PAR_FILE}
if [[ $? -ne 0 ]]
then
   echo "The backup job failed"
else
   echo "The backup Job ran"
fi


#Checking if backup passed
if ( grep -i "successfully" /backup/AWSJUL22/DATAPUMP/expdp_otunba_stack_apr22_kol.${TS}.log )
then
   echo "Database backup successful"
elif ( grep -i "ORA-" /backup/AWSJUL22/DATAPUMP/expdp_otunba_stack_apr22_kol.${TS}.log )
then
   echo "There is an error in database backup"
fi




      # echo  "userid=${RUNNER}">>${PAR_FILE}
      # echo  "schemas=${SCHEMAS}">>${PAR_FILE}
      # echo  "dumpfile=${DUMPFILE}">>${PAR_FILE}
      # echo "logfile=${LOG_FILE}">>${PAR_FILE}
      # echo "directory=${DIRECTORY}">>${PAR_FILE}