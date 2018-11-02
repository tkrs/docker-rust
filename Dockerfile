FROM buildpack-deps:stretch

ARG TOOLCHAIN=stable

ENV RUSTUP_HOME=/usr/local/rustup \
    CARGO_HOME=/usr/local/cargo \
    PATH=/usr/local/cargo/bin:$PATH \
    TOOLCHAIN=${TOOLCHAIN:-stable}

COPY setup.sh /root/

RUN /root/setup.sh && rm /root/setup.sh
