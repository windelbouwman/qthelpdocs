#!/bin/bash

set -e

VER=1.7

if [[ ! -f build/django-${VER}/docs/build/qthelp/Django.qhp ]]; then
    echo "Building django docs"
    if [[ ! -f src/django-${VER}.tar.gz ]]; then
        echo "Downloading django"
        curl -L -o src/django-${VER}.tar.gz https://github.com/django/django/archive/${VER}.tar.gz
    fi

    cd build
    tar xzf "../src/django-${VER}.tar.gz"

    cd django-${VER}/docs
    sphinx-build -b qthelp . build/qthelp
    cd ../../..
fi
