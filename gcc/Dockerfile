# Builder image
# https://iamsorush.com/posts/build-gcc11/
ARG UBUNTU_VERSION
FROM ubuntu:${UBUNTU_VERSION}

# Download build dependencies
RUN apt-get update
RUN apt-get install --assume-yes --no-install-recommends \
    build-essential \
    ca-certificates \
    curl \
    flex

# Download GCC and dependencies
ARG GCC_HASH
WORKDIR /opt
RUN curl -L https://github.com/gcc-mirror/gcc/archive/${GCC_HASH}.tar.gz -o ${GCC_HASH}.tar.gz
RUN tar -xvzf ${GCC_HASH}.tar.gz

WORKDIR /opt/gcc-${GCC_HASH}
RUN ./contrib/download_prerequisites

# Build
WORKDIR /opt/gcc-${GCC_HASH}/build
RUN ../configure \
    --verbose \
    --build=x86_64-linux-gnu \
    --host=x86_64-linux-gnu \
    --target=x86_64-linux-gnu \
    --prefix=/opt/gcc/usr \
    --enable-checking=release \
    --enable-languages=c,c++ \
    --disable-multilib
RUN make -j$(nproc)
RUN make install-strip

# Create output tarball
ARG GCC_TARBALL
WORKDIR /opt/gcc
RUN tar -cvzf $GCC_TARBALL usr
