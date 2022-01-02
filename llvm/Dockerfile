# Builder image
ARG UBUNTU_VERSION
FROM ubuntu:${UBUNTU_VERSION} as builder

ARG LLVM_HASH

RUN apt-get update
RUN export DEBIAN_FRONTEND="noninteractive" && \
    apt-get install --assume-yes --no-install-recommends \
    build-essential \
    ca-certificates \
    cmake \
    curl \
    ninja-build \
    python3

WORKDIR /opt
RUN curl -L https://github.com/llvm/llvm-project/archive/${LLVM_HASH}.tar.gz -o ${LLVM_HASH}.tar.gz
RUN tar -xvzf ${LLVM_HASH}.tar.gz

WORKDIR /opt/llvm-project-${LLVM_HASH}/build
RUN cmake \
    -G Ninja \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/opt/llvm \
    -DLLVM_ENABLE_PROJECTS="clang;clang-tools-extra" \
    -DLLVM_USE_LINKER=gold \
    -DLLVM_LINK_LLVM_DYLIB=ON \
    -DCLANG_LINK_CLANG_DYLIB=ON \
    ../llvm
RUN ninja -j$(nproc)
RUN ninja install

# Final image
FROM ubuntu:${UBUNTU_VERSION} as llvm
COPY --from=builder /opt/llvm /opt/llvm
