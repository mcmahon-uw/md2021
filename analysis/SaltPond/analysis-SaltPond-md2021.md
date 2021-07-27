### MD2021 Salt Pond

Metagenomes from 2018


SP350CM	Salt Pond Metagenome, 350 cm depth	 26,482,975
SP375CM	Salt Pond Metagenome, 375 cm depth	 28,847,900
SP400CM	Salt Pond Metagenome, 400 cm depth	 30,412,331

##  Cleanup

```


source /home/GLBRCORG/trina.mcmahon/miniconda3/etc/profile.d/conda.sh
PYTHONPATH=""
conda activate bioinformatics

fastp --in1 ~/md2021/data/metagenomes/SaltPond/SP375CM_TAAGGCGA-CGTCTAAT_L001_R1_001.fastq.gz \
  --in2 ~/md2021/data/metagenomes/SaltPond/SP375CM_TAAGGCGA-CGTCTAAT_L001_R2_001.fastq.gz \
  --out1 SP_375cm_R1.qcd.fastq.gz --out2 SP_375cm_R2.qcd.fastq.gz \
  --detect_adapter_for_pe  --cut_tail --cut_tail_window_size 15 \
  --cut_tail_mean_quality 25 -h SaltPond_375cm_qcd.html &


fastp --in1 ~/md2021/data/metagenomes/SaltPond/SP350CM_AGGCAGAA-TTATGCGA_L001_R1_001.fastq.gz \
  --in2 ~/md2021/data/metagenomes/SaltPond/SP350CM_AGGCAGAA-TTATGCGA_L001_R2_001.fastq.gz \
  --out1 SP_350cm_R1.qcd.fastq.gz --out2 SP_350cm_R2.qcd.fastq.gz \
  --detect_adapter_for_pe  --cut_tail --cut_tail_window_size 15 \
  --cut_tail_mean_quality 25 -h SaltPond_350_qcd.html &


fastp --in1 ~/md2021/data/metagenomes/SaltPond/SP400CM_CTCTCTAC-TCGACTAG_L001_R1_001.fastq.gz \
  --in2 ~/md2021/data/metagenomes/SaltPond/SP400CM_CTCTCTAC-TCGACTAG_L001_R2_001.fastq.gz \
  --out1 SP_400cm_R1.qcd.fastq.gz --out2 SP_400cm_R2.qcd.fastq.gz \
  --detect_adapter_for_pe  --cut_tail --cut_tail_window_size 15 \
  --cut_tail_mean_quality 25 -h SaltPond_400_qcd.html &

```

### Interleave

~/md2021/code/reformat-fastq.sh ~/md2021/data/metagenomes/SaltPond/SP_350cm_R1.qcd.fastq.gz ~/md2021/data/metagenomes/SaltPond/SP_350cm_R2.qcd.fastq.gz SP_350cm.qcd.fastq.gz &

~/md2021/code/reformat-fastq.sh ~/md2021/data/metagenomes/SaltPond/SP_375cm_R1.qcd.fastq.gz ~/md2021/data/metagenomes/SaltPond/SP_375cm_R2.qcd.fastq.gz SP_375cm.qcd.fastq.gz &

~/md2021/code/reformat-fastq.sh ~/md2021/data/metagenomes/SaltPond/SP_400cm_R1.qcd.fastq.gz ~/md2021/data/metagenomes/SaltPond/SP_400cm_R2.qcd.fastq.gz SP_400cm.qcd.fastq.gz &

### Assembly with metaSpades


```

SPADESPATH=/opt/bifxapps/SPAdes-3.13.1/bin/

nohup $SPADESPATH/spades.py -t 20 -m 800 --meta -k 21,33,55,77,99,127 -1 /home/GLBRCORG/trina.mcmahon/md2021/data/metagenomes/SaltPond/SP_350cm_R1.qcd.fastq.gz -2 /home/GLBRCORG/trina.mcmahon/md2021/data/metagenomes/SaltPond/SP_350cm_R2.qcd.fastq.gz -o SP_350cm &

nohup $SPADESPATH/spades.py -t 20 -m 800 --meta -k 21,33,55,77,99,127 -1 /home/GLBRCORG/trina.mcmahon/md2021/data/metagenomes/SaltPond/SP_375cm_R1.qcd.fastq.gz -2 /home/GLBRCORG/trina.mcmahon/md2021/data/metagenomes/SaltPond/SP_375cm_R2.qcd.fastq.gz -o SP_400cm &

nohup $SPADESPATH/spades.py -t 20 -m 800 --meta -k 21,33,55,77,99,127 -1 /home/GLBRCORG/trina.mcmahon/md2021/data/metagenomes/SaltPond/SP_375cm_R1.qcd.fastq.gz -2 /home/GLBRCORG/trina.mcmahon/md2021/data/metagenomes/SaltPond/SP_375cm_R2.qcd.fastq.gz -o SP_400cm &

```

### Mapping with bbmap

