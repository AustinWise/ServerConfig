#!/bin/sh
vmadm list -po nics.0.ip,alias | awk 'BEGIN {FS=":" } { print $1 " " $2 ".wise.local" }' | sort
