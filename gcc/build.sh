#!/usr/bin/env bash
set -euxo pipefail

UBUNTU_VERSION=22.04
GCC_HASH=f4f7c52472fa59993024e70848559d8bac2167ba

GIT_HASH=$(git rev-parse --short HEAD)
GCC_TARBALL=gcc-${GCC_HASH:0:7}-ubuntu${UBUNTU_VERSION}-${GIT_HASH}.tar.gz

THIS_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

# Build GCC inside docker image
docker build \
    --build-arg UBUNTU_VERSION=${UBUNTU_VERSION} \
    --build-arg GCC_HASH=${GCC_HASH} \
    --build-arg GCC_TARBALL=${GCC_TARBALL} \
    --tag gcc:latest \
    ${THIS_DIR}

# Take GCC tarball out of image
docker create --name tmp gcc:latest
docker cp tmp:/opt/gcc/$GCC_TARBALL .
docker rm tmp
