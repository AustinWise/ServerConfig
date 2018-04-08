#!/bin/sh

set -x
set -e

apt-get update

apt-get upgrade -y

 # .NET Core dependencies plus Graphviz
apt-get install -y --no-install-recommends \
        libunwind8 \
        liblttng-ust0 \
        libcurl3 \
        libssl1.0.0 \
        libuuid1 \
        libkrb5-3 \
        zlib1g \
        libicu55 \
        graphviz

useradd -s /bin/bash -g www-data -m dkp

cp dkp.service /etc/systemd/system/

systemctl enable dkp.service

# Allow the dkp user to stop and start the service
DKP_SUDO=/etc/sudoers.d/dkp
echo "Cmnd_Alias MYAPP_CMNDS = /bin/systemctl start dkp, /bin/systemctl stop dkp" > $DKP_SUDO
echo "dkp ALL=(ALL) NOPASSWD: MYAPP_CMNDS" >> $DKP_SUDO
chmod 440 $DKP_SUDO
