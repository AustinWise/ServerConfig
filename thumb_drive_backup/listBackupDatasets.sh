#!/bin/sh
set -e
set -o pipefail

zfs list -r -H -o name zones/home | sed -e '1d'
zfs list -r -H -o name zones/shares | sed -e '1d' | grep -v dropbox | grep -v torrents | grep -v steamapps
