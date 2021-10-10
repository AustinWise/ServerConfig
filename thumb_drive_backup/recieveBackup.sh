#!/bin/sh
set -e
set -o pipefail
set -x

if [ "backup" != $(hostname) ]
then
	echo "not running on backup!"
	exit 1
fi

for DS in $(./listBackupDatasets.sh)
do
	SHORT_NAME=$(echo $DS | sed -e 's/.*\///')
	BACKUP_FILE=newBackup/$SHORT_NAME

	if [ -f $BACKUP_FILE ]
	then
		zfs receive -vF $DS < $BACKUP_FILE
	fi
done

echo DONE, SUCCESS!

