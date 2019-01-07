#!/bin/sh

set -eu

export STEAM_HOME='/home/steam'
export ECHO_DONE='echo -e \e[32mdone\e[0m.'

read -p "This will uninstall Killing Floor 2 on this machine. Press 'y' to continue: " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    echo 'Uninstallation cancelled.'
    exit
fi

echo 'Uninstalling Killing Floor 2... '

# Essentially, this file should be bin/* undone, in reverse order.

echo -n 'Stopping KF2 services... '
systemctl --quiet stop kf2.service
systemctl --quiet stop kf2autokick.service
${ECHO_DONE}

# Helper
echo -n 'Removing helpers... '
rm -rf ${STEAM_HOME}/kf2-centos
rm -rf ${STEAM_HOME}/bin
${ECHO_DONE}

# Autokick
echo -n 'Removing auto-kick bot... '
yum -y -q erase nodejs yarn
rm -f /etc/yum.repos.d/nodesource-el7.repo
rm -f /etc/yum.repos.d/yarn.repo
rm -rf ${STEAM_HOME}/kf2autokick
${ECHO_DONE}

# Config generator
echo -n 'Removing config generator... '
yum -y -q erase crudini epel-release
${ECHO_DONE}

# Backup
DATE_STR=$(date +%Y%m%d-%H%M%S)
BACKUP_FILE="${STEAM_HOME}/Config-${DATE_STR}.tgz"
echo -n "Backing up current KF2 config as ${BACKUP_FILE}... "
rm -f ${STEAM_HOME}/Config/Internal
sudo -u steam sh -c "tar czfh ${BACKUP_FILE} -C ${STEAM_HOME} Config"
${ECHO_DONE}

# Firewall
echo -n 'Removing firewall rules... '
firewall-cmd --quiet --remove-service=kf2 --permanent
firewall-cmd --quiet --reload
firewall-cmd --quiet --delete-service=kf2 --permanent
firewall-cmd --quiet --reload
${ECHO_DONE}

# Sudo
echo -n 'Removing KF2 service delegation rules... '
rm -f /etc/sudoers.d/kf2-sudo
rm -f /etc/sudoers.d/kf2autokick-sudo
${ECHO_DONE}

# Systemd
echo -n 'Removing KF2 services... '
systemctl --quiet disable kf2.service
systemctl --quiet disable kf2autokick.service
rm -f /etc/systemd/system/kf2.service
rm -f /etc/systemd/system/kf2autokick.service
rm -rf /etc/systemd/system/kf2.service.d
systemctl --quiet daemon-reload
${ECHO_DONE}

# Steam + KF2
echo -n 'Removing KF2 and Steam... '
rm -rf ${STEAM_HOME}/Steam
rm -rf ${STEAM_HOME}/.steam
rm -f ${STEAM_HOME}/Cache
rm -f ${STEAM_HOME}/Workshop
${ECHO_DONE}

# Deps
echo -n 'Removing dependencies... '
yum -y -q erase glibc.i686 libstdc++.i686 unzip dos2unix patch
${ECHO_DONE}

# the only thing we don't remove is the steam user, because it has user config
#userdel steam

echo -e "\e[32mKilling Floor 2 successfully uninstalled.\e[0m"
