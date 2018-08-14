#!/bin/sh

set -e

# deploy the sudo role
cp share/kf2-sudo /etc/sudoers.d/
cp share/kf2autokick-sudo /etc/sudoers.d/

# fix selinux context
restorecon -rv /etc/sudoers.d

# fix file permissions
chmod 0440 /etc/sudoers.d/kf2-sudo
chmod 0440 /etc/sudoers.d/kf2autokick-sudo
