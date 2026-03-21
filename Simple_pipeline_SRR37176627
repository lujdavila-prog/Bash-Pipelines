#!/bin/bash
set -e
#cleaning with fastp
fastp -i ~/Downloads/SRR37176627.fastq.gz -o ~/Downloads/cleaned_SRR.fastq.gz -h ~/Downloads/SRR_report.html -j ~/Downloads/SRR_report.json

#bwa creating index
bwa index ~/Downloads/reference/GCF_000005845.2_ASM584v2_genomic.fna

#mapping/aligning 
bwa mem -t 4 ~/Downloads/reference/GCF_000005845.2_ASM584v2_genomic.fna ~/Downloads/cleaned_SRR.fastq.gz > ~/Downloads/alignment.sam

#Sort with samtools
samtools view -S -b ~/Downloads/alignment.sam | samtools sort -o ~/Downloads/alignment.sorted.bam
samtools index ~/Downloads/alignment.sorted.bam

#Checker
samtools flagstat ~/Downloads/alignment.sorted.bam
