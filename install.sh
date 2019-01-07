#!/bin/sh

set -eu

read -p "This will install Killing Floor 2 on this machine. Press 'y' to continue: " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    echo 'Installation cancelled.'
    exit
fi

echo 'Installing Killing Floor 2... '

export STEAM_HOME='/home/steam'
export ECHO_DONE='echo -e \e[32mdone\e[0m.'

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
echo -e "\e[32mInstallation finished!\e[0m You may now manage your KF2 server with the 'steam' user."
echo -e "To switch to the steam user, use \e[36msudo -iu steam\e[0m. Switch back with \e[36mexit\e[0m."
echo -e "The configuration files can be found under \e[36m/home/steam/Config\e[0m."
echo "If you have previous config backed up, you may restore them now."
echo
echo "List of config files:"
echo -e "\e[36mMy-Cycles.csv\e[0m - User defined map cycles"
echo -e "\e[33mMy-KFWeb.ini\e[0m - Webadmin settings"
echo -e "\e[33mMy-KFWebAdmin.ini\e[0m - Webadmin settings"
echo -e "\e[33mMy-LinuxServer-KFEngine.ini\e[0m - Starting map, takeover, etc."
echo -e "\e[33mMy-LinuxServer-KFGame.ini\e[0m - Password, difficulty, length, etc."
echo -e "\e[36mMy-Maps.csv\e[0m - Subscribed workshop maps"
echo -e "\e[36mMy-Mutators.csv\e[0m - Subscribed workshop mutators"
echo -e "\e[36mMy-Startup.conf\e[0m - Mutators to load at startup"
echo -e "\e[36mautokick.json\e[0m - Auto-kick bot settings"
echo
echo -e "Files marked in \e[33myellow\e[0m are for all the game/server options provided by Tripwire."
echo "Now they contain a few cherry-picked settings, but you can add any internal option here."
echo -e "For reference, see the \e[36m/home/steam/Config/Internal\e[0m counterparts (but don't edit those)."
echo -e "After you change settings, don't forget to run \e[36mkf2.sh config && kf2.sh restart\e[0m."
echo -e "If you change auto-kick bot settings, use \e[36mautokick.sh restart\e[0m."
