#!/usr/bin/env bash
set -euxo pipefail

UBUNTU_VERSION=20.04
GCC_HASH=4f3b1a09d3109f03299a2ac15cfa3059596fcb1d

THIS_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

docker build \
    --build-arg UBUNTU_VERSION=${UBUNTU_VERSION} \
    --build-arg GCC_HASH=${GCC_HASH} \
    --target=gcc \
    --tag carlosgalvezp/gcc:ubuntu${UBUNTU_VERSION}_${GCC_HASH} \
    ${THIS_DIR}

docker builder prune --all --force
