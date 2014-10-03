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

set -e

echo "Collecting docs (all qt help projects)"
find build -name \*.qhp | while read line; do
    echo "Adding qt help project $line"
    FILENAME=$(basename $line)
    QCH_FILE="docs/${FILENAME%.*}.qch"
    echo "OUTPUT: $QCH_FILE"
    qhelpgenerator $line -o $QCH_FILE
done

PROJ_FILE=docs.qhcp

cat > ${PROJ_FILE} << EOF
<?xml version="1.0" encoding="utf-8" ?>
 <QHelpCollectionProject version="1.0">
  <docFiles>
   <register>
EOF

find docs -name \*.qch | while read line; do
    echo "Adding qch file $line"
    echo "<file>$line</file>" >> ${PROJ_FILE}
done

cat >> ${PROJ_FILE} << EOF
    </register>
  </docFiles>
</QHelpCollectionProject>
EOF

# TODO: adjust qhcp according to results..
qcollectiongenerator ${PROJ_FILE} -o docs/docs.qhc

rm ${PROJ_FILE}

zip -r docs.zip docs

