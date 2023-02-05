#!/bin/bash

# This script takes one argument: the path to a JSON file describing the zone to create.
# It will use the file to create the zone on the server.

# TODO:
# * Check if the zone already exists on the server.
# * Maybe incorperate this into the ansible playbook: https://docs.ansible.com/archive/ansible/2.3/vmadm_module.html

set -euo pipefail
set -x

SERVER_USERNAME=root
SERVER_ID=10.5.2.3
JSON_TEMP_FILE=/tmp/create-zone-$(uuidgen).json

if ! [ $# -eq 1 ]
then
    echo Expected 1 arg, got $#
    exit 1
fi

if ! [ -f $1 ]
then
    echo File does not exist: $1
    exit 1
fi

scp $1 ${SERVER_USERNAME}@${SERVER_ID}:${JSON_TEMP_FILE}
ssh ${SERVER_USERNAME}@${SERVER_ID} vmadm create -f ${JSON_TEMP_FILE}
