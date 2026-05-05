#!/bin/bash
#SBATCH --job-name=sra_download
#SBATCH --partition=cpu
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=16G
#SBATCH --time=24:00:00
#SBATCH --output=/lustre/home/galanllarimm/bios668/final_project/download_%j.out
#SBATCH --error=/lustre/home/galanllarimm/bios668/final_project/download_%j.err
#SBATCH --mail-type=END,FAIL
#SBATCH --mail-user=galanllarimm@vcu.edu

module load miniforge3
conda activate sra

WORKDIR="/lustre/home/galanllarimm/bios668/final_project"
FASTQ_DIR="${WORKDIR}/raw_fastq"
CACHE="${WORKDIR}/prefetch_cache"

mkdir -p ${FASTQ_DIR}/AUD_Sample46
mkdir -p ${FASTQ_DIR}/Control_Sample50
mkdir -p ${CACHE}

# Download AUD_Sample46 (2 runs: SRR26780653 + SRR26780654)
echo "===== Downloading AUD_Sample46 ====="
for SRR in SRR26780653 SRR26780654; do
    echo "  Prefetching ${SRR}..."
    prefetch ${SRR} --output-directory ${CACHE}
    echo "  Converting ${SRR} to FASTQ..."
    fasterq-dump ${CACHE}/${SRR}/${SRR}.sra \
        --outdir ${FASTQ_DIR}/AUD_Sample46 \
        --split-3 \
        --threads 8 \
        --progress
done

# Download Control_Sample50 (2 runs: SRR26780506+ SRR26780507)
echo "===== Downloading Control_Sample50 ====="
for SRR in SRR26780506 SRR26780507; do
    echo "  Prefetching ${SRR}..."
    prefetch ${SRR} --output-directory ${CACHE}
    echo "  Converting ${SRR} to FASTQ..."
    fasterq-dump ${CACHE}/${SRR}/${SRR}.sra \
        --outdir ${FASTQ_DIR}/Control_Sample50 \
        --split-3 \
        --threads 8 \
        --progress
done

# Compress
echo "===== Compressing ====="
gzip ${FASTQ_DIR}/AUD_Sample46/*.fastq
gzip ${FASTQ_DIR}/Control_Sample50/*.fastq

# Rename to CellRanger-compatible format
echo "===== Renaming for CellRanger ====="
mv ${FASTQ_DIR}/AUD_Sample46/SRR26780653_1.fastq.gz \
   ${FASTQ_DIR}/AUD_Sample46/AUD_S1_L001_R1_001.fastq.gz
mv ${FASTQ_DIR}/AUD_Sample46/SRR26780653_2.fastq.gz \
   ${FASTQ_DIR}/AUD_Sample46/AUD_S1_L001_R2_001.fastq.gz
mv ${FASTQ_DIR}/AUD_Sample46/SRR26780654_1.fastq.gz \
   ${FASTQ_DIR}/AUD_Sample46/AUD_S1_L002_R1_001.fastq.gz
mv ${FASTQ_DIR}/AUD_Sample46/SRR26780654_2.fastq.gz \
   ${FASTQ_DIR}/AUD_Sample46/AUD_S1_L002_R2_001.fastq.gz

mv ${FASTQ_DIR}/Control_Sample50/SRR26780506_1.fastq.gz \
   ${FASTQ_DIR}/Control_Sample50/Control_S1_L001_R1_001.fastq.gz
mv ${FASTQ_DIR}/Control_Sample50/SRR26780506_2.fastq.gz \
   ${FASTQ_DIR}/Control_Sample50/Control_S1_L001_R2_001.fastq.gz
mv ${FASTQ_DIR}/Control_Sample50/SRR26780507_1.fastq.gz \
   ${FASTQ_DIR}/Control_Sample50/Control_S1_L002_R1_001.fastq.gz
mv ${FASTQ_DIR}/Control_Sample50/SRR26780507_2.fastq.gz \
   ${FASTQ_DIR}/Control_Sample50/Control_S1_L002_R2_001.fastq.gz

echo "===== DONE ====="
