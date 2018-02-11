#!/bin/sh

set -x
set -e

apt-get update

apt-get upgrade -y

 # .NET Core dependencies
apt-get install -y --no-install-recommends \
        libunwind8 \
        liblttng-ust0 \
        libcurl3 \
        libssl1.0.0 \
        libuuid1 \
        libkrb5-3 \
        zlib1g \
        libicu55

useradd -s /bin/bash -g www-data -m dkp

cp dkp.service /etc/systemd/system/

systemctl enable dkp.service

#TODO: add this to sudoers
# Cmnd_Alias MYAPP_CMNDS = /bin/systemctl start dkp, /bin/systemctl stop dkp
# dkp ALL=(ALL) NOPASSWD: MYAPP_CMNDS
