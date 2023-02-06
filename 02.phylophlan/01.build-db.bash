#!/bin/bash

PROJ="../../Xcitri"

# Get all proteins
. ~/.bashrc
load_miga
k=0
for i in $(miga ls -P "$PROJ") ; do
  gzip -cd "$PROJ/data/06.cds/${i}.faa.gz" \
    | FastA.tag.rb -i /dev/stdin -o /dev/stdout -p $k-
  let k=$k+1
done | tee > xcm.faa

# Cluster proteins
load_mmseqs2
mmseqs easy-linclust xcm.faa xcm_clust xcm_tmp
rm -rf xcm_tmp/

# Build amino acid database for Phylophlan
load_miga
perl -pe 's/-\d+$//' < xcm_clust_cluster.tsv \
  | sort | uniq | cut -f 1 | uniq -c \
  | awk '$1 >= 10 { print $2 }' \
  > xcm_10_or_more.txt
FastA.filter.pl xcm_10_or_more.txt xcm.faa > xcm_10_or_more.faa
phylophlan_setup_database -i xcm_10_or_more.faa -o xcm_aa -d xcm_aa -t a

# Get all gene sequences
k=0
for i in $(miga ls -P "$PROJ") ; do
  gzip -cd "$PROJ/data/06.cds/${i}.fna.gz" \
    | FastA.tag.rb -i /dev/stdin -o /dev/stdout -p $k-
  let k=$k+1
done | tee > xcm.fna

# Extract the corresponding genes and create nucleotide database
FastA.filter.pl xcm_10_or_more.txt xcm.fna > xcm_10_or_more.fna
phylophlan_setup_database -i xcm_10_or_more.fna -o xcm_nt -d xcm_nt -t n

