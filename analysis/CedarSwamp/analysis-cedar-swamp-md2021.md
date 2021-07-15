###  Analysis notes for looking at Cedar Swamp data in MicDiv course MD2021

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
