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
