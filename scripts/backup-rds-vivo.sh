#!/bin/bash

export BACKUP_DATE=`date +"%Y%m%d-%H-%M-%S"`
export BACKUP_DIR=/opt/backup/rds-vivo-mysql
export CONTAINER=rds_mysql_1
export DUMP_FILE=${BACKUP_DIR}/rds-vivo.${BACKUP_DATE}.sql
export ERROR_FILE=${BACKUP_DIR}/rds-vivo.${BACKUP_DATE}.error.log
export NOTIFY_USER=zednis2@rpi.edu
export MAIL_SENDER=zednis2@rpi.edu

# Run the backup command
docker exec -it $CONTAINER mysqldump > $DUMP_FILE 2> $ERROR_FILE

# GZIP DUMP_FILE if it exists (and is not empty)
if [ -s $DUMP_FILE ] ; then
    gzip $DUMP_FILE
fi

# Send an email if there was an error
#if [ $? != 0 ] ; then
#    cat $ERROR_FILE | mailx -s "LDAP backup FAILED" -r $MAIL_SENDER $NOTIFY_USER
#fi

# Delete ERROR_FILE if it is empty
if [ ! -s $ERROR_FILE ] ; then
    rm $ERROR_FILE
fi

# clean out the backups directory
find ${BACKUP_DIR} -mtime +14 -delete