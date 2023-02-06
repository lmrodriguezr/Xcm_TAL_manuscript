#!/bin/bash

#$ -q bigmem.q
#$ -N Phylophlan_Xcitri_at
#$ -cwd
#$ -l h_rt=72:00:00
#$ -l h_vmem=20G
#$ -pe openmp 20

. ~/.bashrc
load_phylophlan

phylophlan_write_config_file \
  -d a -o xcitri_config_at.cfg \
  --db_aa diamond --map_dna diamond --map_aa diamond \
  --msa mafft --trim trimal \
  --tree1 astrid --tree2 raxml \
  --verbose --overwrite 2>&1

phylophlan --diversity low -i input_hr -o output_at -d xcm \
  -f xcitri_config_at.cfg --nproc 20

