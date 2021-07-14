###  Isolate genomes

Looking at Patrick's isolate genomes from 2018 on the course share

md/MicDiv_2019/Bioinformatics_Server/Patrick_2018_genome_assemblies/

Copied the fastas from inside the folders. I think this will be best way to name them and then send them thru GTDBtk

97 files

Renamed

They are here:



```
condor_submit --interactive classify_job.submit

source /home/GLBRCORG/trina.mcmahon/miniconda3/etc/profile.d/conda.sh
unset PYTHONPATH
conda activate gtdbtk-1.4.1

nohup gtdbtk classify_wf \
        --cpus 20 \
        --extension fasta \
        --genome_dir ~/md2021/data/IsolateGenomes \
        --out_dir taxonomy &

```

Run CheckM


Looking for some Chlorobi

These are isolates that Patrick assembled from above:

51_no
52_no
NH9_no
Prosthecochloris_scaffolds

These are the ones in the metadata sheets


2018.EC.10.07.04	2018.5.Group2.ST.1	Sarah Tucker	Chlorobi	Trunk River
2018.EC.10.07.04	2018.5.Group2.ST.2	Sarah Tucker	Chlorobi	Trunk River
2018.EC.10.07.04	2018.5.Group2.ST.3	Sarah Tucker	Chlorobi	Trunk River
