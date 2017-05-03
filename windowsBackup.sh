#!/bin/bash
set -e
set -o pipefail
set -x

RSYNC_OPT="-rt --delete -e ssh"
DEST=root@10.5.2.3:/zones/shares/backup/rsync
#SRC=/mnt
SRC=/cygdrive

rsync $RSYNC_OPT $SRC/d/src/ $DEST/src/
rsync $RSYNC_OPT $SRC/d/AustinWise/ $DEST/AustinWise/
rsync $RSYNC_OPT $SRC/c/Users/AustinWise/Downloads/ $DEST/DownAustin/
rsync $RSYNC_OPT $SRC/c/Users/AustinWise/Desktop/ $DEST/DesktopAustin/
rsync $RSYNC_OPT $SRC/d/G/ $DEST/G/
rsync $RSYNC_OPT $SRC/c/Users/G/Downloads/ $DEST/DownG/
rsync $RSYNC_OPT $SRC/c/Users/G/Desktop/ $DEST/DesktopG/

echo done

touch $HOME/.lastBackup
exit 0
