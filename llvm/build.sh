#!/usr/bin/env bash
set -euxo pipefail

UBUNTU_VERSION=24.04
LLVM_HASH=377755c87e9d5494237f0e2e88f70886b5107342

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
