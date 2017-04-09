The idea is there there are two severs, the `main` server and the `backup` server.
The `backup` server is stored offsite. Backups are transported from `main`
to `backup` via a thumb drive.

`./findBackupSnaps.sh` generates a list of snap shots already on `backup`.

`./doBackup.sh` uses `zfs send` to create some incremental backups on master
and saves them to the thumb drive.

TODO: script to recieve the backups.
