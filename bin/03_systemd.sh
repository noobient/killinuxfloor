#!/bin/sh

set -e

# deploy the unit
cp share/kf2.service /etc/systemd/system/

# fix selinux context
restorecon -rv /etc/systemd/system

# systemd refresh
systemctl daemon-reload

# start it automatically
systemctl enable kf2.service
