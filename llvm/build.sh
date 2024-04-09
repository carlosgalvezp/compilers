#!/usr/bin/env bash
set -euxo pipefail

UBUNTU_VERSION=22.04
LLVM_HASH=ca705681dff4d7b28fad84b8e6846e0463a8860d

DATE=$(date +%Y%m%d%H%M%S)
LLVM_TARBALL=llvm-${DATE}-ubuntu${UBUNTU_VERSION}-${LLVM_HASH:0:7}.tar.gz

THIS_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

# Build LLVM inside docker image
docker build \
    --build-arg UBUNTU_VERSION=${UBUNTU_VERSION} \
    --build-arg LLVM_HASH=${LLVM_HASH} \
    --build-arg LLVM_TARBALL=${LLVM_TARBALL} \
    --tag llvm:latest \
    ${THIS_DIR}


# Take LLVM tarball out of image
docker create --name tmp llvm:latest
docker cp tmp:/opt/llvm/$LLVM_TARBALL .
docker rm tmp
