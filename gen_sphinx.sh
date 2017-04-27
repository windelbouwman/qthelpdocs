#!/bin/bash

set -e

VER=1.5.5
PKGURL=https://pypi.python.org/packages/64/78/9d63754981e97c8e7cf14500d262fc573145624d4c765d5047f58e3fdf4e/Sphinx-1.5.5.tar.gz

if [[ ! -f build/Sphinx-$VER/doc/build/qthelp/Sphinx.qhp ]]; then
    if [[ ! -f src/Sphinx-${VER}.tar.gz ]]; then
        # Use -L for redirect of sourcefourge
        curl -L -o src/Sphinx-${VER}.tar.gz ${PKGURL}
    fi
    cd build
    tar xzf ../src/Sphinx-${VER}.tar.gz
    cd Sphinx-${VER}/doc
    sphinx-build -b qthelp -d build/doctree . build/qthelp
    cd ../../..
fi
