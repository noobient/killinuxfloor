echo -n 'Installing config generator... '

# install crudini
kf2_yum_install epel-release
rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-7
kf2_yum_install crudini

${ECHO_DONE}

if [ -d ${STEAM_HOME}/Config ]
then
    # Backup
    DATE_STR=$(date +%Y%m%d-%H%M%S)
    BACKUP_FILE="${STEAM_HOME}/Config-${DATE_STR}.tgz"
    echo -ne "Backing up current KF2 config as \e[36m${BACKUP_FILE}\e[0m... "
    rm -f ${STEAM_HOME}/Config/Internal
    sudo -u steam sh -c "tar czfh ${BACKUP_FILE} -C ${STEAM_HOME} Config"
    ${ECHO_DONE}

    rm -rf ${STEAM_HOME}/Config
fi

echo -n 'Installing initial configuration... '

# deploy the initial config
cp -R -f share/Config ${STEAM_HOME}/

# fix ownership
chown -R steam.steam ${STEAM_HOME}/Config

# fix selinux context
restorecon ${RESTORECON_FLAGS} -r ${STEAM_HOME}/Config

# easy access to stock config files
sudo -u steam sh -c 'ln -sfn ~/Steam/KF2Server/KFGame/Config ~/Config/Internal'

# suppress warnings during init
systemctl ${SYSTEMCTL_FLAGS} daemon-reload

${ECHO_DONE}
