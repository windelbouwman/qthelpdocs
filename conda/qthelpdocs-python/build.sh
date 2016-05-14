#!/bin/bash

cd Doc
sphinx-build -b qthelp . build/qthelp
cd ..

qhelpgenerator Doc/build/qthelp/Python.qhp -o python.qch

mkdir -p ${PREFIX}/qthelpdocs
cp python.qch ${PREFIX}/qthelpdocs/python-${PKG_VERSION}.qch
