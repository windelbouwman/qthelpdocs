#!/bin/bash

set -e

TOOL=tox
VER=2.7.0
PKGURL=https://pypi.io/packages/source/t/tox/tox-${VER}.tar.gz
# PKGURL=https://bitbucket.org/hpk42/tox/get/${VER}.tar.gz
if [[ ! -f build/${TOOL}-$VER/doc/build/qthelp/Tox.qhp ]]; then
    if [[ ! -f src/${TOOL}-${VER}.tar.gz ]]; then
        # Use -L for redirect of sourcefourge
        curl -L -o src/${TOOL}-${VER}.tar.gz ${PKGURL}
    fi
    cd build
    tar xzf ../src/${TOOL}-${VER}.tar.gz
    cd ${TOOL}-${VER}/doc
    sphinx-build -b qthelp -d build/doctree . build/qthelp
    cd ../../..
fi
