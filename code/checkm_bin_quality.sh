#######################
###  Borrowed this code from Ben PEterson
###
#######################

#  Run the main code with condor interactive
#  Re-used this for multiple versionns, changing paths as needed.


cd /home/GLBRCORG/trina.mcmahon/lake-MAGs/analysis/
mkdir checkM

source /home/GLBRCORG/trina.mcmahon/miniconda3/etc/profile.d/conda.sh
conda activate bioinformatics
PYTHONPATH=''

# Run this on the original MAGsv1 (103)

checkm lineage_wf \
        -t 5 \
        -x fasta \
        ~/md2021/data/IsolateGenomes \
        checkM &

checkm qa \
        checkM/lineage.ms \
        checkM \
        -o 2 \
        -f checkM/checkm.out \
        --tab_table

awk -F '\t' -v OFS='\t' '{ print $1,$6,$7,$9,$11,$13,$15,$17,$19,$23 }' checkM/checkm.out > checkm_stats.tsv
