#!/bin/bash

shopt -s nullglob

for FILE in *.zip
do
  NAME=$(basename "$FILE" .zip)
  unzip -d "$NAME" "$FILE"
done
