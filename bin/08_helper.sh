#!/bin/sh

set -eu

echo -n 'Installing helpers... '

# create the dir
sudo -u steam sh -c 'mkdir -p ~/bin'

if [ -d ${STEAM_HOME}/kf2-centos ]
then
    # update
    sudo -u steam sh -c 'cd ~/kf2-centos && git reset --quiet --hard && git pull --quiet'
else
    # make a local copy of kf2-centos for easier updates
    sudo -u steam sh -c "cd && git clone --quiet https://github.com/bviktor/kf2-centos.git"
fi

# deploy the helpers
ln -sTf ${STEAM_HOME}/kf2-centos/share/kf2.sh ${STEAM_HOME}/bin/kf2.sh
ln -sTf ${STEAM_HOME}/kf2-centos/share/autokick.sh ${STEAM_HOME}/bin/autokick.sh

# fix ownership
chown -R steam.steam ${STEAM_HOME}/bin

# fix selinux context
restorecon -r ${STEAM_HOME}/bin

${ECHO_DONE}
