#!/bin/bash

set -eu

read -p $'This will uninstall killinuxfloor from this machine. Press \e[36my\e[0m to continue: ' -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    echo 'Uninstallation cancelled.'
    exit
fi

FEDORA=0
grep 'ID=fedora' /etc/os-release > /dev/null && FEDORA=1 || true
if [ "${FEDORA}" -ne 1 ]
then
    sudo dnf -y -q install epel-release
fi

sudo dnf -y -q install ansible

export ROOT="${BASH_SOURCE%/*}"

sudo ansible-playbook "${ROOT}/uninstall.yml" "$@"

echo -e "\e[32mkillinuxfloor successfully uninstalled.\e[0m"
