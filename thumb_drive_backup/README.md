The idea is there there are two severs, the `main` server and the `backup`
server. The `backup` server is stored offsite. Backups are transported as
incremental `zfs send` streams via via a thumb drive.

# Workflow

In the following example, `kyouei` is the main server while `backup` stores the
backups.

* On `backup`, run `./findBackupSnaps.sh` to generate a list of snap shots that
  already exist.
* On `kyouei`, run `./doBackup.sh` to generate incremental `zfs send` streams
  of the snappshots that don't exist on `backup`.
* On `backup`, run `./recieveBackup.sh` to `zfs receive` the snapshots.
