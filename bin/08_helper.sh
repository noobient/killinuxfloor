#!/bin/sh

set -e

# create the dir
sudo -u steam sh -c 'mkdir -p ~/bin'

# make a local copy of kf2-centos for easier updates
sudo -u steam sh -c "cd && git clone https://github.com/bviktor/kf2-centos.git"

# deploy the helpers
ln -sT ${STEAM_HOME}/kf2-centos/share/kf2.sh ${STEAM_HOME}/bin/kf2.sh
ln -sT ${STEAM_HOME}/kf2-centos/share/autokick.sh ${STEAM_HOME}/bin/autokick.sh

# fix ownership
chown -R steam.steam ${STEAM_HOME}/bin

# fix selinux context
restorecon -rv ${STEAM_HOME}/bin
