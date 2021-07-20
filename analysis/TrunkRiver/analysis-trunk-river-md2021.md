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

I have three Chlorobi bins!!!

near_lem_2018_bin.4
near_lem_2018_bin.5
near_lem_2018_bin.20

Try CheckM

```
source /home/GLBRCORG/trina.mcmahon/miniconda3/etc/profile.d/conda.sh
conda activate bioinformatics
PYTHONPATH=''

checkm lineage_wf \
        -t 25 \
        -x fa \
        /home/GLBRCORG/trina.mcmahon/md2021/analysis/TrunkRiver/mapping/near_lem_2018_bins \
        checkM &

checkm qa \
        checkM/lineage.ms \
        checkM \
        -o 2 \
        -f checkM/checkm.out \
        --tab_table

awk -F '\t' -v OFS='\t' '{ print $1,$6,$7,$9,$11,$13,$15,$17,$19,$23 }' checkM/checkm.out > checkm_stats.tsv
```
near_lem_2018_bin.4	44.83	0.00	1006886	11	198761	91535	319604	52.5	931
near_lem_2018_bin.20	53.61	1.10	796142	127	6752	6268	27736	51.7	888
near_lem_2018_bin.5	35.71	0.00	477377	4	137031	119344	164542	52.1	461

phooo... .none very complete



# baby_lem

```
/opt/bifxapps/metabat-2.12.1/jgi_summarize_bam_contig_depths --outputDepth baby_lem_2018_depth.txt baby_lem_2018_mapping.sorted.bam

/opt/bifxapps/metabat-2.12.1/metabat2 -i /home/GLBRCORG/trina.mcmahon/md2021/analysis/TrunkRiver/assembly/baby_lem_2018_scaffolds.fasta -a baby_lem_2018_depth.txt -o baby_lem_2018_bins/bin


for file in bin*
  do
    mv $file baby_lem_2018_$file
  done


```

Got 21 bins for baby_lem

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

Got two bins!

baby_lem_2018_bin.1	d__Bacteria;p__Bacteroidota;c__Chlorobia;o__Chlorobiales;f__Chlorobiaceae;g__Chlorobaculum;s__
baby_lem_2018_bin.12	d__Bacteria;p__Bacteroidota;c__Chlorobia;o__Chlorobiales;f__Chlorobiaceae;g__Prosthecochloris;s__


Try CheckM

```
source /home/GLBRCORG/trina.mcmahon/miniconda3/etc/profile.d/conda.sh
conda activate bioinformatics
PYTHONPATH=''

checkm lineage_wf \
        -t 25 \
        -x fa \
        /home/GLBRCORG/trina.mcmahon/md2021/analysis/TrunkRiver/mapping/baby_lem_2018_bins \
        checkM &

checkm qa \
        checkM/lineage.ms \
        checkM \
        -o 2 \
        -f checkM/checkm.out \
        --tab_table &

awk -F '\t' -v OFS='\t' '{ print $1,$6,$7,$9,$11,$13,$15,$17,$19,$23 }' checkM/checkm.out > checkm_stats.tsv
```


Try coverM

Renamed contigs with change_fastaID_to_filename.sh and add_contig_num_to_fastaID.sh but then needed to clean up in order to map to genomes (need unique separator between genome name and contig number)

Concatenated before the cleanup (so individual ones have different separator)

```
cat baby_lem_bins_concat.fasta | sed "s/\_C/~C/" > baby_lem_bins_concat.fna
```

Wow, bin.1 is only 0.7 % and bin.12 is 0.9% and nothing else is even terribly high. Bin.2 is 2.9% but it is a Campylobacter. Ugh.  Total reads unmapped is 79%

Try relaxing %-ID to 85%
Not any better.


## VIBRANT

# baby_lem

852604 scaffolds were read in.
8105 scaffolds met minimum requirements: at least 1000bp and 4 ORFs.
273 putative phages were identified.

baby_lem_bin.1 didn't have any predicted phages


##  CRISPRs

From Emil:

genome name	CRISPR array #	contig	location (bp)	length	#spacers	DR seq	DR length

