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

function safe_erase ()
{
    RET=1
    yum -q list installed $1 >/dev/null 2>&1 && RET=$?
    if [ ${RET} -eq 0 ]
    then
        yum -y -q erase $1
    fi
}

echo -n 'Stopping KF2 services... '

if [ -f /etc/systemd/system/kf2.service ]
then
    systemctl --quiet stop kf2.service
fi

if [ -f /etc/systemd/system/kf2autokick.service ]
then
    systemctl --quiet stop kf2autokick.service
fi

${ECHO_DONE}

# Helper
echo -n 'Removing helpers... '
rm -rf ${STEAM_HOME}/kf2-centos
rm -rf ${STEAM_HOME}/bin
${ECHO_DONE}

# Autokick
echo -n 'Removing auto-kick bot... '
safe_erase nodejs
safe_erase yarn
rm -f /etc/yum.repos.d/nodesource-el7.repo
rm -f /etc/yum.repos.d/yarn.repo
rm -rf ${STEAM_HOME}/kf2autokick
${ECHO_DONE}

# Config generator
echo -n 'Removing config generator... '
safe_erase crudini
safe_erase epel-release
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

if [ -f /etc/firewalld/services/kf2.xml ]
then
    firewall-cmd --quiet --remove-service=kf2 --permanent
    firewall-cmd --quiet --reload
    firewall-cmd --quiet --delete-service=kf2 --permanent
    firewall-cmd --quiet --reload
fi

${ECHO_DONE}

# Sudo
echo -n 'Removing KF2 service delegation rules... '
rm -f /etc/sudoers.d/kf2-sudo
rm -f /etc/sudoers.d/kf2autokick-sudo
${ECHO_DONE}

# Systemd
echo -n 'Removing KF2 services... '

systemctl --quiet daemon-reload

if [ -f /etc/systemd/system/kf2.service ]
then
    systemctl --quiet disable kf2.service
fi

if [ -f /etc/systemd/system/kf2autokick.service ]
then
    systemctl --quiet disable kf2autokick.service
fi

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

for PKG in glibc.i686 libstdc++.i686 unzip dos2unix patch
do
    safe_erase $PKG
done

${ECHO_DONE}

# the only thing we don't remove is the steam user, because it has user config
#userdel steam

echo -e "\e[32mKilling Floor 2 successfully uninstalled.\e[0m"
