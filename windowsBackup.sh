#!/bin/bash
set -e
set -o pipefail
set -x

RSYNC_OPT="-rt --delete -e ssh"
DEST=root@10.5.2.3:/zones/shares/backup/rsync

rsync $RSYNC_OPT /mnt/d/src/ $DEST/src/
rsync $RSYNC_OPT /mnt/d/AustinWise/ $DEST/AustinWise/
rsync $RSYNC_OPT /mnt/c/Users/AustinWise/Downloads/ $DEST/DownAustin/
rsync $RSYNC_OPT /mnt/c/Users/AustinWise/Desktop/ $DEST/DesktopAustin/
rsync $RSYNC_OPT /mnt/d/G/ $DEST/G/
rsync $RSYNC_OPT /mnt/c/Users/G/Downloads/ $DEST/DownG/
rsync $RSYNC_OPT /mnt/c/Users/G/Desktop/ $DEST/DesktopG/

echo done
