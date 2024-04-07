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

## Creating Containers

Each container is defined with a `.json` file. These are not used by Ansible
currently. They have to be used with `vmadm create -f` to create the containers.
Ansible will then configure them.

Note that starting the `base-64-lts` image starting with version 23.4.0 does not have Python
installed by default. So you will probably get this error:

```
/opt/local/bin/python3: not found
```

To fix, `zlogin` into the zone and install Python:

```bash
pkgin up
pkgin fug
pkgin se python3
pkgin in python312
```

## How to use Ansible playbooks

First, [install Ansible](https://docs.ansible.com/ansible/latest/installation_guide/index.html).
For Ubuntu 20.04, this looks roughly like:

```bash
sudo apt install ansible
```

or

```bash
sudo apt install pip3
pip3 install --user ansible
```

Or on macOS:

```bash
sudo pip3 install --upgrade pip
pip3 install --user ansible
```

NOTE: on macOS, make sure `$HOME/Library/Python/3.x/bin` is on the `PATH`.

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
