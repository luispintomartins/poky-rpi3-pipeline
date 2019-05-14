#!/bin/bash

LAYERS_DIR="$(dirname $0)"

# init poky env
cd "${LAYERS_DIR}"/poky
. oe-init-build-env

# create custom bblayers.conf
rm -f conf/bblayers.conf
for x in \
    "${LAYERS_DIR}"/poky/meta \
    "${LAYERS_DIR}"/poky/meta-poky \
    "${LAYERS_DIR}"/meta-openembedded/meta-oe \
    "${LAYERS_DIR}"/meta-openembedded/meta-multimedia \
    "${LAYERS_DIR}"/meta-openembedded/meta-networking \
    "${LAYERS_DIR}"/meta-openembedded/meta-python \
    "${LAYERS_DIR}"/meta-openembedded/meta-filesystems \
    "${LAYERS_DIR}"/meta-raspberrypi \
    "${LAYERS_DIR}"/meta-webosose/meta-webos \
    "${LAYERS_DIR}"/meta-webosose/meta-webos-backports \
    "${LAYERS_DIR}"/meta-webosose/meta-webos-raspberrypi \
    "${LAYERS_DIR}"/meta-webosose/meta-webos-ros2
do
    echo 'BBLAYERS += "'$x'"' >> conf/bblayers.conf
done
 
# create custom local.conf
rm -f conf/local.conf
cat >> conf/local.conf <<'EOF'
# machine options
MACHINE = "raspberrypi"
IMAGE_ROOTFS_EXTRA_SPACE = "524288"

# distro options
PACKAGE_CLASSES ?= "package_deb"
EXTRA_IMAGE_FEATURES ?= "debug-tweaks x11-base ssh-server-openssh"

# sstate mirrors for sumo
SSTATE_MIRRORS = "file://.* http://sstate.yoctoproject.org/2.5/PATH;downloadfilename=PATH \n"

# power building
BB_NUMBER_THREADS = "32"
PARALLEL_MAKE = "-j16"
EOF

# bitbake image
bitbake core-image-sato