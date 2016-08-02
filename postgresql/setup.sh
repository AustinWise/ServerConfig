#!/bin/sh
set -e

svcadm disable postgresql
mv /var/pgsql /var/pgsql_old
zfs create -o recordsize=8192 -o compression=lz4 -o mountpoint=/var/pgsql $(zfs list -H -o name /)/data/pgsql
cp -R /var/pgsql_old/data /var/pgsql/
chown -R postgres:postgres /var/pgsql
