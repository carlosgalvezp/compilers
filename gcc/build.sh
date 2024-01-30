#!/usr/bin/env bash
set -euxo pipefail

UBUNTU_VERSION=20.04
GCC_HASH=f2061b2a9641c2228d4e2d86f19532ad7e93d627

THIS_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

docker build \
    --build-arg UBUNTU_VERSION=${UBUNTU_VERSION} \
    --build-arg GCC_HASH=${GCC_HASH} \
    --target=gcc \
    --tag carlosgalvezp/gcc:ubuntu${UBUNTU_VERSION}_${GCC_HASH} \
    ${THIS_DIR}
