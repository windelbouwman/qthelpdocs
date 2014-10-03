#!/bin/bash

BASH=/bin/bash

# Quit on error:
set -e

echo "Doing doc building"
mkdir -p src
mkdir -p build
mkdir -p docs

set +e

find . -maxdepth 1 -name gen_\*.sh | while read line; do
    echo "Generating using file $line"
    $BASH $line
done

# For test of releases
# $BASH gen_python.sh

set -e

source compress_docs.sh

zip -r docs.zip docs

