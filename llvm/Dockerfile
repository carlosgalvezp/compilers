ARG UBUNTU_VERSION
FROM ubuntu:${UBUNTU_VERSION}

# Download build dependencies
RUN apt-get update
RUN export DEBIAN_FRONTEND="noninteractive" && \
    apt-get install --assume-yes --no-install-recommends \
    build-essential \
    ca-certificates \
    cmake \
    curl \
    ninja-build \
    python3

# Download LLVM
WORKDIR /opt
RUN curl -L https://github.com/llvm/llvm-project/archive/${LLVM_HASH}.tar.gz -o ${LLVM_HASH}.tar.gz
RUN tar -xvzf ${LLVM_HASH}.tar.gz

# Build
WORKDIR /opt/llvm-project-${LLVM_HASH}/build
RUN cmake \
    -G Ninja \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/opt/llvm/usr \
    -DLLVM_ENABLE_PROJECTS="clang;clang-tools-extra" \
    -DLLVM_USE_LINKER=lld \
    -DLLVM_LINK_LLVM_DYLIB=ON \
    -DCLANG_LINK_CLANG_DYLIB=ON \
    ../llvm
RUN ninja -j$(nproc)
RUN ninja install

# # Create output tarball
ARG LLVM_TARBALL
WORKDIR /opt/llvm
RUN tar -cvzf $LLVM_TARBALL usr
