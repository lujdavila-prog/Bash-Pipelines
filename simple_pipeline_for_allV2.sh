#!/bin/bash
if [ "$CONDA_DEFAULT_ENV" == "staph_env" ]; then 
echo "In correct environment, proceeding." 
else 
echo "Incorrect environment" 
exit 1
fi

set -e
set -o pipefail

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
NEW_DIR=~/Documents/SRRtest/"${SAMPLE}"
mkdir -p "$NEW_DIR"

#bwa creating/finding index
if [ -f "${REFERENCE_GENOME}.bwt" ]; then
    echo "Index for ${REFERENCE_GENOME} already exists, mapping will begin"
else    
    bwa index "${REFERENCE_GENOME}"
fi

#cleaning with fastp
fastp -i "${INPUT_FASTQ}" -o "$NEW_DIR"/"${SAMPLE}".fastq.gz -h "$NEW_DIR"/"${SAMPLE}".html -j "$NEW_DIR"/"${SAMPLE}".json

#mapping/aligning | sorting 
bwa mem -t 4 "${REFERENCE_GENOME}" "$NEW_DIR"/"${SAMPLE}".fastq.gz | samtools sort -o "$NEW_DIR"/"${SAMPLE}".bam -

#index bai
samtools index "$NEW_DIR"/"${SAMPLE}".bam

#Checker
samtools flagstat "$NEW_DIR"/"${SAMPLE}".bam