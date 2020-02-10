#!/usr/bin/env bash
#set -e
#set -x
PASSWORD=$(cat /root/dnsPassword.txt)
curl "https://dynamicdns.park-your-domain.com/update?by=nc&host=kyouei&domain=awise.us&password=$PASSWORD"
# TODO: check result
