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
Taking forever and thrashing around trying to submit and get resources. Can't figure out if I have the submit file setup right so try running interactive but then can't close terminal???


Log in directly to scarcity-7
```
SPADESPATH=/opt/bifxapps/SPAdes-3.13.1/bin/

nohup $SPADESPATH/spades.py -t 28 -m 230 --meta -k 21,33,55,77,99,127 -1 ~/md2021/data/metagenomes/TrunkRiver/near_lem_GGACTCCT-AGAGTAGA_L001_R1_001.qcd.fastq.gz -2 ~/md2021/data/metagenomes/TrunkRiver/near_lem_GGACTCCT-AGAGTAGA_L001_R2_001.qcd.fastq.gz -o near_lem_2018_4 &

```








Next TRYSB


```
SPADESPATH=/opt/bifxapps/SPAdes-3.13.1/bin

nohup $SPADESPATH/spades.py -t 20 -m 800 --meta -k 21,33,55,77,99,127 -1 ~/md2021/data/metagenomes/TrunkRiver/TRYSB_TAAGGCGA-GTAAGGAG_L001_R1_001.qcd.fastq.gz -2 ~/md2021/data/metagenomes/TrunkRiver/TRYSB_TAAGGCGA-GTAAGGAG_L001_R2_001.qcd.fastq.gz -o TRYSB_2018 &

```
TRNSB not done yet

```
nohup /opt/bifxapps/bin/python3.4 /opt/bifxapps/SPAdes-3.9.0-Linux/bin/spades.py -t 20 -m 800 --meta -k 21,33,55,77,99,127 -1 ~/md2021/data/metagenomes/TrunkRiver/TRNSB_CAGAGAGG-AGAGTAGA_L001_R1_001.qcd.fastq.gz -2 ~/md2021/data/metagenomes/TrunkRiver/TRNSB_CAGAGAGG-AGAGTAGA_L001_R2_001.qcd.fastq.gz -o TRNSB_2018 &

```


Next interleave them:

```

~/md2021/code/reformat-fastq.sh ~/md2021/data/metagenomes/TrunkRiver/TRNSB_CAGAGAGG-AGAGTAGA_L001_R1_001.qcd.fastq.gz ~/md2021/data/metagenomes/TrunkRiver/TRNSB_CAGAGAGG-AGAGTAGA_L001_R2_001.qcd.fastq.gz TRNSB_2018.qcd.fastq.gz

```

etc for others

###  Mapping

Map the metaGs to the assembly for binning

TRYSB

```
BBPATH=/opt/bifxapps/bbmap-38.32

$BBPATH/bbmap.sh ref=/home/GLBRCORG/trina.mcmahon/md2021/analysis/TrunkRiver/assembly/TRYSB_2018_scaffolds.fasta in=/home/GLBRCORG/trina.mcmahon/md2021/data/metagenomes/TrunkRiver/TRYSB_2018.qcd.fastq.gz outm=TRYSB_2018_mapping.bam idtag minid=0.95 nodisk -Xmx50g &


```

```
source /home/GLBRCORG/trina.mcmahon/miniconda3/etc/profile.d/conda.sh
PYTHONPATH=""

conda activate bioinformatics

samtools sort TRYSB_2018_mapping.bam -o TRYSB_2018_mapping.sorted.bam &

```

Map just to see coverages using coverM

See coverm_mapping.sh code



Waiting for the other assemblies to be done....

near_lem

```
BBPATH=/opt/bifxapps/bbmap-38.32

nohup $BBPATH/bbmap.sh ref=/home/GLBRCORG/trina.mcmahon/md2021/analysis/TrunkRiver/mapping/near_lem_2018_scaffolds.fasta in=/home/GLBRCORG/trina.mcmahon/md2021/data/metagenomes/TrunkRiver/near_Lem_2018.qcd.fastq.gz outm=near_lem_2018_mapping.bam idtag minid=0.95 nodisk -Xmx100g &

source /home/GLBRCORG/trina.mcmahon/miniconda3/etc/profile.d/conda.sh
PYTHONPATH=""

conda activate bioinformatics

samtools sort near_lem_2018_mapping.bam -o near_lem_2018_mapping.sorted.bam

```

baby_lem

