#!/bin/sh

groupadd -g 1001 media
groupadd -g 1002 gmedia
groupadd -g 1003 austin
groupadd -g 1004 g

useradd -s /usr/bin/bash -g austin -G media -m -u 1001 austin
useradd -s /usr/bin/bash -g g -G gmedia -m -u 1002 g

