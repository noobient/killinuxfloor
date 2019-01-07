#!/bin/sh

set -eu

echo -n 'Installing config generator... '

# install crudini
yum -y -q install epel-release | grep -v "already installed and latest version" || true
rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-7
yum -y -q install crudini | grep -v "already installed and latest version" || true

${ECHO_DONE}

if [ -d ${STEAM_HOME}/Config ]
then
    # Backup
    DATE_STR=$(date +%Y%m%d-%H%M%S)
    BACKUP_FILE="${STEAM_HOME}/Config-${DATE_STR}.tgz"
    echo -n "Backing up current KF2 config as ${BACKUP_FILE}... "
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
restorecon -r ${STEAM_HOME}/Config

# easy access to stock config files
sudo -u steam sh -c 'ln -sfn ~/Steam/KF2Server/KFGame/Config ~/Config/Internal'

# suppress warnings during init
systemctl --quiet daemon-reload

${ECHO_DONE}
