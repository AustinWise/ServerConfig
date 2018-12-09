#!/bin/sh
echo local-zone: \"wise.local.\" static
vmadm list -po nics.0.ip,alias | awk 'BEGIN {FS=":" } { print "local-data: \""$2".wise.local. IN A "$1"\"" }' | sort
vmadm list -po nics.0.ip,alias | awk 'BEGIN {FS=":" } { print "local-data-ptr: \""$1" "$2".wise.local.\"" }' | sort
