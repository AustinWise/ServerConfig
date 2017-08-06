#!/bin/sh

#this are roughly the steps

# first add users

pkgin up
pkgin up
pkging in samba

#now add config files

svcadm enable -r smbd
svcadm enable -r nmbd

smbpasswd -a austin
smbpasswd -a g
