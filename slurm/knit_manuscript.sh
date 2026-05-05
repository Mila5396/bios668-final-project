#!/bin/bash
#SBATCH --job-name=knit_manuscript
#SBATCH --output=knit_manuscript_%j.log
#SBATCH --time=00:30:00
#SBATCH --mem=32G
#SBATCH --cpus-per-task=2

module load R/4.4.1

cd /lustre/home/galanllarimm/bios668/final_project/

Rscript -e "rmarkdown::render('manuscript.Rmd', output_format = 'all')"
