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
