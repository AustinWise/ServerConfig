# SmartOS server config

This repo contains configuration files and scripts for setting up my [SmartOS][]
home server. There are configuration files for the global zone as well as the
various containers/zones and VMs that run on it. I'm in the process of migrating
the configuration of the zones to [Ansible][].

# File System Layout

The main zpool is named `zones`. This is the default SmartOS pool name. Home
directories live under `/zones/home`. Shared files live under `/zones/shares`.
These datasets are mapped into some zones using `lofs`. The goal is for most
zones zones to be disposable and for persistent data to live in either in the
home directories or the shares. The notable exception to this is the PostgreSQL
zone.

The delegated data set feature of zones is not used as the delegated datasets
are deleted when the zone is deleted.


[SmartOS]: https://www.joyent.com/smartos
[Ansible]: https://www.ansible.com/
