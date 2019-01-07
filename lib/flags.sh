if [ ${KF2_DEBUG} -eq 1 ]
then
    export CURL_FLAGS=''
    export FIREWALLCMD_FLAGS=''
    export GIT_FLAGS=''
    export RESTORECON_FLAGS='-v'
    export SYSTEMCTL_FLAGS=''
else
    export CURL_FLAGS='--silent'
    export FIREWALLCMD_FLAGS='--quiet'
    export GIT_FLAGS='--quiet'
    export RESTORECON_FLAGS=''
    export SYSTEMCTL_FLAGS='--quiet'
fi
