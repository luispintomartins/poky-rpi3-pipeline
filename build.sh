#!/bin/bash

LAYERS_DIR="$(dirname $0)"

export LAYERS_DIR="${DIR}"

# init poky env
cd "${DIR}"/poky
. oe-init-build-env

# create custom bblayers.conf
rm -f conf/bblayers.conf
cp -f "${DIR}"/templates/bblayers.conf.template conf/bblayers.conf
 
# create custom local.conf
rm -f conf/local.conf
cp -f "${DIR}"/templates/local.conf.template conf/local.conf

# bitbake image
bitbake core-image-sato