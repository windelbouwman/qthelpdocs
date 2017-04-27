#!/bin/bash

set -e

VER=2.0.0

if [[ ! -f build/matplotlib-1.4.0/doc/build/qthelp/Matplotlib.qhp ]]; then
    echo "Building matplotlib docs"
    if [[ ! -f src/matplotlib-${VER}.tar.gz ]]; then
        echo "Downloading matplotlib"
        # Use -L for redirect of sourcefourge
        curl -L -o src/matplotlib-${VER}.tar.gz http://downloads.sourceforge.net/project/matplotlib/matplotlib/matplotlib-${VER}/matplotlib-${VER}.tar.gz
    fi
    cd build
    tar xzf ../src/matplotlib-${VER}.tar.gz
    cd matplotlib-${VER}/doc

    # We need to run html first!
    python make.py html

    # Now we can invoke qthelp generation:
    sphinx-build -b qthelp -d build/doctrees . build/qthelp

    cd ../../..
fi

