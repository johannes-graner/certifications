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


# rm 01-az-for-the-de.md
# ./genmasterfile.sh 01-az-for-the-de
# cat 01-az-for-the-de.md >> all-modules.md

# rm 02-store-data-in-azure.md
# ./genmasterfile.sh 02-store-data-in-azure
# cat 02-store-data-in-azure.md >> all-modules.md

# rm 03-data-int-adf-synapse.md
# ./genmasterfile.sh 03-data-int-adf-synapse
# cat 03-data-int-adf-synapse.md >> all-modules.md

# rm 04-int-anal-sol-synapse.md
# ./genmasterfile.sh 04-int-anal-sol-synapse
# cat 04-int-anal-sol-synapse.md >> all-modules.md

# rm 05-dwh-synapse.md
# ./genmasterfile.sh 05-dwh-synapse
# cat 05-dwh-synapse.md >> all-modules.md

# rm 06-spark-synapse.md
# ./genmasterfile.sh 06-spark-synapse
# cat 06-spark-synapse.md >> all-modules.md

# rm 07-hybrid-trans-anal-synapse.md
# ./genmasterfile.sh 07-hybrid-trans-anal-synapse
# cat 07-hybrid-trans-anal-synapse.md >> all-modules.md

# rm 08-de-dbx.md
# ./genmasterfile.sh 08-de-dbx
# cat 08-de-dbx.md >> all-modules.md

# rm 09-big-dp-adlg2.md
# ./genmasterfile.sh 09-big-dp-adlg2
# cat 09-big-dp-adlg2.md >> all-modules.md

# rm 10-stream-analytics.md
# ./genmasterfile.sh 10-stream-analytics
# cat 10-stream-analytics.md >> all-modules.md
