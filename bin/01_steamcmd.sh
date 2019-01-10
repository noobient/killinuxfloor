# Steam user
if [ $(id -u steam 2>/dev/null || echo -1) -eq -1 ]
then
    echo -n 'Creating dedicated steam user... '
    useradd --user-group --create-home steam
    ${ECHO_DONE}
fi

# Deps
echo -n 'Installing dependencies... '
yum clean all # we can never be sure, force empty cache
kf2_yum_install glibc.i686 libstdc++.i686 unzip dos2unix patch git
${ECHO_DONE}

# SteamCMD
echo -n 'Installing Steam... '

# create the main steam dir
sudo -u steam sh -c 'mkdir -p ~/Steam'

# obtain steamcmd, tar overwrites by default
sudo -u steam sh -c 'curl -sqL "https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz" | tar -C ~/Steam -zxf -'

# check if Steam is in PATH, yeah, it's ugly
if [ $(sudo -u steam sh -c ". ~/.bash_profile; env | grep ^PATH | tr -s ':' '\n' | grep Steam || echo -1") = -1 ]
then
    # add to PATH if needed
    sudo -u steam sh -c 'sed -i.orig '"'"'/^PATH=/ s@$@:$HOME/Steam@'"'"' ~/.bash_profile'
fi

${ECHO_DONE}
