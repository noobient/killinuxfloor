#!/bin/sh

set -e

# create a dedicated steam user
useradd --user-group --create-home steam

# compat libs required
yum -y install glibc.i686 libstdc++.i686 unzip dos2unix

# create the main steam dir
sudo -u steam sh -c 'mkdir -p ~/Steam'

# obtain steamcmd
sudo -u steam sh -c 'curl -sqL "https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz" | tar -C ~/Steam -zxvf -'

# make sure it's in path
sudo -u steam sh -c 'sed -i.orig '"'"'/^PATH=/ s@$@:$HOME/Steam@'"'"' ~/.bash_profile'
