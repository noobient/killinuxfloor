#!/bin/sh

set -e

# install crudini
yum -y install epel-release
yum -y install crudini

# create the config dir
sudo -u steam sh -c 'mkdir -p ~/Config'

# easy access to stock config files
sudo -u steam sh -c 'ln -s ~/Steam/KF2Server/KFGame/Config ~/Config/Internal'
