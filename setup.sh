#!/bin/sh
set -eux

mkdir /workspace; cd /workspace

apt-get update && apt-get install -y cmake g++ pkg-config jq libcurl4-openssl-dev libelf-dev libdw-dev binutils-dev libiberty-dev

curl -L -OsS "https://static.rust-lang.org/rustup/dist/x86_64-unknown-linux-gnu/rustup-init"
chmod +x rustup-init
./rustup-init -y --no-modify-path --default-toolchain ${TOOLCHAIN}
chmod -R a+w $RUSTUP_HOME $CARGO_HOME
rustup component add clippy rustfmt

cargo install cargo-kcov
cargo kcov --print-install-kcov-sh | sh

rustup show
cargo --version

cd /root; rm -rf /workspace
