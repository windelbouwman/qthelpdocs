#!/bin/bash

set -e

VER=0.7.5

if [[ ! -f build/sympy-${VER}/doc/build/qthelp/SymPy.qhp ]]; then
    echo "Building sympy docs"
    if [[ ! -f src/sympy-${VER}.tar.gz ]]; then
        echo "Downloading sympy"
        curl -L -o src/sympy-${VER}.tar.gz https://github.com/sympy/sympy/releases/download/sympy-${VER}/sympy-${VER}.tar.gz
    fi

    cd build
    tar xzf "../src/sympy-${VER}.tar.gz"

    cd sympy-${VER}/doc
    sphinx-build -b qthelp src build/qthelp
    cd ../../..
fi
