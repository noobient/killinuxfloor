echo 'Installing Killing Floor 2... '

# acquire the kf2 binaries
if [ ${SKIP_KFGAME} -ne 1 ]
then
    sudo -u steam sh -c '~/Steam/steamcmd.sh +login anonymous +force_install_dir ./KF2Server +app_update 232130 validate +exit || exit 1'
fi

echo 'Killing Floor 2 installer exited.'

echo -n 'Checking Killing Floor 2 install state... '
export STATE_LOG="${STEAM_HOME}/Steam/logs/state.log"
sudo -u steam sh -c "~/Steam/steamcmd.sh +login anonymous +force_install_dir ./KF2Server +app_status 232130 +exit > ${STATE_LOG}"
sudo -u steam sh -c "grep -i 'install state:' ${STATE_LOG} | grep -i 'fully installed' > /dev/null || exit 1"

# easy access
sudo -u steam sh -c 'ln -sfn ~/Steam/KF2Server/KFGame/Cache ~/Cache'
sudo -u steam sh -c 'ln -sfn ~/Steam/KF2Server/Binaries/Win64/steamapps/workshop ~/Workshop'

${ECHO_DONE}
