#!/bin/sh

python2 bin/yucca -t || exit 1
python3 bin/yucca -t || exit 1
