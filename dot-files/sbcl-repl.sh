#!/bin/bash

find ~/.emacs.d/elpa -name start-swank.lisp -exec sbcl --load {} \;



