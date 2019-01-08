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

source "${ROOT}/lib/globals.sh"
source "${ROOT}/lib/aliases.sh"
source "${ROOT}/lib/flags.sh"
source "${ROOT}/lib/functions.sh"

source "${ROOT}/bin/01_steamcmd.sh"
source "${ROOT}/bin/02_kf2.sh"
source "${ROOT}/bin/03_systemd.sh"
source "${ROOT}/bin/04_sudo.sh"
source "${ROOT}/bin/05_firewalld.sh"
source "${ROOT}/bin/06_config.sh"
source "${ROOT}/bin/07_autokick.sh"
source "${ROOT}/bin/08_helper.sh"
source "${ROOT}/bin/09_init.sh"
source "${ROOT}/bin/10_welcome.sh"
