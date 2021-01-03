#!/bin/bash

set -eu

export ROOT_DIR='/home/pkgdocker'
export BALANCE_DIR='/home/steam/Steam/KF2Server/Binaries/Win64'

. "${ROOT_DIR}/package.conf"

# set compression level
sed -i "s/w[0-9]T.xzdio/w9T.xzdio/" /usr/local/rvm/gems/ruby-$(ruby --version | cut -d' ' -f2 | cut -d'p' -f1)/gems/fpm-$(fpm --version)/lib/fpm/package/rpm.rb

mkdir -p "${BALANCE_DIR}"
cp /pkg/balance_tweaks.bin "${BALANCE_DIR}"
chmod 0644 "${BALANCE_DIR}/balance_tweaks.bin"
chown root:root "${BALANCE_DIR}/balance_tweaks.bin"

# build package
time fpm --input-type=dir --output-type=rpm --rpm-compression=xzmt --name="${PKG_NAME}-${PKG_VER}" --package="/pkg" "${BALANCE_DIR}"
