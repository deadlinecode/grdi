#!/bin/bash
ARCH=$(dpkg --print-architecture)
if [ "${ARCH}" = "amd64" ]; then
  ARCH="x64"
fi

URL="https://github.com/actions/runner/releases/download/v2.317.0/actions-runner-linux-${ARCH}-2.317.0.tar.gz"

echo "Downloading ${URL}"
mkdir runner
curl -L ${URL} | tar xz -C runner