#!/bin/bash

find . -type f -iname "*.wav" -exec sh -c 'n1=$0; n2=${n1%.*}; ffmpeg -i "${n2}".wav "${n2}".flac' {} \;
