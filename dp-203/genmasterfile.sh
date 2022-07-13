#!/bin/bash
dir=$1

files="$dir/*.md"
for file in $files
do
  cat $file >> $dir.md
  echo "" >> $dir.md
done