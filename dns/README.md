# DNS

The goal of the DNS container is to provide:

* Authoritative DNS server for service discovery for other containers.
* Forwarding DNS resolver for all devices on the network.

Ideally the forwarding resolver will use something like DNS over TLS
or DNS over HTTPS to resolve. This may require switching from `dnsmasq`
to something like `unbound`.
