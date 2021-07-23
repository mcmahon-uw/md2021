###  Analysis notes for looking at Cedar Swamp data in MicDiv course MD2021

After looking at bins, I think these might be crappy.  Only got some lab weeds as bins.  Maybe the DNA extraction didn't work well?



Starting with metagenomes from 2019
Sampled 20190730 by Elizabeth Archie
Water in Cedar Swamp, 30 cm above sediment
https://docs.google.com/spreadsheets/d/1COyvI5uSHCKqAxK6--ZhaAIvcy_9S-wIWYv4NH-AJPc/edit#gid=0

Sample ID:  2019_EAA_30_07_10_TAN_DP_01
2019_EAA_30_07_10_TAN_DP_01_TATCACTCTG-AACGTTACAT_L002_R1_001.fastq.gz
2019_EAA_30_07_10_TAN_DP_01_TATCACTCTG-AACGTTACAT_L002_R2_001.fastq.gz

Put these on GLBRC (found them in the course share drive)
md2021/data/metagenomes/CedarSwamp

Let's follow Elizabeth's work to clean them up and assemble!

##  Cleanup with fastp

```
source /home/GLBRCORG/trina.mcmahon/miniconda3/etc/profile.d/conda.sh
PYTHONPATH=""
conda activate bioinformatics

fastp --in1 ~/md2021/data/metagenomes/CedarSwamp/2019_EAA_30_07_10_TAN_DP_01_TATCACTCTG-AACGTTACAT_L002_R1_001.fastq.gz --in2 ~/md2021/data/metagenomes/CedarSwamp/2019_EAA_30_07_10_TAN_DP_01_TATCACTCTG-AACGTTACAT_L002_R2_001.fastq.gz --out1 2019_EAA_30_07_10_TAN_DP_01_TATCACTCTG-AACGTTACAT_L002_R1_001.fastq.qcd.gz --out2 2019_EAA_30_07_10_TAN_DP_01_TATCACTCTG-AACGTTACAT_L002_R2_001.fastq.qcd.gz --detect_adapter_for_pe  --cut_tail --cut_tail_window_size 15 --cut_tail_mean_quality 25 -h CedarSwamp_2019_EAA_30cm.html
```

Next interleave them:

```

~/md2021/code/reformat-fastq.sh ~/md2021/data/metagenomes/CedarSwamp/2019_EAA_30_07_10_TAN_DP_01_TATCACTCTG-AACGTTACAT_L002_R1_001.fastq.qcd.gz ~/md2021/data/metagenomes/CedarSwamp/2019_EAA_30_07_10_TAN_DP_01_TATCACTCTG-AACGTTACAT_L002_R2_001.fastq.qcd.gz CedarSwamp_2019_EAA_30cm.fastq.qcd.gz

```

###  Assembly

Login directly to scarcity-9

```
~/md2021/code/spades_assembly.sh CedarSwamp_2019_EAA_30cm ~/md2021/data/metagenomes/CedarSwamp/2019_EAA_30_07_10_TAN_DP_01_TATCACTCTG-AACGTTACAT_L002_R1_001.fastq.qcd.gz ~/md2021/data/metagenomes/CedarSwamp/2019_EAA_30_07_10_TAN_DP_01_TATCACTCTG-AACGTTACAT_L002_R2_001.fastq.qcd.gz &

```

###  BINNING

Now map

Tried using Eliz's submission stuff but it wouldn't work
Run as an interactive job instead

```
cd /home/GLBRCORG/trina.mcmahon/md2021/analysis/CedarSwamp/mapping/

BBPATH=/opt/bifxapps/bbmap-38.32


nohup $BBPATH/bbmap.sh ref=/home/GLBRCORG/trina.mcmahon/md2021/analysis/CedarSwamp/assembly/CedarSwamp_2019_EAA_30cm_scaffolds.fasta in=/home/GLBRCORG/trina.mcmahon/md2021/data/metagenomes/CedarSwamp/CedarSwamp_2019_EAA_30cm.fastq.qcd.gz outm=CedarSwamp_mapping.bam idtag minid=0.95 nodisk -Xmx100g &

```
ok, now sort

```
conda activate bioinformatics

samtools sort CedarSwamp_mapping.bam -o CedarSwamp_mapping.sorted.bam &
```

```
/opt/bifxapps/metabat-2.12.1/jgi_summarize_bam_contig_depths --outputDepth CedarSwamp_depth.txt CedarSwamp_mapping.sorted.bam

/opt/bifxapps/metabat-2.12.1/metabat2 -i /home/GLBRCORG/trina.mcmahon/md2021/analysis/CedarSwamp/assembly/CedarSwamp_2019_EAA_30cm_scaffolds.fasta -a CedarSwamp_depth.txt -o CedarSwamp_bins/bin


for file in bin*
  do
    mv $file CedarSwamp_$file
  done


```

Got 6 bins

Classify please

```
source /home/GLBRCORG/trina.mcmahon/miniconda3/etc/profile.d/conda.sh
unset PYTHONPATH
conda activate gtdbtk-1.4.1

gtdbtk classify_wf \
        --cpus 20 \
        --extension fa \
        --genome_dir /home/GLBRCORG/trina.mcmahon/md2021/analysis/CedarSwamp/binning/CedarSwamp_bins \
        --out_dir taxonomy &

```

Oooof they are crap

d__Bacteria;p__Proteobacteria;c__Gammaproteobacteria;o__Pseudomonadales;f__Moraxellaceae;g__Acinetobacter;s__
d__Bacteria;p__Proteobacteria;c__Gammaproteobacteria;o__Burkholderiales;f__Burkholderiaceae;g__Paraburkholderia;s__Paraburkholderia tropica
d__Bacteria;p__Proteobacteria;c__Gammaproteobacteria;o__Burkholderiales;f__Burkholderiaceae;g__Paraburkholderia;s__
d__Bacteria;p__Proteobacteria;c__Gammaproteobacteria;o__Enterobacterales;f__Enterobacteriaceae;g__Raoultella;s__Raoultella sp003752615
d__Bacteria;p__Proteobacteria;c__Gammaproteobacteria;o__Enterobacterales;f__Enterobacteriaceae;g__Klebsiella;s__Klebsiella pneumoniae

WTH?

Try CheckM

```
source /home/GLBRCORG/trina.mcmahon/miniconda3/etc/profile.d/conda.sh
conda activate bioinformatics
PYTHONPATH=''

checkm lineage_wf \
        -t 25 \
        -x fa \
        /home/GLBRCORG/trina.mcmahon/md2021/analysis/CedarSwamp/binning/CedarSwamp_bins \
        checkM &

checkm qa \
        checkM/lineage.ms \
        checkM \
        -o 2 \
        -f checkM/checkm.out \
        --tab_table

awk -F '\t' -v OFS='\t' '{ print $1,$6,$7,$9,$11,$13,$15,$17,$19,$23 }' checkM/checkm.out > checkm_stats.tsv
```



Now coverM

First change names

```
cd ~/md2021/analysis/CedarSwamp/binning/CedarSwamp_bins
mkdir fastas_renamed

for FILE in *.fa;
do
 awk '/^>/ {gsub(/.fa/,"",FILENAME);printf(">%s\n",FILENAME);next;} {print}' $FILE > fastas_renamed/${FILE}
done &

mkdir contig_num

for FILE in *.fa;
  do
      awk '/^>/{$0=$0"_Contig_"(++i)}1' < $FILE > contig_num/${FILE}
  done
```

See coverm_mapping.sh
They have quite high coverage
Dunno what is up
