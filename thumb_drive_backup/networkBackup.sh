#!/bin/sh
set -e

if [ $(hostname) != 'kyouei-global' ]; then
        echo not kyouei >&2
        exit 1
fi

remoteIp=10.5.2.8
thingsToSync="$(./listBackupDatasets.sh)"

for fs in $thingsToSync; do
  remoteVersion=$(ssh root@$remoteIp zfs list -H -o name -t snapshot -r $fs | grep monthly | tail -1l | sed -e "s/^.*@//")
  localVersion=$(zfs list -H -o name -t snapshot -r $fs | grep monthly | tail -1l | sed -e "s/^.*@//")
  if [ -z "$remoteVersion" ]; then
    zfs send -pLec $fs@$localVersion | ssh root@$remoteIp zfs receive -v -o readonly=on $fs@$localVersion
  else
    if [ "$remoteVersion" != "$localVersion" ]; then
      echo $fs needs sync, local: $localVersion remote: $remoteVersion
      zfs send -LcevI $remoteVersion $fs@$localVersion | ssh root@$remoteIp zfs receive -vF $fs
    else
      echo $fs is up to date
    fi
  fi
done
