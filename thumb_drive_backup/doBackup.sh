#!/bin/sh
set -e
set -o pipefail
set -x

if [ $(hostname) != 'kyouei' ]; then
	echo not kyouei >&2
	exit 1
fi

for DS in $(./listBackupDatasets.sh)
do
        SHORT_NAME=$(echo $DS | sed -e 's/.*\///')
        BACKUP_SNAPS=./backupSnaps/$SHORT_NAME
        if [ ! -f $BACKUP_SNAPS ]
        then
                continue
        fi
        ALL_SNAPS=$(zfs list -d 1 -t snap -H -o name $DS | grep @monthly)
        EXISTING_SNAP=this_snap_name_does_not_exist
        LAST_SNAP=$(echo "$ALL_SNAPS" | tail -n 1)
        for SNAP in $ALL_SNAPS
        do
                if grep $SNAP ./backupSnaps/$SHORT_NAME >/dev/null
                then
                        EXISTING_SNAP=$SNAP
                else
                        zfs send -Lecv -I $EXISTING_SNAP $LAST_SNAP > ./newBackup/$SHORT_NAME
                        break;
                fi
        done
done
