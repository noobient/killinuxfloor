## killinuxfloor 3.0 (2023-03-07)

* Add DDoS protection
* Add optional DDoS stats via `klf ddos` command
* Add many details to `klf workshop` report
* Add Unofficial Killing Floor 2 Patch
* Add `update.sh` script to update killinuxfloor installation
* Fix Steam Workshop downloads
* Fix KF2 restart loop when startup includes workshop items not downloaded yet
* Fix various issues when installing in a container
* Fix missing workshop items when trailing newline is missing in config files
* Fix various commands overriding symlinks in config
* Fix SELinux deny actions on startup config
* Fix Ansible Galaxy dependencies being downloaded twice during install

## killinuxfloor 2.0 (2022-12-22)

* Add option to install KF2 in Classic mode (Infinite Onslaught update)
* Add AlmaLinux, Fedora, Ubuntu support
* Add watchdog support via `killinuxfloor watchdog`
* Add GeoIP and Steam profile links in webadmin player list
* Add `killinuxfloor apply` command
* Port installer and uninstaller to Ansible
* Update Node.js to 18
* Update .NET to 6
* Remove CentOS support

## killinuxfloor 1.1 (2019-05-15)

* Add support for bans via `killinuxfloor ban` command
* Fix failing Workshop downloads caused by old Steam libraries shipped with KF2
* Fix failing `killinuxfloor status` when KF2 isn't running
* Fix webadmin erroneously allowing changes to automatically generated map cycles

## killinuxfloor 1.0 (2019-01-11)

* Initial release
