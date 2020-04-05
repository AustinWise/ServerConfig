#!/bin/sh
set -e

#send initally with -p so that properties get sent

remoteIp=192.168.1.8
poolName=zones
thingsToSync="c1b61aba-756c-e3a5-fa73-83333b899618/data/pgsql home/austin home/g shares/crap shares/backup shares/gdata shares/isos shares/music shares/photos shares/software shares/videos"

for fs in $thingsToSync; do
  remoteVersion=$(ssh root@$remoteIp zfs list -H -o name -t snapshot -r $poolName/$fs | grep monthly | tail -1l | sed -e "s/^.*@//")
  localVersion=$(zfs list -H -o name -t snapshot -r $poolName/$fs | grep monthly | tail -1l | sed -e "s/^.*@//")
  if [ "$remoteVersion" != "$localVersion" ]; then
    echo $fs needs sync, local: $localVersion remote: $remoteVersion
    zfs send -LcevI $remoteVersion $poolName/$fs@$localVersion | ssh root@$remoteIp zfs receive $poolName/$fs
  else
    echo $fs is up to date
  fi
done
