#!/bin/sh

set -eu

echo -n 'Installing and enabling KF2 services... '

# deploy the unit
cp -f share/kf2.service /etc/systemd/system/
cp -f share/kf2autokick.service /etc/systemd/system/
mkdir -p /etc/systemd/system/kf2.service.d
cp -f share/current_change.html.patch /etc/systemd/system/kf2.service.d/
ln -sf ${STEAM_HOME}/Config/My-Startup.conf /etc/systemd/system/kf2.service.d/kf2.service.conf

# fix selinux context
restorecon -r /etc/systemd/system

# systemd refresh
systemctl --quiet daemon-reload

# start it automatically
systemctl --quiet enable kf2.service
systemctl --quiet enable kf2autokick.service

${ECHO_DONE}
