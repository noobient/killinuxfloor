#!/bin/bash

set -eu

function check_container ()
{
    "${exec}" exec -it "${CONT_ID}" bash
}

trap 'check_container' ERR

function find_exec ()
{
    RET=0
    podman --version &> /dev/null && RET=1 || true

    if [ ${RET} -eq 1 ]
    then
        echo 'podman'
    else
        RET=0
        docker --version &> /dev/null && RET=1 || true

        if [ ${RET} -eq 1 ]
        then
            echo 'docker'
        else
            echo ''
        fi
    fi
}

export exec=$(find_exec)

if [ -z "${exec}" ]
then
    echo -e "\e[31mError! Container executable not found. Ensure Podman (preferred) or Docker is installed and running.\e[0m"
    exit 1
fi

if [ $# -lt 1 ]
then
    platform="fedora:41"
else
    platform="${1}"
fi

echo -e "\nRunning tests on:\n - Platform: \e[36m${platform}\e[0m\n"

# Fire up instance
CONT_ID=$(${exec} run --rm -v $(pwd):/repo -v /sys/fs/cgroup:/sys/fs/cgroup:ro --tmpfs /tmp --tmpfs /run --privileged --detach "bviktor/ansible-systemd-${platform}")
# Determine package manager
export PKG_MGR=$(${exec} exec ${CONT_ID} /bin/bash -c "apt --version &> /dev/null && echo 'apt' || echo 'dnf'")
# Run the tests
"${exec}" exec ${CONT_ID} /bin/bash -c "./install.sh --extra-vars 'skip_kfgame=true' <<< y"
"${exec}" exec ${CONT_ID} /bin/bash -c "DEBIAN_FRONTEND=noninteractive ${PKG_MGR} -y -q install firewalld > /dev/null && systemctl start firewalld.service"
"${exec}" exec ${CONT_ID} /bin/bash -c "./uninstall.sh <<< y"
"${exec}" exec ${CONT_ID} /bin/bash -c "./install.sh --extra-vars 'skip_kfgame=true kf2_classic=true' <<< y"
# Let us check stuff before exiting
check_container
# Stop instance
"${exec}" stop "${CONT_ID}"
