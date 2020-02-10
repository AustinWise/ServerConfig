# DNS

The goal of the DNS container is to provide:

* Authoritiative DNS server for ervice discovery for other containers.
* Forwarding DNS resolver for all devices on the network.
* Update dynamic DNS record (not strictly related)

Ideally the forwarding resolver will use something like DNS over TLS
or DNS over HTTPS to resolve. This may require switching from `dnsmasq`
to something like `unbound`.
