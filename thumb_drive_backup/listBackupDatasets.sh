#!/bin/sh
set -e
set -o pipefail

zfs list -r -H -o name zones/home | sed -e '1d'
zfs list -r -H -o name zones/shares | sed -e '1d' | grep -v dropbox
echo zones/c1b61aba-756c-e3a5-fa73-83333b899618/data/pgsql
