
Welcome to qthelp docs.

This project aims to build documentation for use in the qt assistant using
sphinx for the following projects:


- Python
- Numpy
- Scipy
- Sympy
- PySerial
- Matplotlib

This is possible using sphinx documentation generation. It has a qthelp backend to generate qch (qt compressed help) files.
This repository is merely a set of bash scripts to create the right documents.

Building
--------

To build the docs, simply run:

   $ ./make_docs.sh

The documentation will be
generated in the docs folder.


Usage
-----

The .qch files can be included in the qt assistant for easy browsing. Open the qt assistant

1. open the Qt Assistant
2. Got to Edit -> preferences -> documentation tab
3. Click add and select the .qch files you want to view.

Download
--------

Docs can be downloaded under releases of this github repository.

.. image:: https://travis-ci.org/windelbouwman/qthelpdocs.svg?branch=master
    :target: https://travis-ci.org/windelbouwman/qthelpdocs
