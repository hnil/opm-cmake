#!/bin/bash
FILES=$(<modules)
for f in $FILES
do
  echo "Processing $f file..."
  # take action on each file. $f store current file name
  cd $f
  $@
  cd ..
done
