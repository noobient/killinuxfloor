function kf2_yum_install ()
{
    # yum install accepts multiple install executions for repo packages, but not for URLs
    # have to check if URL install is already applied
    URL_PKG=0
    NOT_INSTALLED=1

    if [[ "$@" == "https://"* ]]
    then
        URL_PKG=1
        # package name = string after last '/', then string before first '.'
        PKG=$(awk -F/ '{print $NF}' <<< "$@" | awk -F. '{print $1}')
        yum --quiet list installed $PKG >/dev/null 2>&1 && NOT_INSTALLED=$?
    fi

    # allow re-install for repo packages, there might be an update
    if [ ${NOT_INSTALLED} -eq 1 ] || [ ${URL_PKG} -eq 0 ]
    then
        if [ ${KF2_DEBUG} -eq 1 ]
        then
            yum install "$@" || exit 3
        else
            yum --assumeyes --quiet install "$@" >/dev/null || exit 3
        fi
    fi
}

function kf2_yum_erase ()
{
    for PKG in "$@"
    do
        RET=1
        yum --quiet list installed $PKG >/dev/null 2>&1 && RET=$?

        if [ ${RET} -eq 0 ]
        then
            if [ ${KF2_DEBUG} -eq 1  ]
            then
                yum erase $PKG || exit 3
            else
                yum --assumeyes --quiet erase $PKG || exit 3
            fi
        fi
    done
}

function check_firewalld ()
{
    # check if firewalld is running
    RET=1
    systemctl is-active --quiet firewalld.service && RET=0 || true
}

function check_centos ()
{
    RET=1
    if [[ $(cat /etc/centos-release) == "CentOS Linux release 7.6"* ]]
    then
        RET=0
    fi
}

function errorexit ()
{
    case $? in
        0)
            ;;

        1)
            echo -e "\e[31merror! Killing Floor 2 failed to install.\e[0m"
            echo -e "Observe the SteamCMD output and check the files under \e[36m/home/steam/Steam/logs\e[0m."
            echo 'Once you eliminated the problem, try running the installer again.'
            ;;

        2)
            echo -e "\e[31merror! Is firewalld running?\e[0m"
            echo -e "You can check with \e[36msystemctl status firewalld.service\e[0m."
            ;;

        3)
            echo -e "\e[31merror! Is yum operable?\e[0m"
            ;;

        4)
            echo -e "\e[31merror! Your CentOS is too old.\e[0m"
            echo -e "Update with \e[36myum update\e[0m, then reboot."
            ;;

        *)
            echo -e "\e[31merror!\e[0m"
            ;;

    esac
}

trap errorexit EXIT
