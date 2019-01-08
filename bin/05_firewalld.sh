check_firewalld

if [ ${RET} -eq 0 ]
then
    echo -n 'Adding firewall rules... '

    # create a new service
    if [ -f /etc/firewalld/services/kf2.xml ]
    then
        firewall-cmd ${FIREWALLCMD_FLAGS} --remove-service=kf2 --permanent || exit 2
        firewall-cmd ${FIREWALLCMD_FLAGS} --reload || exit 2
        firewall-cmd ${FIREWALLCMD_FLAGS} --delete-service=kf2 --permanent || exit 2
        firewall-cmd ${FIREWALLCMD_FLAGS} --reload || exit 2
    fi

    firewall-cmd ${FIREWALLCMD_FLAGS} --new-service=kf2 --permanent || exit 2

    # deploy it
    cp -f share/kf2.xml /etc/firewalld/services/

    # fix selinux context
    restorecon ${RESTORECON_FLAGS} -r /etc/firewalld/services/

    # allow it
    firewall-cmd ${FIREWALLCMD_FLAGS} --add-service=kf2 --permanent || exit 2

    # reload
    firewall-cmd ${FIREWALLCMD_FLAGS} --reload || exit 2

    ${ECHO_DONE}
else
    echo 'firewalld is not running, skipping firewall rules...'
fi
