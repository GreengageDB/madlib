#!/bin/bash -l

set -exo pipefail

case "$MADLIB_PORT" in
    postgres)
        export DEBIAN_FRONTEND=noninteractive
        groupadd --system --gid 999 postgres
        useradd --system --uid 999 --home /var/lib/postgresql --shell /bin/bash --gid postgres postgres
        install -d -m 0755 -o postgres -g postgres /var/lib/postgresql
        install -d -m 0700 -o postgres -g postgres /var/lib/postgresql/data
        apt-get update
        apt-get install -y \
            bison \
            clang \
            cmake \
            curl \
            flex \
            g++ \
            gcc \
            git-core \
            libbz2-dev \
            libgss-dev \
            libkrb5-dev \
            libldap-common \
            libldap-dev \
            liblz4-dev \
            libpam-dev \
            libperl-dev \
            libreadline-dev \
            libssl-dev \
            libxml2-dev \
            libxslt-dev \
            libyaml-dev \
            libzstd-dev \
            llvm \
            locales \
            pkg-config \
            python3-dev \
            python3-pip \
            uuid-dev \
            zlib1g-dev
        git clone -b REL_15_STABLE https://github.com/postgres/postgres.git
        pushd postgres
        ./configure \
            CFLAGS="-O3 -fargument-noalias-global -fno-omit-frame-pointer" \
            --disable-rpath \
            --enable-cassert \
            --enable-debug \
            --enable-depend \
            --enable-integer-datetimes \
            --enable-thread-safety \
            --prefix=/usr/local \
            --with-gnu-ld \
            --with-gssapi \
            --with-icu \
            --with-includes=/usr/local/include \
            --with-ldap \
            --with-libedit-preferred \
            --with-libraries=/usr/local/lib \
            --with-libxml \
            --with-libxslt \
            --with-llvm \
            --with-lz4 \
            --with-openssl \
            --with-pam \
            --with-perl \
            --with-pgport=5432 \
            --with-python \
            --with-system-tzdata=/usr/share/zoneinfo \
            --with-uuid=e2fs \
            --with-zstd
        make -j"$(nproc)" -C src install
        make -j"$(nproc)" -C contrib install
        make -j"$(nproc)" submake-libpq submake-libpgport submake-libpgfeutils install
        popd
    ;;
esac

which pip3 || curl https://bootstrap.pypa.io/pip/get-pip.py | python3

pip3 install --no-cache-dir \
    dill==0.3.7 \
    grpcio==1.57.0 \
    hyperopt==0.2.5 \
    mock \
    numpy==1.25.2 \
    pandas==2.0.3 \
    protobuf==3.19.4 \
    pypmml \
    pyxb \
    pyxb-x==1.2.6.1 \
    pyyaml==6.0.1 \
    scikit-learn==1.3.0 \
    scipy==1.11.2 \
    tensorflow==2.10 \
    xgboost==1.7.6

case "$MADLIB_PORT" in
    greengage)
        source gpdb_src/concourse/scripts/common.bash
        install_and_configure_gpdb
        gpdb_src/concourse/scripts/setup_gpadmin_user.bash
        make_cluster
    ;;
esac

pushd "$(dirname "$0")/.."
./configure
make -j"$(nproc)" install
make -j"$(nproc)" extension-install
popd
