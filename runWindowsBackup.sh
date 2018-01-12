#!/bin/bash
set -e
set -o pipefail
set -x

THISDIR=$(cd $(dirname $0); pwd -P)
cd $THISDIR

bash ./windowsBackup.sh 2>&1 >$HOME/backupNotes.txt

exit 0
