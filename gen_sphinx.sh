#!/bin/bash

set -e

VER=1.2.3
if [[ ! -f build/Sphinx-$VER/doc/build/qthelp/Sphinx.qhp ]]; then
    if [[ ! -f src/Sphinx-${VER}.tar.gz ]]; then
        # Use -L for redirect of sourcefourge
        curl -L -o src/Sphinx-${VER}.tar.gz https://pypi.python.org/packages/source/S/Sphinx/Sphinx-${VER}.tar.gz
    fi
    cd build
    tar xzf ../src/Sphinx-${VER}.tar.gz
    cd Sphinx-${VER}/doc
    sphinx-build -b qthelp -d build/doctree . build/qthelp
    cd ../../..
fi
