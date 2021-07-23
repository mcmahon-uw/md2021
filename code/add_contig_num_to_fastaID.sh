#! /bin/bash

#######################
## 2020-11-15
## Add a new contig number to the fastaID.
## Don't forget to create a lookup table to link old and new names!
#######################

mkdir contig_num

for FILE in *.fa;
  do
      awk '/^>/{$0=$0"~Contig_"(++i)}1' < $FILE > contig_num/${FILE}
  done
