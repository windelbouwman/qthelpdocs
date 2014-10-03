#!/bin/bash

set -e


if [[ ! -f build/scipy-0.14.0/doc/build/qthelp/SciPy.qhp ]]; then
    echo "Building scipy docs"
    if [[ ! -f src/scipy-0.14.0.tar.gz ]]; then
        echo "Downloading scipy"
        # Use -L for redirect of sourcefourge
        curl -L -o src/scipy-0.14.0.tar.gz http://downloads.sourceforge.net/project/scipy/scipy/0.14.0/scipy-0.14.0.tar.gz
    fi
    cd build
    tar xzf ../src/scipy-0.14.0.tar.gz
    cd scipy-0.14.0/doc
    sphinx-build -b qthelp -d build/doctrees source build/qthelp
    cd ../../..
fi
