echo -n 'Installing auto-kick bot... '

# install the repos
rpm --import /etc/pki/rpm-gpg/NODESOURCE-GPG-SIGNING-KEY-EL
rpm --import https://dl.yarnpkg.com/rpm/pubkey.gpg
curl ${CURL_FLAGS} --location https://rpm.nodesource.com/setup_8.x | bash - >/dev/null
curl ${CURL_FLAGS} --location https://dl.yarnpkg.com/rpm/yarn.repo > /etc/yum.repos.d/yarn.repo

# install the packages
kf2_yum_install nodejs yarn

if [ -d ${STEAM_HOME}/kf2autokick ]
then
    sudo -u steam sh -c "cd ~/kf2autokick && git reset ${GIT_FLAGS} --hard && git pull ${GIT_FLAGS}"
else
    # obtain a copy of kf2_autokick
    # wonderful workaround for "could not change back" bullcrap by git
    sudo -u steam sh -c "cd && git clone ${GIT_FLAGS} https://github.com/Sinewyk/kf2_autokick.git kf2autokick"
fi

# 'build' it
sudo -u steam sh -c "cd ${STEAM_HOME}/kf2autokick && yarn --silent --frozen-lockfile >/dev/null 2>&1"

${ECHO_DONE}
