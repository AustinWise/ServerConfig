#!/bin/sh
set -e

#send initally with -p so that properties get sent

remoteIp=10.5.2.4
poolName=zones
thingsToSync="b259c996-dce5-40e7-b787-f69bf94f6f49-disk0 home/austin home/g shares/crap shares/backup shares/gdata shares/isos shares/music shares/photos shares/software shares/videos"

for fs in $thingsToSync; do
  remoteVersion=$(ssh root@$remoteIp zfs list -H -o name -t snapshot -r $poolName/$fs | grep monthly | tail -1l | sed -e "s/^.*@//")
  localVersion=$(zfs list -H -o name -t snapshot -r $poolName/$fs | grep monthly | tail -1l | sed -e "s/^.*@//")
  if [ "$remoteVersion" != "$localVersion" ]; then
    echo $fs needs sync, local: $localVersion remote: $remoteVersion
    zfs send -e -v -I $remoteVersion $poolName/$fs@$localVersion | ssh root@$remoteIp zfs receive $poolName/$fs
  else
    echo $fs is up to date
  fi
done
