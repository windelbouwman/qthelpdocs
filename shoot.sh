#!/bin/bash

Xvfb :1 &

export DISPLAY=:1

python qchviewer.py -s --qhc docs/docs.qhc

killall Xvfb
