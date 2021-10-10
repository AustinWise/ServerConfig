The idea is there there are two severs, the `main` server and the `backup`
server. The `backup` server is stored offsite. Backups are transported as
incremental `zfs send` streams via via a thumb drive.

# Initial backups

These can be generated with:

```
zfs send -pLec dsname@snapname
```

The meaning of flags:

* `-p`: include properties
* `-L`: use large blocks
* `-e`: allow sending data embedded in blockpointer
* `-c`: send compressed data without decompressing

The initial backup stream can be received by:

```
zfs receive -v -o readonly=on dsname@snapname
```

# Mounting an encrypted thumb drive

```
zpool import thumb
zfs load-key -a
zfs mount -a
```

# Workflow

In the following example, `kyouei` is the main server while `backup` stores the
backups.

* On `backup`, run `./findBackupSnaps.sh` to generate a list of snap shots that
  already exist.
* On `kyouei`, run `./doBackup.sh` to generate incremental `zfs send` streams
  of the snappshots that don't exist on `backup`.
* On `backup`, run `./recieveBackup.sh` to `zfs receive` the snapshots.
