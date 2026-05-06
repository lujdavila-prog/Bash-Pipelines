if [ "$CONDA_DEFAULT_ENV" == "staph_env" ]; then 
echo "In correct environment, proceeding." 
else 
echo "Incorrect environment" 
exit 1
fi

set -e
set -o pipefail

#input genome reference
for REFERENCE_GENOME in *.fna; do
#bwa creating/finding index
if [ -f "${REFERENCE_GENOME}.bwt" ]; then
    echo "Index for ${REFERENCE_GENOME} already exists, mapping will begin"
else    
    bwa index "${REFERENCE_GENOME}"
fi
done


#searching for usable files 
for FILE in *.{fastq.gz,fq,fastq,fasta.gz,fa,fasta}; do
#AUTOMATAION
NEW_DIR=~/Documents/SRRtest/"${FILE}"
mkdir -p "$NEW_DIR"

if [[ "$FILE" == *.f*q* ]]; then
#cleaning with fastp
fastp -i "${FILE}" -o "$NEW_DIR"/"${FILE}".fastq.gz -h "$NEW_DIR"/"${FILE}".html -j "$NEW_DIR"/"${FILE}".json

#mapping/aligning | sorting 
bwa mem -t 4 "${REFERENCE_GENOME}" "$NEW_DIR"/"${FILE}".fastq.gz | samtools sort -o "$NEW_DIR"/"${FILE}".bam -

elif [[ "$FILE" == *.f*a ]]; then
#mapping/aligning | sorting 
bwa mem -t 4 "${REFERENCE_GENOME}" "$NEW_DIR"/"${FILE}" | samtools sort -o "$NEW_DIR"/"${FILE}".bam -
fi

#index bai
samtools index "$NEW_DIR"/"${FILE}".bam

#Checker
samtools flagstat "$NEW_DIR"/"${FILE}".bam
done
