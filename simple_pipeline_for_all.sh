#!/bin/bash
set -e

#input file directory
echo "Submit FULL PATH to fastq file:"
read -r INPUT_FASTQ

#input genome reference
echo "Submit FULL PATH to reference genome (.fna):"
read -r REFERENCE_GENOME

#sample name
echo "enter name for sample"
read -r SAMPLE

#AUTOMATAION

#cleaning with fastp
fastp -i "${INPUT_FASTQ}" -o ~/Documents/SRRtest/"${SAMPLE}".fastq.gz -h ~/Documents/SRRtest/"${SAMPLE}".html -j ~/Documents/SRRtest/"${SAMPLE}".json

#bwa creating index
bwa index "${REFERENCE_GENOME}"

#mapping/aligning 
bwa mem -t 4 "${REFERENCE_GENOME}" ~/Documents/SRRtest/"${SAMPLE}".fastq.gz > ~/Documents/SRRtest/"${SAMPLE}".sam

#Sort with samtools
samtools view -S -b ~/Documents/SRRtest/"${SAMPLE}".sam | samtools sort -o ~/Documents/SRRtest/"${SAMPLE}".bam
samtools index ~/Documents/SRRtest/"${SAMPLE}".bam

#deleting .sam file
rm -f ~/Documents/SRRtest/"${SAMPLE}".sam

#Checker
samtools flagstat ~/Documents/SRRtest/"${SAMPLE}".bam
