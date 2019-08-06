#!/bin/sh
set -exo pipefail

if [ "backup" != $(hostname) ]
then
        echo "not running on backup!"
        exit 1
fi

zfs program zones ./cleanSnaps.lua

