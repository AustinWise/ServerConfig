#!/bin/sh
set -euxo pipefail

NO_SNAP_NAME=this_snap_name_does_not_exist

BACKUP_ALL=0

while [[ $# > 0 ]]; do
        case "$1" in
                --all)
                        BACKUP_ALL=1
                ;;
                *)
                        echo Unknown option: $0
                        exit 1
                ;;
        esac
        shift
done

if [ $(hostname) != 'kyouei-global' ]; then
        echo not kyouei >&2
        exit 1
fi

for DS in $(./listBackupDatasets.sh)
do
        SHORT_NAME=$(echo $DS | sed -e 's/.*\///')
        BACKUP_SNAPS=./backupSnaps/$SHORT_NAME
        REMOTE_SNAP=$NO_SNAP_NAME

        if [ ! -f $BACKUP_SNAPS ]
        then
                echo No existing snapshot names for ${SHORT_NAME}, skipping
                continue
        fi

        LOCAL_SNAPS=$(zfs list -d 1 -t snap -H -o name -s createtxg $DS)
        if [ $BACKUP_ALL == 0 ]
        then
                LOCAL_SNAPS=$(echo "$LOCAL_SNAPS" | grep @monthly)
        fi
        SNAP_TO_SEND=$(echo "$LOCAL_SNAPS" | tail -n 1)
        TARGET_FILE=./newBackup/$SHORT_NAME


        if [ -f $TARGET_FILE ]
        then
        echo skipping $DS, target $TARGET_FILE already exists
                continue
        fi

        # find the most recent snapshot to start from
        for SNAP in $LOCAL_SNAPS
        do
                if grep $SNAP ./backupSnaps/$SHORT_NAME >/dev/null
                then
                        REMOTE_SNAP=$SNAP
                fi
        done

        if [ $REMOTE_SNAP == $NO_SNAP_NAME ]
        then
                echo Could not find a starting snapshot for $DS !
                exit 1
        fi

        if [ $REMOTE_SNAP == $SNAP_TO_SEND ]
        then
                echo Remote already has most recent backup for $DS
                exit 1
        fi

        if ! zfs send -Lecv -I $REMOTE_SNAP $SNAP_TO_SEND > $TARGET_FILE
        then
                rm $TARGET_FILE
                echo FAILED: $DS from $REMOTE_SNAP to $SNAP_TO_SEND
                exit 1
        fi
done

echo DONE, SUCCESSFULLY!
