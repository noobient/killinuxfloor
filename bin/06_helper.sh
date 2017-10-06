#!/bin/sh

set -e

# create the dir
sudo -u steam sh -c 'mkdir -p ~/bin'

# deploy the helper
cp share/kf2.sh ${STEAM_HOME}/bin/

# fix ownership
chown steam.steam ${STEAM_HOME}/bin/kf2.sh

# fix selinux context
restorecon -rv ${STEAM_HOME}/bin
