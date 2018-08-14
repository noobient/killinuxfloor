#!/bin/sh

set -e

export STEAM_HOME='/home/steam'

sh bin/01_steamcmd.sh
sh bin/02_kf2.sh
sh bin/03_systemd.sh
sh bin/04_sudo.sh
sh bin/05_firewalld.sh
sh bin/06_config.sh
sh bin/07_autokick.sh
sh bin/08_helper.sh
