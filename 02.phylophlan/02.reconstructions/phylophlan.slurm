#!/bin/bash

#$ -q std.q
#$ -N Phylophlan_Xcitri
#$ -cwd
#$ -l h_rt=48:00:00
#$ -l h_vmem=2G
#$ -pe openmp 8

. ~/.bashrc
load_phylophlan

phylophlan_write_config_file \
  -d a -o xcitri_config.cfg \
  --db_aa diamond --map_dna diamond --map_aa diamond \
  --msa mafft --trim trimal \
  --tree1 fasttree --tree2 raxml \
  --verbose --overwrite 2>&1

phylophlan --diversity low -i input_og -o output_og -d phylophlan \
  -f xcitri_config.cfg --nproc 8

