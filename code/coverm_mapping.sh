#! /bin/bash

## mapping to indvidiual bins stats
# queue mapping with coverM to get relative abundance
# Use MAG files that have genome name and contig number
# 1234567_contig1

source /home/GLBRCORG/trina.mcmahon/miniconda3/etc/profile.d/conda.sh
PYTHONPATH=""

conda activate CoverM

# Start with TRYSB

coverm contig \
    --reference /home/GLBRCORG/trina.mcmahon/md2021/analysis/TrunkRiver/assembly/TRYSB_2018_scaffolds.fasta \
    --interleaved /home/GLBRCORG/trina.mcmahon/md2021/data/metagenomes/TrunkRiver/TRYSB_2018.qcd.fastq.gz \
    --bam-file-cache-directory bam_cache \
    --min-read-aligned-percent 0.75 \
    --min-read-percent-identity 0.95 \
    --min-covered-fraction 0 \
    -t 20 > mean_covg_output.txt &

# Next baby_lem bins

coverm contig \
    --reference /home/GLBRCORG/trina.mcmahon/md2021/analysis/TrunkRiver/mapping/coverM/baby_lem_bins_concat.fasta \
    --interleaved /home/GLBRCORG/trina.mcmahon/md2021/data/metagenomes/TrunkRiver/baby_lem_2018.qcd.fastq.gz \
    --bam-file-cache-directory bam_cache \
    --min-read-aligned-percent 0.75 \
    --min-read-percent-identity 0.95 \
    --min-covered-fraction 0 \
    -t 28 > baby_lem_bins_mean_covg_output.txt &

mmm

coverm genome \
    --reference /home/GLBRCORG/trina.mcmahon/md2021/analysis/TrunkRiver/mapping/coverM/baby_lem_bins_concat.fna \
    -s "~" \
    -m relative_abundance \
    --interleaved /home/GLBRCORG/trina.mcmahon/md2021/data/metagenomes/TrunkRiver/baby_lem_2018.qcd.fastq.gz \
    --bam-file-cache-directory bam_cache \
    --min-read-aligned-percent 0.75 \
    --min-read-percent-identity 0.95 \
    --min-covered-fraction 0 \
    -t 28 > baby_lem_bins_relabun_output.txt &

    coverm genome \
        --reference /home/GLBRCORG/trina.mcmahon/md2021/analysis/TrunkRiver/mapping/coverM/baby_lem_bins_concat.fna \
        -s "~" \
        -m mean \
        --interleaved /home/GLBRCORG/trina.mcmahon/md2021/data/metagenomes/TrunkRiver/baby_lem_2018.qcd.fastq.gz \
        --bam-file-cache-directory bam_cache \
        --min-read-aligned-percent 0.75 \
        --min-read-percent-identity 0.95 \
        --min-covered-fraction 0 \
        -t 28 > baby_lem_bins_mean_covg_output.txt &


## baby_lem bins but with relaxed ANI cutoff

coverm genome \
    --reference /home/GLBRCORG/trina.mcmahon/md2021/analysis/TrunkRiver/mapping/coverM/baby_lem_bins_concat.fna \
    -s "~" \
    -m relative_abundance \
    --interleaved /home/GLBRCORG/trina.mcmahon/md2021/data/metagenomes/TrunkRiver/baby_lem_2018.qcd.fastq.gz \
    --bam-file-cache-directory bam_cache \
    --min-read-aligned-percent 0.75 \
    --min-read-percent-identity 0.85 \
    --min-covered-fraction 0 \
    -t 28 > baby_lem_bins_85_relabun_output.txt &

## baby_lem assembly

coverm contig \
    --reference /home/GLBRCORG/trina.mcmahon/md2021/analysis/TrunkRiver/mapping/baby_lem_2018_scaffolds.fasta \
    --interleaved /home/GLBRCORG/trina.mcmahon/md2021/data/metagenomes/TrunkRiver/baby_lem_2018.qcd.fastq.gz \
    --bam-file-cache-directory bam_cache \
    --min-read-aligned-percent 0.75 \
    --min-read-percent-identity 0.95 \
    --min-covered-fraction 0 \
    -t 28 > baby_lem_assembly_mean_covg_output.txt &



coverm genome \
    -f /home/GLBRCORG/trina.mcmahon/md2021/analysis/TrunkRiver/mapping/baby_lem_2018_scaffolds.fasta \
    -m relative_abundance \
    --interleaved /home/GLBRCORG/trina.mcmahon/md2021/data/metagenomes/TrunkRiver/baby_lem_2018.qcd.fastq.gz \
    --bam-file-cache-directory bam_cache \
    --min-read-aligned-percent 0.75 \
    --min-read-percent-identity 0.95 \
    --min-covered-fraction 0 \
    -t 28 > baby_lem_assembly_relabun_output.txt &


