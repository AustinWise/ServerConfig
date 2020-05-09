#!/bin/bash
#set -e
#set -o pipefail
set -x

echo START > $HOME/backupLog.txt

RSYNC_OPT="-rt --delete -e ssh --human-readable --log-file=$HOME/backupLog.txt --stats"
DEST=root@10.5.2.3:/zones/shares/backup/rsync
#SRC=/mnt
SRC=/cygdrive

rsync $RSYNC_OPT $SRC/d/src/ $DEST/src/
rsync $RSYNC_OPT $SRC/d/AustinWise/ $DEST/AustinWise/
rsync $RSYNC_OPT $SRC/c/Users/AustinWise/OneDrive/ $DEST/AustinOneDrive/
rsync $RSYNC_OPT $SRC/c/Users/AustinWise/DropBox/ $DEST/AustinDropBox/
rsync $RSYNC_OPT $SRC/c/Users/AustinWise/AppData/Roaming/Mozilla/Firefox/Profiles/kqn8ogux.default/ $DEST/FirefoxAustin/
rsync $RSYNC_OPT $SRC/d/G/ $DEST/G/
rsync $RSYNC_OPT $SRC/c/Users/G/AppData/Roaming/Mozilla/Firefox/Profiles/r82h6mbk.default/ $DEST/FirefoxG/

echo done

touch $HOME/.lastBackup
exit 0
