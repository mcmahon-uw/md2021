#! /bin/bash

#######################
## 2020-11-15
## Replace fastID with a string that matches the filename
## Don't forget to create a lookup table to relate the old to new fastIDs
#######################

mkdir renamed

for FILE in *.fna;
do
 awk '/^>/ {gsub(/.fna/,"",FILENAME);printf(">%s\n",FILENAME);next;} {print}' $FILE > renamed/${FILE}
done
