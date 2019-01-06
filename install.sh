#!/bin/sh

set -eu

read -p "This will install Killing Floor 2 on this machine. Type 'y' to continue: " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    echo 'Installation cancelled.'
    exit
fi

echo 'Installing Killing Floor 2... '

export STEAM_HOME='/home/steam'

sh bin/01_steamcmd.sh
sh bin/02_kf2.sh
sh bin/03_systemd.sh
sh bin/04_sudo.sh
sh bin/05_firewalld.sh
sh bin/06_config.sh
sh bin/07_autokick.sh
sh bin/08_helper.sh
