#!/bin/sh

set -e

# deploy the unit
cp share/kf2.service /etc/systemd/system/
cp share/kf2autokick.service /etc/systemd/system/
mkdir -p /etc/systemd/system/kf2.service.d
ln -sf ${STEAM_HOME}/Config/mutators.conf /etc/systemd/system/kf2.service.d/kf2.service.conf

# fix selinux context
restorecon -rv /etc/systemd/system

# systemd refresh
systemctl daemon-reload

# start it automatically
systemctl enable kf2.service
systemctl enable kf2autokick.service
