#!/bin/sh
set -exo pipefail

zfs program zones ./cleanSnaps.lua

