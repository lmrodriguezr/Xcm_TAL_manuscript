#!/bin/bash

#$ -q std.q
#$ -N Xcitri_Download
#$ -cwd
#$ -l h_rt=48:00:00
#$ -l h_vmem=0.5G

. ~/.miga_rc

echo "===[ Downloading Xanthomonas citri ]==="
export NCBI_API_KEY="XXXXX" # Secret API Key removed!
miga new -P "Xcitri" -t genomes
miga ncbi_get -P "Xcitri" -T "Xanthomonas citri" --all -v

