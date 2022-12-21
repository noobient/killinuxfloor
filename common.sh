function check_os ()
{
    apt --version &> /dev/null && export PKG_MGR='apt' || export PKG_MGR='dnf'
}

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
            "${PKG_MGR}" -y -q install sudo > /dev/null
        fi
    fi
}

function check_epel ()
{
    FEDORA=0
    grep 'ID=fedora' /etc/os-release > /dev/null && FEDORA=1 || true

    if [ "${FEDORA}" -ne 1 ] && [ "${PKG_MGR}" != 'apt' ]
    then
        sudo "${PKG_MGR}" -y -q install epel-release > /dev/null
    fi
}

function install_ansible ()
{
    if [ "${PKG_MGR}" == 'apt' ]
    then
        sudo "${PKG_MGR}" -y -q install software-properties-common > /dev/null
        sudo add-apt-repository -y ppa:ansible/ansible > /dev/null
    fi

    sudo "${PKG_MGR}" -y -q install ansible > /dev/null
    ansible-galaxy install --force -r requirements.yml
}

function find_ip ()
{
    export IP_ADDR=$(ip -4 a s | grep inet | grep -v '127\.0\.0' | awk '{print $2}' | cut -d'/' -f1)
}

function init_klf ()
{
    check_os
    check_sudo
    check_epel
    install_ansible
    find_ip
}
