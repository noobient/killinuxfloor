#!/bin/sh

set -e

# acquire the kf2 binaries
sudo -u steam sh -c '~/Steam/steamcmd.sh +login anonymous +force_install_dir ./KF2Server +app_update 232130 validate +exit'

# easy access
# we have ini merge and workshop subscription so these are obsolete now
#sudo -u steam sh -c 'ln -s ~/Steam/KF2Server/KFGame/Config ~/Config'
#sudo -u steam sh -c 'ln -s ~/Steam/KF2Server/KFGame/BrewedPC/Maps ~/Maps'
#sudo -u steam sh -c 'ln -s /var/www/public_html ~/RedirectServer'
sudo -u steam sh -c 'ln -s ~/Steam/KF2Server/KFGame/Cache ~/Cache'
sudo -u steam sh -c 'ln -s ~/Steam/KF2Server/Binaries/Win64/steamapps/workshop ~/Workshop'
