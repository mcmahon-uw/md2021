#! /bin/bash

#######################
## 2020-11-15
## Replace fastID with a string that matches the filename
## Don't forget to create a lookup table to relate the old to new fastIDs
#######################

mkdir fastas_renamed

for FILE in *.fa;
do
 awk '/^>/ {gsub(/.fa/,"",FILENAME);printf(">%s\n",FILENAME);next;} {print}' $FILE > fastas_renamed/${FILE}
done &
