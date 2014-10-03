#!/bin/bash

set -e

if [[ ! -f build/matplotlib-1.4.0/doc/build/qthelp/Matplotlib.qhp ]]; then
    echo "Building matplotlib docs"
    if [[ ! -f src/matplotlib-1.4.0.tar.gz ]]; then
        echo "Downloading matplotlib"
        # Use -L for redirect of sourcefourge
        curl -L -o src/matplotlib-1.4.0.tar.gz http://downloads.sourceforge.net/project/matplotlib/matplotlib/matplotlib-1.4.0/matplotlib-1.4.0.tar.gz
    fi
    cd build
    tar xzf ../src/matplotlib-1.4.0.tar.gz
    cd matplotlib-1.4.0/doc

    # We need to run html first!
    python make.py html

    # Now we can invoke qthelp generation:
    sphinx-build -b qthelp -d build/doctrees . build/qthelp

    cd ../../..
fi

