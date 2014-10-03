#!/bin/bash

set -e

NUMPYVER=1.8.2
if [[ ! -f build/numpy-$NUMPYVER/doc/build/qthelp/NumPy.qhp ]]; then
    echo "Building numpy $NUMPYVER docs"
    if [[ ! -f src/numpy-${NUMPYVER}.tar.gz ]]; then
        echo "Downloading numpy"
        # Use -L for redirect of sourcefourge
        curl -L -o src/numpy-${NUMPYVER}.tar.gz http://downloads.sourceforge.net/project/numpy/NumPy/${NUMPYVER}/numpy-${NUMPYVER}.tar.gz
    fi
    cd build
    tar xzf ../src/numpy-${NUMPYVER}.tar.gz
    cd numpy-${NUMPYVER}/doc
    sphinx-build -b qthelp -d build/doctree source build/qthelp
    cd ../../..
fi
