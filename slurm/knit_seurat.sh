#!/bin/bash
#SBATCH --job-name=seurat_knit
#SBATCH --partition=cpu
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=64G
#SBATCH --time=04:00:00
#SBATCH --output=/lustre/home/galanllarimm/bios668/final_project/seurat_%j.out
#SBATCH --error=/lustre/home/galanllarimm/bios668/final_project/seurat_%j.err
#SBATCH --mail-type=END,FAIL
#SBATCH --mail-user=galanllarimm@vcu.edu

module load R/4.4.1

DISPLAY="" Rscript -e "rmarkdown::render('/lustre/home/galanllarimm/bios668/final_project/final_project_seurat.Rmd', output_file='/lustre/home/galanllarimm/bios668/final_project/final_project_seurat.html')"

echo "Done!"
