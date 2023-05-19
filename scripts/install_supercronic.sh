#!/bin/bash

ARCH=$(uname -m)

if [ "$ARCH" = "x86_64" ]; then
    SUPERCRONIC_URL="https://github.com/aptible/supercronic/releases/download/v0.2.24/supercronic-linux-amd64"
    SUPERCRONIC="supercronic-linux-amd64"
    SUPERCRONIC_SHA1SUM="6817299e04457e5d6ec4809c72ee13a43e95ba41"
elif [ "$ARCH" = "aarch64" ]; then
    SUPERCRONIC_URL="https://github.com/aptible/supercronic/releases/download/v0.2.24/supercronic-linux-arm64"
    SUPERCRONIC="supercronic-linux-arm64"
    SUPERCRONIC_SHA1SUM="fce407a3d7d144120e97cfc0420f16a18f4637d9"
else
    echo "Unsupported architecture: $ARCH"
    exit 1
fi

curl -fsSLO "$SUPERCRONIC_URL" &&
    echo "${SUPERCRONIC_SHA1SUM}  ${SUPERCRONIC}" | sha1sum -c - &&
    chmod +x "$SUPERCRONIC" &&
    mv "$SUPERCRONIC" "/usr/local/bin/${SUPERCRONIC}" &&
    ln -s "/usr/local/bin/${SUPERCRONIC}" /usr/local/bin/supercronic
