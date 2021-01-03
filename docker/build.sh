#!/bin/bash

set -eu

. package.conf

mkdir -p pkg

docker build --network=host --tag "pkgdocker.${PKG_NAME}:${PKG_VER}" .
docker run --network=host --rm --mount type=bind,source="$(pwd)"/pkg,target=/pkg "pkgdocker.${PKG_NAME}:${PKG_VER}"
