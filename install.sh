#!/bin/bash

set -eu

read -p $'This will install killinuxfloor on this machine. Press \e[36my\e[0m to continue: ' -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    echo 'Installation cancelled.'
    exit
fi

export ROOT="${BASH_SOURCE%/*}"
source "${ROOT}/common.sh"

init_klf

if [ $# -ge 1 ] && [ $1 == '--classic' ]
then
    shift
    sudo ansible-playbook "${ROOT}/install.yml" --extra-vars "kf2_classic=True" "$@"
else
    sudo ansible-playbook "${ROOT}/install.yml" "$@"
fi

echo -e "\e[32mkillinuxfloor successfully installed!\e[0m"
echo
echo -e "You may now manage your KF2 server with the \e[36msteam\e[0m user."
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
echo
echo -e "\e[36mkillinuxfloor\e[35m Command Reference:\e[0m run \e[36mkillinuxfloor help\e[0m."
echo -e "\e[35mKF2 Options Reference:\e[0m see the \e[36m/home/steam/Config/Internal\e[0m counterparts (but don't edit those)."
echo -e "\e[35mApplying KF2 Changes:\e[0m edit the \e[36mMy-*\e[0m files, then run \e[36mkillinuxfloor apply\e[0m."
echo -e "\e[35mApplying Auto-Kick Changes:\e[0m edit \e[36mautokick.json\e[0m, then run \e[36mkillinuxfloor autokick restart\e[0m."
echo -e "\e[35mWebadmin Access:\e[0m set \e[36mAdminPassword\e[0m in \e[33mMy-LinuxServer-KFGame.ini\e[0m, then \e[36mkillinuxfloor apply\e[0m."
