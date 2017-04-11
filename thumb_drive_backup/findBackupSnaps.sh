#!/bin/sh
set -e
set -x

if [ "backup" != $(hostname) ]
then
	echo not running on backup!
	exit 1
fi

for DS in $(./listBackupDatasets.sh)
do
        zfs list -t snap -d 1 -H -o name $DS > backupSnaps/$(echo $DS | sed -e 's/.*\///')
done

echo FOUND THEM!
