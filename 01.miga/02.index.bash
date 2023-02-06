#!/bin/bash

. ~/.miga_rc
cd "$(dirname "$0")"

hostname
export MIGA_NODELIST="$(pwd)/hosts.txt"

echo "Indexing"
miga index_wf -o Xcitri -v \
  --fast --min-qual 50 --type genome \
  --threads-project 1 \
  --project-type clade \
  ../00.data/nssn-x/*flye_homopolished_rotated_corrected*.fna

