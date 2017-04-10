#!/bin/sh
set -e
set -o pipefail
set -x

NO_SNAP_NAME=this_snap_name_does_not_exist

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
        EXISTING_SNAP=$NO_SNAP_NAME
        LAST_SNAP=$(echo "$ALL_SNAPS" | tail -n 1)
        TARGET_FILE=./newBackup/$SHORT_NAME


        if [ -f $TARGET_FILE ]
        then
        echo skipping $DS, target $TARGET_FILE already exists
                continue
        fi

        for SNAP in $ALL_SNAPS
        do
                if grep $SNAP ./backupSnaps/$SHORT_NAME >/dev/null
                then
                        EXISTING_SNAP=$SNAP
                else
                        if [ $EXISTING_SNAP == $NO_SNAP_NAME ]
                        then
                                echo $SNAP does not exist in backup, but neither does any parent snapshot, skipping
                                continue
                        fi
                        if ! zfs send -Lecv -I $EXISTING_SNAP $LAST_SNAP > $TARGET_FILE
                        then
                                rm $TARGET_FILE
                                echo FAILED: $DS from $EXISTING_SNAP to $LAST_SNAP
                                exit 1
                        fi
                        break;
                fi
        done

        if [ $EXISTING_SNAP == $NO_SNAP_NAME ]
        then
                echo Did not copy anything for $DS !
                exit 1
        fi
done
