echo -n 'Installing helpers... '

# create the dir
sudo -u steam sh -c 'mkdir -p ~/bin'

if [ -d ${STEAM_HOME}/killinuxfloor ]
then
    # update
    sudo -u steam sh -c "cd ~/killinuxfloor && git reset ${GIT_FLAGS} --hard && git pull ${GIT_FLAGS}"
else
    # make a local copy of killinuxfloor for easier updates
    sudo -u steam sh -c "cd && git clone ${GIT_FLAGS} https://github.com/bviktor/killinuxfloor.git"
fi

# deploy the helpers
ln -sTf ${STEAM_HOME}/killinuxfloor/share/killinuxfloor ${STEAM_HOME}/bin/killinuxfloor
ln -sTf ${STEAM_HOME}/bin/killinuxfloor ${STEAM_HOME}/bin/klf

# fix ownership
chown -R steam.steam ${STEAM_HOME}/bin

# fix selinux context
restorecon ${RESTORECON_FLAGS} -r ${STEAM_HOME}/bin

${ECHO_DONE}
