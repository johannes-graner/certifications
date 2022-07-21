#!/bin/bash

rm -rf master-files all-modules.md
dirs=$(ls -d */)
mkdir master-files

for dir in $dirs
do
  dirname=${dir%?}
  masterfile=$dirname.md
  files="$dir*.md"
  for file in $files
  do
    cat $file >> $masterfile
    echo "" >> $masterfile
  done
  cat $masterfile >> all-modules.md
  mv $masterfile master-files
done

mv all-modules.md master-files