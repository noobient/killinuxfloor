function check_sudo ()
{
    CAN_SUDO=0
    sudo --version > /dev/null 2>&1 && CAN_SUDO=1

    if [ ${CAN_SUDO} -ne 1 ]
    then
        RUNNER=$(id --user)
        if [ ${RUNNER} -ne 0 ]
        then
            echo "Error! You are not root and sudo is unavailable!"
            exit 1
        else
            dnf -y -q install sudo
        fi
    fi
}

function check_epel ()
{
    FEDORA=0
    grep 'ID=fedora' /etc/os-release > /dev/null && FEDORA=1 || true
    if [ "${FEDORA}" -ne 1 ]
    then
        sudo dnf -y -q install epel-release
    fi
}

function install_ansible ()
{
    sudo dnf -y -q install ansible
}

function init_klf ()
{
    check_sudo
    check_epel
    install_ansible
}
