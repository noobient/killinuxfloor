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
sh bin/09_init.sh

echo
echo -e "Installation finished. You may now manage your KF2 server with the 'steam' user."
echo -e "To switch to the steam user, use \e[36msudo -iu steam\e[0m. Switch back with \e[36mexit\e[0m."
echo -e "The configuration files can be found under \e[36m/home/steam/Config\e[0m."
echo "If you have previous config backed up, you may restore them now."
echo -e "After you change settings, don't forget to run \e[36mkf2.sh config && kf2.sh restart\e[0m."
echo
