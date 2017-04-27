#!/bin/bash

set -e

VER=3.3
PKGURL=https://github.com/pyserial/pyserial/archive/v${VER}.tar.gz
LOCALZIP=pyserial-${VER}.tar.gz

if [[ ! -f build/pyserial-${VER}/documentation/build/qthelp/pySerial.qhp ]]; then
    echo "Building pyserial docs"
    if [[ ! -f src/${LOCALZIP} ]]; then
        echo "Downloading pyserial"
        curl -L -o src/${LOCALZIP} ${PKGURL}
    fi

    cd build
    tar xzf ../src/${LOCALZIP}

    cd pyserial-${VER}/documentation
    sphinx-build -b qthelp -D html_theme=agogo . build/qthelp
    cd ../../..
fi
