#!/bin/bash
#SBATCH --job-name=cellranger_count
#SBATCH --partition=cpu
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --mem=128G
#SBATCH --time=48:00:00
#SBATCH --output=/lustre/home/galanllarimm/bios668/final_project/cellranger_%j.out
#SBATCH --error=/lustre/home/galanllarimm/bios668/final_project/cellranger_%j.err
#SBATCH --mail-type=END,FAIL
#SBATCH --mail-user=galanllarimm@vcu.edu

module load cellranger

WORKDIR="/lustre/home/galanllarimm/bios668/final_project"
FASTQ_DIR="${WORKDIR}/raw_fastq"
REF="/lustre/home/galanllarimm/bios668/refdata-gex-GRCh38-2020-A"

# CellRanger count for AUD_Sample46
echo "===== Running CellRanger: AUD_Sample46 ====="
cellranger count \
    --id=AUD_Sample46 \
    --transcriptome=${REF} \
    --fastqs=${FASTQ_DIR}/AUD_Sample46 \
    --sample=AUD \
    --create-bam true \
    --localcores=16 \
    --localmem=120

# CellRanger count for Control_Sample50
echo "===== Running CellRanger: Control_Sample50 ====="
cellranger count \
    --id=Control_Sample50 \
    --transcriptome=${REF} \
    --fastqs=${FASTQ_DIR}/Control_Sample50 \
    --sample=Control \
    --create-bam true \
    --localcores=16 \
    --localmem=120

echo "===== DONE ====="
