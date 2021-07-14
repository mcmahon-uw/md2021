### Analysis notes for looking at Trunk River data in MicDiv course MD2021

Looking at metagenomes from 2018

Trim the fastqs

```



source /home/GLBRCORG/trina.mcmahon/miniconda3/etc/profile.d/conda.sh
PYTHONPATH=""
conda activate bioinformatics

fastp --in1 ~/md2021/data/metagenomes/TrunkRiver/baby_lem_CTCTCTAC-AGAGTAGA_L001_R1_001.fastq.gz --in2 ~/md2021/data/metagenomes/TrunkRiver/baby_lem_CTCTCTAC-AGAGTAGA_L001_R2_001.fastq.gz --out1 baby_lem_CTCTCTAC-AGAGTAGA_L001_R1_001.qcd.fastq.gz --out2 baby_lem_CTCTCTAC-AGAGTAGA_L001_R2_001.qcd.fastq.gz --detect_adapter_for_pe  --cut_tail --cut_tail_window_size 15 --cut_tail_mean_quality 25 -h BabyLem_2018_qcd.html &

fastp --in1 ~/md2021/data/metagenomes/TRNSB_CAGAGAGG-AGAGTAGA_L001_R1_001.fastq.gz --in2 ~/md2021/data/metagenomes/TRNSB_CAGAGAGG-AGAGTAGA_L001_R2_001.fastq.gz --out1 TRNSB_CAGAGAGG-AGAGTAGA_L001_R1_001.qcd.fastq.gz --out2 TRNSB_CAGAGAGG-AGAGTAGA_L001_R2_001.qcd.fastq.gz --detect_adapter_for_pe  --cut_tail --cut_tail_window_size 15 --cut_tail_mean_quality 25 -h TRNSB_2018_qcd.html &

fastp --in1 ~/md2021/data/metagenomes/near_lem_GGACTCCT-AGAGTAGA_L001_R1_001.fastq.gz --in2 ~/md2021/data/metagenomes/near_lem_GGACTCCT-AGAGTAGA_L001_R2_001.fastq.gz --out1 near_lem_GGACTCCT-AGAGTAGA_L001_R1_001.qcd.fastq.gz --out2 near_lem_GGACTCCT-AGAGTAGA_L001_R2_001.qcd.fastq.gz --detect_adapter_for_pe  --cut_tail --cut_tail_window_size 15 --cut_tail_mean_quality 25 -h NearLem_2018_qcd.html &

fastp --in1 ~/md2021/data/metagenomes/TRYSB_TAAGGCGA-GTAAGGAG_L001_R1_001.fastq.gz --in2 ~/md2021/data/metagenomes/TRYSB_TAAGGCGA-GTAAGGAG_L001_R2_001.fastq.gz --out1 TRYSB_TAAGGCGA-GTAAGGAG_L001_R1_001.qcd.fastq.gz --out2 TRYSB_TAAGGCGA-GTAAGGAG_L001_R2_001.qcd.fastq.gz --detect_adapter_for_pe  --cut_tail --cut_tail_window_size 15 --cut_tail_mean_quality 25 -h TRYSB_2018_qcd.html &

fastp --in1 far_lem_TAGGCATG-AGAGTAGA_L001_R1_001.fastq.gz --in2 far_lem_TAGGCATG-AGAGTAGA_L001_R2_001.fastq.gz --out1 far_lem_TAGGCATG-AGAGTAGA_L001_R1_001.qcd.fastq.gz --out2 far_lem_TAGGCATG-AGAGTAGA_L001_R2_001.qcd.fastq.gz --detect_adapter_for_pe  --cut_tail --cut_tail_window_size 15 --cut_tail_mean_quality 25 -h far_lem_2018_qcd.html &

```



### Assembly with metaSpades

First Baby Lemonade

```

SPADESPATH=/opt/bifxapps/SPAdes-3.13.1/bin/

nohup $SPADESPATH/spades.py -t 20 -m 800 --meta -k 21,33,55,77,99,127 -1 ~/md2021/data/metagenomes/TrunkRiver/baby_lem_CTCTCTAC-AGAGTAGA_L001_R1_001.qcd.fastq.gz -2 ~/md2021/data/metagenomes/TrunkRiver/baby_lem_CTCTCTAC-AGAGTAGA_L001_R2_001.qcd.fastq.gz -o baby_lem3 &


```

Note:  had a lot of trouble with getting spades to run because it had





Next near lemonade

```
SPADESPATH=/opt/bifxapps/SPAdes-3.13.1/bin/

nohup $SPADESPATH/spades.py -t 20 -m 800 --meta -k 21,33,55,77,99,127 -1 ~/md2021/data/metagenomes/TrunkRiver/near_lem_GGACTCCT-AGAGTAGA_L001_R1_001.qcd.fastq.gz -2 ~/md2021/data/metagenomes/TrunkRiver/near_lem_GGACTCCT-AGAGTAGA_L001_R2_001.qcd.fastq.gz -o near_lem_2018 &

```



Next TRYSB


```
SPADESPATH=/opt/bifxapps/SPAdes-3.13.1/bin

nohup $SPADESPATH/spades.py -t 15 -m 800 --meta -k 21,33,55,77,99,127 -1 ~/md2021/data/metagenomes/TrunkRiver/TRYSB_TAAGGCGA-GTAAGGAG_L001_R1_001.qcd.fastq.gz -2 ~/md2021/data/metagenomes/TrunkRiver/TRYSB_TAAGGCGA-GTAAGGAG_L001_R2_001.qcd.fastq.gz -o TRYSB_2018 &

```
TRNSB not done yet

```
nohup /opt/bifxapps/bin/python3.4 /opt/bifxapps/SPAdes-3.9.0-Linux/bin/spades.py -t 20 -m 800 --meta -k 21,33,55,77,99,127 -1 ~/md2021/data/metagenomes/TrunkRiver/TRNSB_CAGAGAGG-AGAGTAGA_L001_R1_001.qcd.fastq.gz -2 ~/md2021/data/metagenomes/TrunkRiver/TRNSB_CAGAGAGG-AGAGTAGA_L001_R2_001.qcd.fastq.gz -o TRNSB_2018 &

```



###  Binning