### Unbinned contigs from baby_lem

coverm contig \
    --reference /home/GLBRCORG/trina.mcmahon/md2021/analysis/TrunkRiver/mapping/coverM/baby_lem_2018_v2_bin.unbinned.fa \
    --interleaved /home/GLBRCORG/trina.mcmahon/md2021/data/metagenomes/TrunkRiver/baby_lem_2018.qcd.fastq.gz \
    --bam-file-cache-directory bam_cache \
    --min-read-aligned-percent 0.75 \
    --min-read-percent-identity 0.95 \
    --min-covered-fraction 0 \
    -t 28 > baby_lem_unbinned_mean_covg_output.txt &





# OLD BORROWED CODE BELOW


#  Relative abundance
#  Use concatenated genomes file please

coverm genome \
    --reference TBepi_95_MAGs_concat.fasta \
    -s "." \
    -m relative_abundance \
    --interleaved /home/GLBRCORG/trina.mcmahon/lake_data_general/TroutBog_GEODES_metaGs/*.fastq.gz  \
    --bam-file-cache-directory bam_cache \
    --min-read-aligned-percent 0.75 \
    --min-read-percent-identity 0.95 \
    --min-covered-fraction 0 \
    -x fasta -t 24 &> relative_abundance_output.txt &

#  Coverage
#  Used individual gennomes rather than concaneated here, but not sure why

coverm genome \
    --reference /home/GLBRCORG/trina.mcmahon/Cyanos/data/dereplicated_MAGs/16cyanoMAGs_edited_fasta_id/16cyano_concat.fasta \
    -s "_" \
    -m covered_fraction \
    --interleaved /home/GLBRCORG/trina.mcmahon/lake_data_general/Mendota_metaGs_renamed/*.fastq \
    --bam-file-cache-directory bam_cache \
    --min-read-aligned-percent 0.75 \
    --min-read-percent-identity 0.95 \
    --min-covered-fraction 0 \
    -x fasta -t 25 &> coverage_output.txt &

## Coverage of metatranscriptome for Trout Bog - playing around only

file1=$(cat metaTpaths_ready2.txt)
echo $file1
coverm genome \
    --reference TBepi_95_MAGs_concat.fasta \
    -s "." \
    -m covered_fraction \
    --interleaved $file1  \
    --bam-file-cache-directory bam_cache \
    --min-read-aligned-percent 0.75 \
    --min-read-percent-identity 0.95 \
    --min-covered-fraction 0 \
    -x fasta -t 24 &> coverage_output2.txt &


    coverm genome \
        --reference TBepi_95_MAGs_concat.fasta \
        -s "." \
        -m mean \
        --interleaved /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES101-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES102-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES103-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES104-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES105-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES106-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES107-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES108-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES053-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES054-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES055-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES056-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES057-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES058-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES059-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES060-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES069-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES070-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES071-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES072-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES073-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES074-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES075-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES076-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES077-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES078-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES079-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES080-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES081-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES082-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES083-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES084-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES085-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES086-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES087-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES088-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES089-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES090-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES091-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES092-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES093-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES094-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES095-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES096-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES097-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES098-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES099-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES100-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES109-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES110-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES111-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES112-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES061-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES062-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES063-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES064-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES065-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES066-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES067-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES068-nonrRNA.fastq.gz  \
        --bam-file-cache-directory bam_cache \
        --min-read-aligned-percent 0.75 \
        --min-read-percent-identity 0.95 \
        --min-covered-fraction 0 \
        -x fasta -t 24 &> mean_output.txt &

        coverm genome \
            --reference TBepi_95_MAGs_concat.fasta \
            -s "." \
            -m reads_per_base \
            --interleaved /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES101-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES102-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES103-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES104-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES105-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES106-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES107-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES108-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES053-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES054-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES055-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES056-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES057-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES058-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES059-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES060-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES069-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES070-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES071-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES072-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES073-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES074-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES075-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES076-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES077-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES078-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES079-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES080-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES081-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES082-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES083-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES084-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES085-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES086-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES087-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES088-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES089-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES090-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES091-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES092-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES093-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES094-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES095-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES096-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES097-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES098-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES099-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES100-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES109-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES110-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES111-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES112-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES061-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES062-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES063-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES064-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES065-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES066-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES067-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES068-nonrRNA.fastq.gz  \
            --bam-file-cache-directory bam_cache \
            --min-read-aligned-percent 0.75 \
            --min-read-percent-identity 0.95 \
            --min-covered-fraction 0 \
            -x fasta -t 24 &> reads_per_base_output.txt &

coverm genome \
    --reference TBhypo_52_MAGs_concat.fasta \
    -s "_" \
    -m mean \
    --interleaved /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES101-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES102-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES103-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES104-nonrRNA.fastq.gz   \
    --bam-file-cache-directory bam_cache \
    --min-read-aligned-percent 0.75 \
    --min-read-percent-identity 0.95 \
    --min-covered-fraction 0 \
    -x fasta -t 24 &> tb_hypo_mean_output.txt &


coverm genome \
    --reference TBhypo_52_MAGs_concat.fasta \
    -s "_" \
    -m reads_per_base \
    --interleaved /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES101-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES102-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES103-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES104-nonrRNA.fastq.gz   \
    --bam-file-cache-directory bam_cache \
    --min-read-aligned-percent 0.75 \
    --min-read-percent-identity 0.95 \
    --min-covered-fraction 0 \
    -x fasta -t 24 &> tb_hypo_reads_per_base_output.txt &

### Mapping metatranscriptome for Mendota

coverm genome \
    --reference Mendota_170_gold_set.fasta \
    -s "." \
    -m mean \
    --interleaved /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES113-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES114-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES115-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES116-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES129-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES130-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES131-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES132-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES133-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES134-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES135-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES136-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES137-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES138-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES139-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES140-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES141-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES142-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES143-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES144-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES117-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES118-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES119-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES120-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES145-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES146-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES147-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES148-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES149-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES150-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES151-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES152-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES153-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES154-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES155-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES156-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES157-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES158-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES159-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES160-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES161-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES162-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES163-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES164-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES121-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES122-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES123-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES124-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES128-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES125-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES126-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES127-nonrRNA.fastq.gz   \
    --bam-file-cache-directory bam_cache \
    --min-read-aligned-percent 0.75 \
    --min-read-percent-identity 0.95 \
    --min-covered-fraction 0 \
    -x fasta -t 24 &> mendota_mean_output.txt &

### Mapping two metagenomes from GEODES for Mendota

coverm genome \
    --reference Mendota_170_gold_set.fasta \
    -s "." \
    -m mean \
    --interleaved /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/geodes_MG/GEODES117/QC_Filtered_Raw_Data/11230.7.197594.GGTAGC.filter-METAGENOME.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/geodes_MG/GEODES118/QC_Filtered_Raw_Data/11230.7.197594.ATCACG.filter-METAGENOME.fastq.gz   \
    --bam-file-cache-directory bam_cache \
    --min-read-aligned-percent 0.75 \
    --min-read-percent-identity 0.95 \
    --min-covered-fraction 0 \
    -x fasta -t 24 &> mendota_mean_output.txt &

### Mapping the metatranscriptomes for Mendota internal standard

coverm genome \
    --genome-fasta-files internal_standard/pFN18A_DNA_transcript.fna \
    -m mean \
    --interleaved /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES113-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES114-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES115-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES116-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES129-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES130-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES131-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES132-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES133-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES134-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES135-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES136-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES137-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES138-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES139-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES140-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES141-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES142-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES143-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES144-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES117-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES118-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES119-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES120-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES145-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES146-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES147-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES148-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES149-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES150-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES151-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES152-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES153-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES154-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES155-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES156-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES157-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES158-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES159-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES160-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES161-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES162-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES163-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES164-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES121-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES122-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES123-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES124-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES128-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES125-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES126-nonrRNA.fastq.gz /mnt/bigdata/lab_data/mcmahon_lab/lakes_data/geodes/GEODES_nonrRNA/GEODES127-nonrRNA.fastq.gz   \
    --bam-file-cache-directory bam_cache \
    --min-read-aligned-percent 0.75 \
    --min-read-percent-identity 0.95 \
    --min-covered-fraction 0 \
    -x fna -t 24 &> internal_standard_mean_output.txt &
