#!/bin/bash

set -e

VER=3.6.1

if [[ ! -f build/Python-${VER}/Doc/build/qthelp/Python.qhp ]]; then
    echo "Building python docs"
    if [[ ! -f src/Python-${VER}.tar.xz ]]; then
        echo "Downloading python"
        curl -o src/Python-${VER}.tar.xz https://www.python.org/ftp/python/${VER}/Python-${VER}.tar.xz
    fi

    cd build
    tar xJf ../src/Python-${VER}.tar.xz

    cd Python-${VER}/Doc
    sphinx-build -b qthelp . build/qthelp
    cd ../../..
fi
