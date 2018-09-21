#!/bin/sh
set -eux
mkdir /workspace; cd /workspace

apt-get update && apt-get install -y libcurl4-openssl-dev libelf-dev libdw-dev binutils-dev cmake gcc

curl -L -OsS "https://static.rust-lang.org/rustup/dist/x86_64-unknown-linux-gnu/rustup-init"
chmod +x rustup-init
./rustup-init -y --no-modify-path --default-toolchain ${TOOLCHAIN}
chmod -R a+w $RUSTUP_HOME $CARGO_HOME

kcov_version=36
curl -L -OsS "https://github.com/SimonKagstrom/kcov/archive/v${kcov_version}.tar.gz"
tar -xf v${kcov_version}.tar.gz
cd kcov-${kcov_version}
mkdir build; cd build
cmake .. && make && make install
which kcov

cargo install cargo-kcov

if [ "${TOOLCHAIN}" != "nightly" ]; then
  rustup toolchain add nightly
fi

rustup component add rustfmt-preview --toolchain nightly
rustup component add clippy-preview --toolchain nightly

rustup show
cargo --version

cd /root; rm -rf /workspace
