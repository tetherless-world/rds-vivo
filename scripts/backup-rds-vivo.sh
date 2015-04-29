#!/bin/bash

export BACKUP_DATE=`date +"%Y%m%d-%H-%M-%S"`
export BACKUP_DIR=/opt/backup/rds-vivo-mysql
export CONTAINER=rds_mysql_1
export ENV_FILE=/project/rds/vivo-mysql.env
export DUMP_FILE=${BACKUP_DIR}/rds-vivo.${BACKUP_DATE}.sql
export ERROR_FILE=${BACKUP_DIR}/rds-vivo.${BACKUP_DATE}.error.log
export NOTIFY_USER=zednis2@rpi.edu
export MAIL_SENDER=zednis2@rpi.edu
export BACKUP_LOG=/var/log/rds.backup.log

# TODO read these from ${ENV_FILE}
export MYSQL_USER=vivo
export MYSQL_PASSWORD=docker-test
export MYSQL_DB=vivodb

#if [ ! -s ${ENV_FILE} ]; then
#    echo "RDS VIVO DB Backup Failure: $(date)" >> ${BACKUP_LOG}
#    echo "unable to locate file ${ENV_FILE}" >> ${BACKUP_LOG}
#    exit 1
#fi

#source ${ENV_FILE}

# Run the backup command
docker exec -it ${CONTAINER} mysqldump --user=${MYSQL_USER} --password=${MYSQL_PASSWORD} ${MYSQL_DB} > ${DUMP_FILE} 2> ${ERROR_FILE}

# GZIP DUMP_FILE if it exists (and is not empty)
if [ -s ${DUMP_FILE} ] ; then
    gzip ${DUMP_FILE}
fi

# Check if the backup succeeded
if [ $? != 0 ] ; then
    # Log error message
    echo "RDS VIVO DB Backup Failure: $(date)" >> ${BACKUP_LOG}
    cat ${ERROR_FILE} >> ${BACKUP_LOG}
else
    # Log backup success
    echo "RDS VIVO DB Backup Successful: $(date)" >> ${BACKUP_LOG}
fi

# Delete ERROR_FILE if it is empty
if [ ! -s ${ERROR_FILE} ] ; then
    rm ${ERROR_FILE}
fi

# clean out the backups directory
find ${BACKUP_DIR} -mtime +14 -delete
