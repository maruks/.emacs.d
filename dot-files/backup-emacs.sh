#!/bin/bash

FILENAME=emacs-$(hostname)-$(date +%F-%H-%M).tar.xz

cd

tar -c --xz -f "/tmp/$FILENAME" .emacs.d

scp "/tmp/$FILENAME" maruks.homelinux.org:/mnt/internal/Backups

rm "/tmp/$FILENAME"
