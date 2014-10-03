#!/bin/bash

set -e

if [[ ! -f build/pyserial-2.7/documentation/build/qthelp/pySerial.qhp ]]; then
    echo "Building pyserial docs"
    if [[ ! -f src/pyserial-2.7.tar.gz ]]; then
        echo "Downloading pyserial"
        curl -L -o src/pyserial-2.7.tar.gz http://downloads.sourceforge.net/project/pyserial/pyserial/2.7/pyserial-2.7.tar.gz
    fi

    cd build
    tar xzf ../src/pyserial-2.7.tar.gz

    cd pyserial-2.7/documentation
    sphinx-build -b qthelp . build/qthelp
    cd ../../..
fi
