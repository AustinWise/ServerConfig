#!/bin/bash
set -e
set -o pipefail
set -x

RSYNC_OPT="-rt --delete -e ssh --exclude /.cache/"
DEST=root@10.5.2.3:/zones/shares/backup/rsync_ubuntu
SRC=/tank/home

rsync $RSYNC_OPT $SRC/austin/ $DEST/austin/

echo done

touch $HOME/.lastBackup
exit 0
