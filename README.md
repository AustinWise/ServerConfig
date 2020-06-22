# SmartOS server config

This repo contains configuration files and scripts for setting up my [SmartOS][]
home server. There are configuration files for the global zone as well as the
various containers/zones and VMs that run on it. I'm in the process of migrating
the configuration of the zones to [Ansible][].

## File System Layout

The main zpool is named `zones`. This is the default SmartOS pool name. Home
directories live under `/zones/home`. Shared files live under `/zones/shares`.
These datasets are mapped into some zones using `lofs`. The goal is for most
zones zones to be disposable and for persistent data to live in either in the
home directories or the shares. The notable exception to this is the PostgreSQL
zone.

The delegated data set feature of zones is not used as the delegated datasets
are deleted when the zone is deleted.

## How to use Ansible playbooks

First, [install Ansible](https://docs.ansible.com/ansible/latest/installation_guide/index.html).
For Ubuntu 20.04, this looks roughly like:

```bash
sudo apt install ansible
```

or

```bash
sudo apt install python3-pip
pip3 install --user ansible
```

NOTE: Ansible does not support Windows.

Once installed, the [playbook](https://docs.ansible.com/ansible/latest/user_guide/playbooks.html)
can be run:

```bash
ansible-playbook playbook.yml
```

There are a variety of [command line options](https://docs.ansible.com/ansible/latest/cli/ansible-playbook.html)
for `ansible-playbook`.

You can limit which hosts to interact with using the `-l` arg:

```bash
ansible-playbook playbook.yml -l fs
```

You can set how many hosts are updated at once using the `-f` arg:

```bash
ansible-playbook playbook.yml -f 10
```

[SmartOS]: https://www.joyent.com/smartos
[Ansible]: https://www.ansible.com/
