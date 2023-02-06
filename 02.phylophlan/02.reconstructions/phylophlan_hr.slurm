#!/bin/bash

#$ -q bigmem.q
#$ -N Phylophlan_Xcitri_hr
#$ -cwd
#$ -l h_rt=72:00:00
#$ -l h_vmem=20G
#$ -pe openmp 6

. ~/.bashrc
load_phylophlan

phylophlan_write_config_file \
  -d a -o xcitri_config_hr.cfg \
  --db_aa diamond --map_dna diamond --map_aa diamond \
  --msa mafft --trim trimal \
  --tree1 fasttree --tree2 raxml \
  --verbose --overwrite 2>&1

phylophlan --diversity low -i input_hr -o output_hr -d xcm \
  -f xcitri_config_hr.cfg --nproc 6