```
BBPATH=/opt/bifxapps/bbmap-38.32

nohup $BBPATH/bbmap.sh ref=/home/GLBRCORG/trina.mcmahon/md2021/analysis/TrunkRiver/mapping/baby_lem_2018_scaffolds.fasta in=/home/GLBRCORG/trina.mcmahon/md2021/data/metagenomes/TrunkRiver/baby_lem_2018.qcd.fastq.gz outm=baby_lem_2018_mapping.bam idtag minid=0.95 nodisk -Xmx100g &

source /home/GLBRCORG/trina.mcmahon/miniconda3/etc/profile.d/conda.sh
PYTHONPATH=""

conda activate bioinformatics

samtools sort baby_lem_2018_mapping.bam -o baby_lem_2018_mapping.sorted.bam

```

### Binning

Using Eliz's submission code to structure it.

# TRYSB

```
/opt/bifxapps/metabat-2.12.1/jgi_summarize_bam_contig_depths --outputDepth TRYSB_2018_depth.txt TRYSB_2018_mapping.sorted.bam

/opt/bifxapps/metabat-2.12.1/metabat2 -i /home/GLBRCORG/trina.mcmahon/md2021/analysis/TrunkRiver/assembly/TRYSB_2018_scaffolds.fasta -a TRYSB_2018_depth.txt -o TRYSB_2018_bins/bin


for file in bin*
  do
    mv $file TRYSB_2018_$file
  done


```

Got 13 bins

Try GTDBK

```
source /home/GLBRCORG/trina.mcmahon/miniconda3/etc/profile.d/conda.sh
unset PYTHONPATH
conda activate gtdbtk-1.4.1

gtdbtk classify_wf \
        --cpus 20 \
        --extension fa \
        --genome_dir /home/GLBRCORG/trina.mcmahon/md2021/analysis/TrunkRiver/mapping/TRYSB_2018_bins \
        --out_dir taxonomy &

```
# near_lem

```
/opt/bifxapps/metabat-2.12.1/jgi_summarize_bam_contig_depths --outputDepth near_lem_2018_depth.txt near_lem_2018_mapping.sorted.bam

/opt/bifxapps/metabat-2.12.1/metabat2 -i /home/GLBRCORG/trina.mcmahon/md2021/analysis/TrunkRiver/assembly/near_lem_2018_scaffolds.fasta -a near_lem_2018_depth.txt -o near_lem_2018_bins/bin


for file in bin*
  do
    mv $file near_lem_2018_$file
  done


```

Got 31 bins

Try GTDBK

```
source /home/GLBRCORG/trina.mcmahon/miniconda3/etc/profile.d/conda.sh
unset PYTHONPATH
conda activate gtdbtk-1.4.1

gtdbtk classify_wf \
        --cpus 20 \
        --extension fa \
        --genome_dir /home/GLBRCORG/trina.mcmahon/md2021/analysis/TrunkRiver/mapping/near_lem_2018_bins \
        --out_dir taxonomy &

```



# baby_lem

```
/opt/bifxapps/metabat-2.12.1/jgi_summarize_bam_contig_depths --outputDepth baby_lem_2018_depth.txt baby_lem_2018_mapping.sorted.bam

/opt/bifxapps/metabat-2.12.1/metabat2 -i /home/GLBRCORG/trina.mcmahon/md2021/analysis/TrunkRiver/assembly/baby_lem_2018_scaffolds.fasta -a baby_lem_2018_depth.txt -o baby_lem_2018_bins/bin


for file in bin*
  do
    mv $file baby_lem_2018_$file
  done


```

Got XX bins

Now GTDBK


```
source /home/GLBRCORG/trina.mcmahon/miniconda3/etc/profile.d/conda.sh
unset PYTHONPATH
conda activate gtdbtk-1.4.1

gtdbtk classify_wf \
        --cpus 20 \
        --extension fa \
        --genome_dir /home/GLBRCORG/trina.mcmahon/md2021/analysis/TrunkRiver/mapping/baby_lem_2018_bins \
        --out_dir taxonomy &

```





## VIBRANT

# baby_lem

852604 scaffolds were read in.
8105 scaffolds met minimum requirements: at least 1000bp and 4 ORFs.
273 putative phages were identified.
