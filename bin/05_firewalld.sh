#!/bin/sh

set -e

# create a new service
firewall-cmd --new-service=kf2 --permanent

# deploy it
cp share/kf2.xml /etc/firewalld/services/

# fix selinux context
restorecon -rv /etc/firewalld/services/

# allow it
firewall-cmd --add-service=kf2 --permanent

# reload
firewall-cmd --reload
