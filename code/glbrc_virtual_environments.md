
This workflow was originally created by Ben Peterson but Trina is
modifying it.

*Bioinformatics programs*

A little worried these might have some conflicts within them so I made another smaller one (scroll down)
List of programs and their versions within the bioinformatics virtual environment:

```
source /home/GLBRCORG/trina.mcmahon/miniconda3/etc/profile.d/conda.sh
PYTHONPATH=""
conda create -y -n bioinformatics python=3.6

**installed**

conda install -n bioinformatics -c bioconda checkm-genome
conda install -n bioinformatics -c anaconda nano
conda install -n bioinformatics -c bioconda fastp
conda install -n bioinformatics -c bioconda spades
conda install -n bioinformatics -c bioconda samtools

**not installed**

conda install -n bioinformatics -c bioconda fastqc
conda install -n bioinformatics hmmer
conda install -n bioinformatics -c bioconda blast

conda install -n bioinformatics -c bioconda spades
conda install -n bioinformatics -c bioconda samtools
conda install -n bioinformatics -c bioconda biopython
conda install -n bioinformatics -c bioconda perl-bioperl
conda install -n bioinformatics -c bioconda fasttree
conda install -n bioinformatics -c bioconda raxml
conda install -n bioinformatics -c bioconda pplacer
conda install -n bioinformatics -c bioconda prodigal
conda install -n bioinformatics -c bioconda bowtie2
conda install -n bioinformatics -c bioconda samtools
conda install -n bioinformatics -c bioconda megahit
conda install -n bioinformatics pandas
conda install -n bioinformatics -c anaconda nano
conda install -n bioinformatics -c bioconda maxbin2
conda install -n bioinformatics -c bioconda metabat2
conda install -n bioinformatics -c bioconda cd-hit
conda install -n bioinformatics -c bioconda kaiju
conda install -n bioinformatics -c bioconda pyani
conda install -n bioinformatics -c bioconda seqkit
conda install -n bioinformatics -c conda-forge -c bioconda prokka
conda install -n bioinformatics -c bioconda mummer
conda install -n bioinformatics -c bioconda bbmap
conda install -n bioinformatics -c bioconda sortmerna


# conda install -n bioinformatics -c conda-forge -c bioconda -c defaults prokka

```
*Binning and mapping only*

Note that bbtools includes samtools

```
source /home/GLBRCORG/trina.mcmahon/miniconda3/etc/profile.d/conda.sh
PYTHONPATH=""
conda create -y -n mappingbinning python=3.6

conda install -n mappingbinning -c agbiome bbtools
conda install -n mappingbinning -c bioconda metabat2
conda install -n mappingbinning -c bioconda samtools
conda Install -n mappingbinning -c bioconda metabat

```

*Install CoverM separately just in case*

conda create -y -n CoverM python=3.6
conda install -n CoverM -c bioconda coverm


*Install kaiju database*

```
source /home/GLBRCORG/trina.mcmahon/miniconda3/etc/profile.d/conda.sh
conda activate bioinformatics
PERL5LIB=""
PYTHONPATH=""

cd ~/references
mkdir kaiju_db
cd kaiju_db

kaiju-makedb -s nr

```


```
mkdir ~/references/checkM
cd ~/references/checkM

curl -L -O curl -L -O https://data.ace.uq.edu.au/public/CheckM_databases/checkm_data_2015_01_16.tar.gz
tar xzf checkm_data_2015_01_16.tar.gz

source /home/GLBRCORG/trina.mcmahon/miniconda3/etc/profile.d/conda.sh
conda activate bioinformatics
PYTHONPATH=''

checkm data setRoot .
```

The lftp program did not seem to be happy with the python installation.
So, I just made a separate virtual environment for it.

```
source /home/GLBRCORG/trina.mcmahon/miniconda3/etc/profile.d/conda.sh

conda create -y -n lftp
conda install -n lftp -c conda-forge lftp

```

Need a separate venv for EMIRGE, since it wants python 2.7:

```
source /home/GLBRCORG/trina.mcmahon/miniconda3/etc/profile.d/conda.sh

conda create -y --name emirge python=2.7
conda install -n emirge -c bioconda emirge
```

Also need to install an SSU database:

```
source /home/GLBRCORG/trina.mcmahon/miniconda3/etc/profile.d/conda.sh

conda activate emirge
PYTHONPATH=’’

vim /home/GLBRCORG/trina.mcmahon/miniconda3/envs/emirge/bin/emirge_makedb.py

# Change    "SSU": "SILVA_{rel}_SSURef_Nr99_tax_silva_trunc.fasta.gz",
# to        "SSU": "SILVA_{rel}_SSURef_NR99_tax_silva_trunc.fasta.gz",
# And change        "LSU": "SILVA_{rel}_LSURef_tax_silva_trunc.fasta.gz",
# to                "LSU": "SILVA_{rel}_LSURef_tax_silva_trunc.fasta.gz",

cd ~/references/emirge_db
emirge_makedb.py -p 5
```




*py_viz*

We'll also want to build this on the GLBRC servers, both for the py_viz part but also for using py3 with the needed packages.
We'll also add in hmmer here, since it seems it will be compatible.

```
source /home/GLBRCORG/trina.mcmahon/miniconda3/etc/profile.d/conda.sh

conda create --name py_viz python=3.7

conda install -n py_viz matplotlib
conda install -n py_viz pandas
conda install -n py_viz -c bioconda gffutils
conda install -n py_viz -c anaconda argparse
conda install -n py_viz biopython


conda install -n py_viz hmmer

```
