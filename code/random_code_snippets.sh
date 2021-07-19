
# RENAME FILES based on a lookup table
# Use this while in the directory where the files live.
cat myfile.csv | while IFS=, read old new
  do mv "$old" "$new"
  done

# RENAME FILES to prepened a string

for file in 2*
  do
    mv $file ./MAGv1_$file
  done

# RENAME FILES to append a string

for file in *.fa
  do
    mv -- "$file" "${file%.fa}.fna"
  done


###  Super simple code to rename files based on a list of names linking the
####  new name to the old name.
# Use this while in the directory where the files live.
  cat myfile.csv | while IFS=, read old new
    do mv "$old" "$new"
  done


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

  #######################
  ##
  ## Remove every delimiter other than underscores and replace with underscores
  ##
  #######################

  mkdir fixit

  for FILE in *.fna
  do
    cat $FILE | sed 's/\~/_/g' | sed 's/-/_/g' | sed 's/\./_/g' > fixit/$FILE
  done

  #######################
  ##
  ## Change suffix
  ##
  #######################

  for f in *.fa
  do
    mv -- "$f" "${f%.fa}.fna";
  done
