#!/bin/bash

#$ -q std.q
#$ -N MiGA_Xcitri
#$ -cwd
#$ -l h_rt=48:00:00
#$ -l h_vmem=0.5G
#$ -pe openmpi-fillup 12-1024

awk '{ for (i = 1; i <= $2; ++i) print $1 }' < "$PE_HOSTFILE" > hosts.txt
hostname
ssh -t -t "$(hostname)" "$PWD/02.index.bash"

