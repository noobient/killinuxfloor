#!/bin/bash

set -u

if [ $# -lt 1 ]
then
    platform="fedora:37"
else
    platform="${1}"
fi

echo -e "\nRunning tests on:\n - Platform: \e[36m${platform}\e[0m\n"

# Fire up instance
CONT_ID=$(docker run --rm -v $(pwd):/repo -v /sys/fs/cgroup:/sys/fs/cgroup:ro --tmpfs /tmp --tmpfs /run --privileged --detach "bviktor/ansible-systemd-${platform}")
# Determine package manager
export PKG_MGR=$(docker exec ${CONT_ID} /bin/bash -c "apt --version &> /dev/null && echo 'apt' || echo 'dnf'")
# Run the tests
docker exec ${CONT_ID} /bin/bash -c "DEBIAN_FRONTEND=noninteractive ${PKG_MGR} -y -q install firewalld > /dev/null && systemctl start firewalld.service"
docker exec ${CONT_ID} /bin/bash -c "./install.sh --extra-vars 'skip_kfgame=true' <<< y"
docker exec ${CONT_ID} /bin/bash -c "./uninstall.sh <<< y"
docker exec ${CONT_ID} /bin/bash -c "./install.sh --extra-vars 'skip_kfgame=true kf2_classic=true' <<< y"
# Let us check stuff before exiting
docker exec -it "${CONT_ID}" bash
# Stop instance
docker stop "${CONT_ID}"
