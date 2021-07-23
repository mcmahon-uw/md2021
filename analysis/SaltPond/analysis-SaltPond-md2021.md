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

fastp --in1 ~/md2021/data/metagenomes/SaltPond/FILENAME \
  --in2 ~/md2021/data/metagenomes/SaltPond/FILENAME \
  --out1 SP_350cm_R1.qcd.fastq.gz --out2 SP_350cm_R2.qcd.fastq.gz \
  --detect_adapter_for_pe  --cut_tail --cut_tail_window_size 15 \
  --cut_tail_mean_quality 25 -h SaltPond_350_qcd.html &


fastp --in1 ~/md2021/data/metagenomes/SaltPond/FILENAME \
  --in2 ~/md2021/data/metagenomes/SaltPond/FILENAME \
  --out1 SP_375cm_R1.qcd.fastq.gz --out2 SP_375cm_R2.qcd.fastq.gz \
  --detect_adapter_for_pe  --cut_tail --cut_tail_window_size 15 \
  --cut_tail_mean_quality 25 -h SaltPond_375_qcd.html &


fastp --in1 ~/md2021/data/metagenomes/SaltPond/FILENAME \
  --in2 ~/md2021/data/metagenomes/SaltPond/FILENAME \
  --out1 SP_350cm_R1.qcd.fastq.gz --out2 SP_350cm_R2.qcd.fastq.gz \
  --detect_adapter_for_pe  --cut_tail --cut_tail_window_size 15 \
  --cut_tail_mean_quality 25 -h SaltPond_350_qcd.html &


fastp --in1 ~/md2021/data/metagenomes/SaltPond/FILENAME \
  --in2 ~/md2021/data/metagenomes/SaltPond/FILENAME \
  --out1 SP_400cm_R1.qcd.fastq.gz --out2 SP_400cm_R2.qcd.fastq.gz \
  --detect_adapter_for_pe  --cut_tail --cut_tail_window_size 15 \
  --cut_tail_mean_quality 25 -h SaltPond_400_qcd.html &

```
