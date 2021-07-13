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
