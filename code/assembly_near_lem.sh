#! /bin/bash

#  Assemble near_lem_2018

SPADESPATH=/opt/bifxapps/SPAdes-3.13.1/bin/

$SPADESPATH/spades.py -t 20 -m 800 --meta -k 21,33,55,77,99,127 --continue -1 ~/md2021/data/metagenomes/TrunkRiver/near_lem_GGACTCCT-AGAGTAGA_L001_R1_001.qcd.fastq.gz -2 ~/md2021/data/metagenomes/TrunkRiver/near_lem_GGACTCCT-AGAGTAGA_L001_R2_001.qcd.fastq.gz -o near_lem_2018_2 &
