################
## README
################

Microbial Diversity 2021
Initiated by:  Trina McMahon (course faculty) - trina.mcmahon@wisc.edu

Trunk River metagenomes sampled in 2018

baby_lem dataset

################
## BINNING
################

## Mapped with bbmap

BBPATH=/opt/bifxapps/bbmap-38.32

$BBPATH/bbmap.sh ref=/home/GLBRCORG/trina.mcmahon/md2021/analysis/TrunkRiver/mapping/baby_lem_2018_scaffolds.fasta in=/home/GLBRCORG/trina.mcmahon/md2021/data/metagenomes/TrunkRiver/baby_lem_2018.qcd.fastq.gz outm=baby_lem_2018_mapping.bam idtag minid=0.95 nodisk -Xmx100g &

# Sort the bam file

samtools sort baby_lem_2018_mapping.bam -o baby_lem_2018_mapping.sorted.bam


## Binned with metabat2

#  Summarize depths

/opt/bifxapps/metabat-2.12.1/jgi_summarize_bam_contig_depths --outputDepth baby_lem_2018_depth.txt baby_lem_2018_mapping.sorted.bam

#  Make the bins

/opt/bifxapps/metabat-2.12.1/metabat2 -i /home/GLBRCORG/trina.mcmahon/md2021/analysis/TrunkRiver/assembly/baby_lem_2018_scaffolds.fasta -a baby_lem_2018_depth.txt -o baby_lem_2018_bins/bin

# Made a copy of the bins with renamed fastas for downstream processing
