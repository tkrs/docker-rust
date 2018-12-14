FROM buildpack-deps:stretch

ARG TOOLCHAIN=stable

ENV RUSTUP_HOME=/usr/local/rustup
ENV CARGO_HOME=/usr/local/cargo
ENV PATH=/usr/local/cargo/bin:$PATH
ENV TOOLCHAIN=${TOOLCHAIN:-stable}

COPY setup.sh /root/

RUN /root/setup.sh && rm /root/setup.sh
