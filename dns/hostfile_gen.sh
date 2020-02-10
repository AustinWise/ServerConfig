#!/bin/sh
set -eo pipefail

echo ::1		localhost
echo 127.0.0.1	localhost localhost.local loghost dns
echo
ssh root@10.5.2.3 vmadm list -po nics.0.ip,alias | awk 'BEGIN {FS=":" } { print $1 " " $2 ".wise.local" }' | sort
