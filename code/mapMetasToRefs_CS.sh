#! /bin/bash

# Map metagenomic reads to assemblies

BBPATH=/opt/bifxapps/bbmap-38.32
SAMTOOLS=/opt/bifxapps/samtools-1.9/bin

ref=$1
meta=$2
out=$3

cd /home/GLBRCORG/trina.mcmahon/md2021/analysis/CedarSwamp/mapping/

$BBPATH/bbmap.sh ref=$ref in=$meta outm=$out idtag minid=0.95 nodisk -Xmx100g
$SAMTOOLS/samtools sort $out -o ${out%.bam}.sorted.bam
