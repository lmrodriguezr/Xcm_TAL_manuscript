#!/bin/bash

#$ -q bigmem.q
#$ -N Phylophlan_Xcitri_nt
#$ -cwd
#$ -l h_rt=72:00:00
#$ -l h_vmem=6G
#$ -pe openmp 20

. ~/.bashrc
load_phylophlan

phylophlan_write_config_file \
  -d n -o xcitri_config_nt.cfg \
  --db_dna makeblastdb --map_dna tblastn \
  --msa mafft --trim trimal \
  --tree1 fasttree --tree2 raxml \
  --force_nucleotides --verbose --overwrite 2>&1

phylophlan --diversity low -i input_nt -o output_nt -d xcm_nt \
  -f xcitri_config_nt.cfg --nproc 8

