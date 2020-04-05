#!/bin/sh

set -e
set -x

groupadd -g 1001 media
groupadd -g 1002 gmedia
groupadd -g 1003 austin
groupadd -g 1004 g
groupadd wheel || true

useradd -s /usr/bin/bash -g austin -G media,wheel -m -u 1001  -d /zones/home/austin austin
useradd -s /usr/bin/bash -g g -G gmedia -m -u 1002 -d /zones/home/g g
