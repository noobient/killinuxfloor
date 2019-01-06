#!/bin/sh

set -eu

echo -n 'Installing auto-kick bot... '

# install the repos
curl --silent --location https://rpm.nodesource.com/setup_8.x | bash -
curl --silent --location https://dl.yarnpkg.com/rpm/yarn.repo | tee /etc/yum.repos.d/yarn.repo

# install the packages
yum -y -q install nodejs yarn

if [ -d ${STEAM_HOME}/kf2autokick ]
then
    sudo -u steam sh -c 'cd ~/kf2autokick && git reset --quiet --hard && git pull --quiet'
else
    # obtain a copy of kf2_autokick
    # wonderful workaround for "could not change back" bullcrap by git
    sudo -u steam sh -c "cd && git clone --quiet https://github.com/Sinewyk/kf2_autokick.git kf2autokick"
fi

# 'build' it
sudo -u steam sh -c "cd ${STEAM_HOME}/kf2autokick && yarn --quiet --frozen-lockfile"

echo 'done.'