```
BBPATH=/opt/bifxapps/bbmap-38.32

$BBPATH/bbmap.sh ref=/home/GLBRCORG/trina.mcmahon/md2021/analysis/SaltPond/assembly/SP_350cm_scaffolds.fasta in=/home/GLBRCORG/trina.mcmahon/md2021/data/metagenomes/SaltPond/SP_350cm.qcd.fastq.gz outm=SP_350cm_mapping.bam idtag minid=0.95 nodisk -Xmx100g &

$BBPATH/bbmap.sh ref=/home/GLBRCORG/trina.mcmahon/md2021/analysis/SaltPond/assembly/SP_375cm_scaffolds.fasta in=/home/GLBRCORG/trina.mcmahon/md2021/data/metagenomes/SaltPond/SP_375cm.qcd.fastq.gz outm=SP_375cm_mapping.bam idtag minid=0.95 nodisk -Xmx80g &

$BBPATH/bbmap.sh ref=/home/GLBRCORG/trina.mcmahon/md2021/analysis/SaltPond/assembly/SP_400cm_scaffolds.fasta in=/home/GLBRCORG/trina.mcmahon/md2021/data/metagenomes/SaltPond/SP_400cm.qcd.fastq.gz outm=SP_400cm_mapping.bam idtag minid=0.95 nodisk -Xmx100g &

source /home/GLBRCORG/trina.mcmahon/miniconda3/etc/profile.d/conda.sh
PYTHONPATH=""

conda activate bioinformatics

samtools sort SP_350cm_mapping.bam -o SP_350cm_mapping.sorted.bam &

samtools sort SP_375cm_mapping.bam -o SP_375cm_mapping.sorted.bam &

samtools sort SP_400cm_mapping.bam -o SP_400cm_mapping.sorted.bam &

```

###  Binning with metabat

```
/opt/bifxapps/metabat-2.12.1/jgi_summarize_bam_contig_depths --outputDepth SP_350cm_depth.txt SP_350cm_mapping.sorted.bam

/opt/bifxapps/metabat-2.12.1/metabat2 -i /home/GLBRCORG/trina.mcmahon/md2021/analysis/SaltPond/assembly/SP_350cm_scaffolds.fasta -a SP_350cm_depth.txt --unbinned -o SP_350cm_bins/bin &


for file in bin*
  do
    mv $file SP_350cm_$file
  done


/opt/bifxapps/metabat-2.12.1/jgi_summarize_bam_contig_depths --outputDepth SP_375cm_depth.txt SP_375cm_mapping.sorted.bam

/opt/bifxapps/metabat-2.12.1/metabat2 -i /home/GLBRCORG/trina.mcmahon/md2021/analysis/SaltPond/assembly/SP_375cm_scaffolds.fasta -a SP_375cm_depth.txt --unbinned -o SP_375cm_bins/bin &


for file in bin*
  do
    mv $file SP_375cm_$file
  done


/opt/bifxapps/metabat-2.12.1/jgi_summarize_bam_contig_depths --outputDepth SP_400cm_depth.txt SP_400cm_mapping.sorted.bam &

/opt/bifxapps/metabat-2.12.1/metabat2 -i /home/GLBRCORG/trina.mcmahon/md2021/analysis/SaltPond/assembly/SP_400cm_scaffolds.fasta -a SP_400cm_depth.txt --unbinned -o SP_400cm_bins/bin &


for file in bin*
  do
    mv $file SP_400cm_$file
  done

  ```

Number of bins:

350cm 66 bins
375cm 47 bins
400cm


### CheckM on them

```
source /home/GLBRCORG/trina.mcmahon/miniconda3/etc/profile.d/conda.sh
conda activate bioinformatics
PYTHONPATH=''

checkm lineage_wf \
        -t 25 \
        -x fa \
        /home/GLBRCORG/trina.mcmahon/md2021/analysis/SaltPond/mapping/SP_350cm_bins \
        checkM &

checkm qa \
        checkM/lineage.ms \
        checkM \
        -o 2 \
        -f checkM/checkm.out \
        --tab_table

awk -F '\t' -v OFS='\t' '{ print $1,$6,$7,$9,$11,$13,$15,$17,$19,$23 }' checkM/checkm.out > SP_350cm_checkm_stats.tsv




checkm lineage_wf \
        -t 25 \
        -x fa \
        /home/GLBRCORG/trina.mcmahon/md2021/analysis/SaltPond/mapping/SP_375cm_bins \
        checkM &

checkm qa \
        checkM/lineage.ms \
        checkM \
        -o 2 \
        -f checkM/checkm.out \
        --tab_table

awk -F '\t' -v OFS='\t' '{ print $1,$6,$7,$9,$11,$13,$15,$17,$19,$23 }' checkM/checkm.out > SP_375cm_checkm_stats.tsv



checkm lineage_wf \
        -t 25 \
        -x fa \
        /home/GLBRCORG/trina.mcmahon/md2021/analysis/SaltPond/mapping/SP_400cm_bins \
        checkM &

checkm qa \
        checkM/lineage.ms \
        checkM \
        -o 2 \
        -f checkM/checkm.out \
        --tab_table

awk -F '\t' -v OFS='\t' '{ print $1,$6,$7,$9,$11,$13,$15,$17,$19,$23 }' checkM/checkm.out > SP_400cm_checkm_stats.tsv

```

### Classifying with gtdbtk

```
source /home/GLBRCORG/trina.mcmahon/miniconda3/etc/profile.d/conda.sh
unset PYTHONPATH
conda activate gtdbtk-1.4.1

cd /home/GLBRCORG/trina.mcmahon/md2021/analysis/SaltPond/mapping

gtdbtk classify_wf \
        --cpus 20 \
        --extension fa \
        --genome_dir /home/GLBRCORG/trina.mcmahon/md2021/analysis/SaltPond/mapping/SP_350cm_bins \
        --out_dir taxonomy &


gtdbtk classify_wf \
        --cpus 20 \
        --extension fa \
        --genome_dir /home/GLBRCORG/trina.mcmahon/md2021/analysis/SaltPond/mapping/SP_375cm_bins \
        --out_dir taxonomy_375 &


```

###  Calculating coverage with coverM

First need to change fasta names
