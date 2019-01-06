#!/bin/sh

set -eu

echo -n 'Adding firewall rules... '

# create a new service
if [ -f /etc/firewalld/services/kf2.xml ]
then
    firewall-cmd --quiet --remove-service=kf2 --permanent
    firewall-cmd --quiet --reload
    firewall-cmd --quiet --delete-service=kf2 --permanent
    firewall-cmd --quiet --reload
fi

firewall-cmd --quiet --new-service=kf2 --permanent

# deploy it
cp -f share/kf2.xml /etc/firewalld/services/

# fix selinux context
restorecon -r /etc/firewalld/services/

# allow it
firewall-cmd --quiet --add-service=kf2 --permanent

# reload
firewall-cmd --quiet --reload

echo 'done.'
