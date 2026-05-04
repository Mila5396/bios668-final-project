#!/bin/bash
#SBATCH --job-name=knit_DE_enrichment
#SBATCH --output=/lustre/home/galanllarimm/bios668/final_project/knit_DE_enrichment_%j.out
#SBATCH --error=/lustre/home/galanllarimm/bios668/final_project/knit_DE_enrichment_%j.err
#SBATCH --time=02:00:00
#SBATCH --mem=64G
#SBATCH --cpus-per-task=4
#SBATCH --partition=cpu
#SBATCH --mail-type=END,FAIL
#SBATCH --mail-user=galanllarimm@vcu.edu

# Load R module
module load R/4.4.1

# Set personal R library path
export R_LIBS_USER=/lustre/home/galanllarimm/R/x86_64-pc-linux-gnu-library/4.4

# Move to project directory
cd /lustre/home/galanllarimm/bios668/final_project/

# Knit the Rmd
Rscript -e "
  rmarkdown::render(
    input       = 'final_project_DE_enrichment.Rmd',
    output_file = 'final_project_DE_enrichment.html',
    output_dir  = '/lustre/home/galanllarimm/bios668/final_project/'
  )
"

echo "Knitting finished at: $(date)"
