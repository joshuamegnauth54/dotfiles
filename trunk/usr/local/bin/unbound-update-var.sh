#!/bin/bash
# This script updates Unbound's root.key and root.hints.

/usr/sbin/unbound-anchor -a /etc/unbound/var/root.key
/usr/bin/curl -o /etc/unbound/var/root.hints https://www.internic.net/domain/named.root

chown unbound:unbound /etc/unbound/var/root.key /etc/unbound/var/root.hints

