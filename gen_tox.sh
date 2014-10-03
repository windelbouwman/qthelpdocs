#!/bin/bash

set -e

TOOL=tox
VER=1.7.2
if [[ ! -f build/${TOOL}-$VER/doc/build/qthelp/Tox.qhp ]]; then
    if [[ ! -f src/${TOOL}-${VER}.tar.gz ]]; then
        # Use -L for redirect of sourcefourge
        curl -L -o src/${TOOL}-${VER}.tar.gz https://bitbucket.org/hpk42/tox/get/${VER}.tar.gz
    fi
    cd build
    tar xzf ../src/${TOOL}-${VER}.tar.gz
    cd ${TOOL}-${VER}/doc
    sphinx-build -b qthelp -d build/doctree . build/qthelp
    cd ../../..
fi
