function kf2_yum_install ()
{
    if [ ${KF2_DEBUG} -eq 1 ]
    then
        yum install "$@"
    else
        yum --assumeyes --quiet install "$@" | grep -v "already installed and latest version" || true
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
                yum erase $PKG
            else
                yum --assumeyes --quiet erase $PKG
            fi
        fi
    done
}

function errorexit ()
{
    case $? in
        0)
            ;;

        1)
            echo -e "\e[31merror! Killing Floor 2 failed to install.\e[0m"
            echo 'Observe the SteamCMD output and check the files under /home/steam/Steam/logs.'
            echo 'Once you eliminated the problem, try running the installer again.'
            ;;

        2)
            echo -e "\e[31merror! Is firewalld running?\e[0m"
            echo -e "You can check with \e[36msystemctl status firewalld.service\e[0m."
            ;;

        *)
            echo -e "\e[31merror!\e[0m"
            ;;

    esac
}

trap errorexit EXIT
