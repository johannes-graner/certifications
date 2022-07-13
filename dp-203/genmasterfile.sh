#!/bin/bash
dir=$1

for file in "$dir/*.md"
do
  cat $file >> $dir.md
  echo "\n" >> $dir.md
done