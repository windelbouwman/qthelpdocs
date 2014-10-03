#!/bin/bash

set -e

if [[ ! -f build/Python-3.4.1/Doc/build/qthelp/Python.qhp ]]; then
    echo "Building python docs"
    if [[ ! -f src/Python-3.4.1.tar.xz ]]; then
        echo "Downloading python"
        curl -o src/Python-3.4.1.tar.xz https://www.python.org/ftp/python/3.4.1/Python-3.4.1.tar.xz
    fi

    cd build
    tar xJf ../src/Python-3.4.1.tar.xz

    cd Python-3.4.1/Doc
    sphinx-build -b qthelp . build/qthelp
    cd ../../..
fi
