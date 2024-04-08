#!/usr/bin/env bash
set -euxo pipefail

UBUNTU_VERSION=20.04
GCC_HASH=f2061b2a9641c2228d4e2d86f19532ad7e93d627
GCC_HASH_SHORT=${GCC_HASH:0:7}
GIT_COMMIT=$(git rev-parse --short HEAD)

touch gcc

tar -cvzf gcc-$GCC_HASH_SHORT-ubuntu$UBUNTU_VERSION-$GIT_COMMIT.tar.gz gcc
