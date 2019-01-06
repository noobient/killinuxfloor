#!/bin/sh

set -e

# install the repos
curl --silent --location https://rpm.nodesource.com/setup_8.x | bash -
curl --silent --location https://dl.yarnpkg.com/rpm/yarn.repo | tee /etc/yum.repos.d/yarn.repo

# install the packages
yum -y install nodejs yarn

# obtain a copy of kf2_autokick
# wonderful workaround for "could not change back" bullcrap by git
sudo -u steam sh -c "cd && git clone https://github.com/Sinewyk/kf2_autokick.git kf2autokick"

# 'build' it
sudo -u steam sh -c "cd ${STEAM_HOME}/kf2autokick && yarn --frozen-lockfile"
