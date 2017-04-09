#!/bin/sh
set -e
set -x

for DS in $(./listBackupDatasets.sh)
do
        zfs list -t snap -d 1 -H -o name $DS > backupSnaps/$(echo $DS | sed -e 's/.*\///')
done
