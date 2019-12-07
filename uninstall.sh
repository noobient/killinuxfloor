#!/bin/bash

set -eu

read -p $'This will uninstall killinuxfloor from this machine. Press \e[36my\e[0m to continue: ' -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    echo 'Uninstallation cancelled.'
    exit
fi

sudo yum -y -q install epel-release
sudo yum -y -q install ansible

export ROOT="${BASH_SOURCE%/*}"

sudo ansible-playbook "${ROOT}/uninstall.yml"

echo -e "\e[32mkillinuxfloor successfully uninstalled.\e[0m"
