#!/bin/sh
set -eux

wget "https://static.rust-lang.org/rustup/dist/x86_64-unknown-linux-gnu/rustup-init"

chmod +x rustup-init
./rustup-init -y --no-modify-path --default-toolchain ${TOOLCHAIN}
rm rustup-init
chmod -R a+w $RUSTUP_HOME $CARGO_HOME

apt-get update && apt-get -y install libssl-dev pkg-config cmake zlib1g-dev
RUSTFLAGS="--cfg procmacro2_semver_exempt" cargo install --force cargo-tarpaulin

if [ "${TOOLCHAIN}" != "nightly" ]; then
  rustup toolchain add nightly
fi

rustup component add rustfmt-preview --toolchain nightly
rustup component add clippy-preview --toolchain nightly

rustup show
cargo --version
