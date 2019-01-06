#!/bin/sh

set -Eeu

function errorexit ()
{
    case $? in
        1)
            echo 'error! Killing Floor 2 failed to install.'
            echo 'Observe the SteamCMD output and check the files under /home/steam/Steam/logs.'
            echo 'Once you eliminated the problem, try running the installer again.'
            ;;

    esac
}

trap errorexit EXIT

echo 'Installing Killing Floor 2... '

# acquire the kf2 binaries
sudo -u steam sh -c '~/Steam/steamcmd.sh +login anonymous +force_install_dir ./KF2Server +app_update 232130 validate +exit'
echo 'Killing Floor 2 installer exited.'

echo -n 'Checking Killing Floor 2 install state... '
export STATE_LOG="${STEAM_HOME}/Steam/logs/state.log"
sudo -u steam sh -c "~/Steam/steamcmd.sh +login anonymous +force_install_dir ./KF2Server +app_status 232130 +exit > ${STATE_LOG}"
sudo -u steam sh -c "grep -i 'install state:' ${STATE_LOG} | grep -i 'fully installed' > /dev/null || exit 1"

# easy access
sudo -u steam sh -c 'ln -sfn ~/Steam/KF2Server/KFGame/Cache ~/Cache'
sudo -u steam sh -c 'ln -sfn ~/Steam/KF2Server/Binaries/Win64/steamapps/workshop ~/Workshop'

echo 'done.'
