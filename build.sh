#!/bin/bash
set -e

DIR="$(dirname $(readlink -f $0))"

# init poky env
cd "${DIR}"/poky
. oe-init-build-env

# export variables
export LAYERS_DIR="${DIR}"
export BB_ENV_EXTRAWHITE="LAYERS_DIR"

# create custom bblayers.conf
rm -f conf/bblayers.conf
cp -f "${DIR}"/templates/bblayers.conf.template conf/bblayers.conf
 
# create custom local.conf
rm -f conf/local.conf
cp -f "${DIR}"/templates/local.conf.template conf/local.conf

# bitbake image
bitbake -k core-image-sato