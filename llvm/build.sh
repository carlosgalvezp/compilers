#!/usr/bin/env bash
set -euxo pipefail

UBUNTU_VERSION=20.04
LLVM_HASH=104a827ea6de0cbe0f5faef4407552ede31d165c

THIS_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

docker build \
    --build-arg UBUNTU_VERSION=${UBUNTU_VERSION} \
    --build-arg LLVM_HASH=${LLVM_HASH} \
    --target=llvm \
    --tag carlosgalvezp/llvm:ubuntu${UBUNTU_VERSION}_${LLVM_HASH} \
    ${THIS_DIR}