Chlorobaculum sp. Trunk_River	CRISPR1	26	20933-26430	42829	82	GTTTCAATTCCATATTGGTGCAATTAAAAT	30
Chlorobaculum sp. Trunk_River	CRISPR2	145	613-1685	16001	14	GTCGCAATACGCTATGCGTGCAATGAAATAGAAAG	35
Chlorobaculum sp. Trunk_River	CRISPR3	145	198-278	16001	2	GTCGCAATACGCTATGCGTGCAATGAAATAGAAAG	35

Prosthecochloris sp. Trunk_River	CRISPR1	20	3561-4695	55534	14	GTCTCAATCCCCCTTACTCAATCGGGTCTGTCTACAC	37
Prosthecochloris sp. Trunk_River	CRISPR2	316	7079-7510	10315	6	GTCGCGCCCCCCGCGGGCGCGTGGATTGAAAC	32
Prosthecochloris sp. Trunk_River	CRISPR3	316	10128-10293	10315	2	GTCGCGCCCCCCGCGGGCGCGTGGATTGAAACC	33


Set up the blasts:

```
source /home/GLBRCORG/trina.mcmahon/miniconda3/etc/profile.d/conda.sh
PYTHONPATH=""
conda activate bioinformatics

makeblastdb -dbtype nucl -in baby_lem_2018_scaffolds.fasta -out baby_lem_2018.fna.db &

blastn -query CRISPR_spacers_from_Emil.fasta -db baby_lem_2018.fna.db -task blastn -evalue 1e-8 -out spacers-vs-baby_lem_2018.blastn -outfmt 6 &

makeblastdb -dbtype nucl -in near_lem_2018_scaffolds.fasta -out near_lem_2018.fna.db &

blastn -query CRISPR_spacers_from_Emil.fasta -db near_lem_2018.fna.db -task blastn -evalue 1e-8 -out spacers-vs-near_lem_2018.blastn -outfmt 6 &
```

Again for the bins from near_lem

```
source /home/GLBRCORG/trina.mcmahon/miniconda3/etc/profile.d/conda.sh
PYTHONPATH=""
conda activate bioinformatics

makeblastdb -dbtype nucl -in near_lem_2018_bin.4.fa -out near_lem_2018_bin.4.fna.db &

blastn -query CRISPR_spacers_from_Emil.fasta -db near_lem_2018_bin.4.fa.db -task blastn -evalue 1e-8 -out spacers-vs-near_lem_bin.4.blastn -outfmt 6 &

makeblastdb -dbtype nucl -in near_lem_2018_bin.5.fa -out near_lem_2018_bin.5.fna.db &

blastn -query CRISPR_spacers_from_Emil.fasta -db near_lem_2018_bin.5.fa.db -task blastn -evalue 1e-8 -out spacers-vs-near_lem_bin.5.blastn -outfmt 6 &

makeblastdb -dbtype nucl -in near_lem_2018_bin.20.fa -out near_lem_2018_bin.20.fa.db &

blastn -query CRISPR_spacers_from_Emil.fasta -db near_lem_2018_bin.20.fa.db -task blastn -evalue 1e-8 -out spacers-vs-near_lem_bin.20.blastn -outfmt 6 &
```

Only a match to near_lem_2018_bin.4.fa on one contig
Prosthecochloris_CRISPR1	NODE_453_length_18739_cov_795.613744	100.000	29

No match in bin.5 or bin.20

Check baby_lem

```
makeblastdb -dbtype nucl -in baby_lem_2018_bin.1.fa -out baby_lem_2018_bin.1.fna.db &

blastn -query CRISPR_spacers_from_Emil.fasta -db baby_lem_2018_bin.1.fna.db -task blastn -evalue 1e-8 -out spacers-vs-baby_lem_bin.1.blastn -outfmt 6 &

makeblastdb -dbtype nucl -in baby_lem_2018_bin.12.fa -out baby_lem_2018_bin.12.fna.db &

blastn -query CRISPR_spacers_from_Emil.fasta -db baby_lem_2018_bin.12.fna.db -task blastn -evalue 1e-8 -out spacers-vs-baby_lem_bin.12.blastn -outfmt 6 &
```


WOW!!!
baby_lem_2018_bin.1.fa has TONS of matches to the Prosthecochloris CRISPRs. Weird because it is the Chlorobaculum...

It's on NODE_253_length_20287_cov_7.990228 so quite long
Need some code to extract the CRISPR spacers (ask Rachel)

Looks like bin.12 might be very similar to bin.4 from near_lem
