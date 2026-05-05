# BIOS668 Final Project – snRNA-seq Analysis of AUD in Human dlPFC

**Author:** Milagros Galán Llario  
**Course:** BIOS668 – Bioinformatics, VCU  
**Dataset:** GSE247416 (Warden et al., Biological Psychiatry, 2026)

## Overview

Single-nucleus RNA-seq analysis of postmortem human dorsolateral prefrontal 
cortex (dlPFC) comparing one individual with Alcohol Use Disorder (AUD_Sample46) 
versus one neurotypical control (Control_Sample50). The pipeline covers raw data 
retrieval, CellRanger processing, quality control, SCTransform normalization, 
Harmony integration, clustering, cell type annotation, differential expression, 
and functional enrichment analysis.

All analysis was performed on VCU's Athena HPC cluster using R 4.4.1.

## Repository Structure

### Manuscript (root)
| File | Description |
|------|-------------|
| `manuscript.Rmd` | Final manuscript in IMRaD format — main deliverable |
| `manuscript.html` | Knitted HTML manuscript submitted to Canvas |
| `references.bib` | BibTeX reference file for manuscript |

### `script/`
| File | Description | Input | Output |
|------|-------------|-------|--------|
| `final_project_seurat.Rmd` | QC, normalization, integration, clustering and cell type annotation | CellRanger filtered matrices | `brain_final.rds` |
| `final_project_DE_enrichment.Rmd` | Differential expression and GO/KEGG enrichment analysis | `brain_final.rds` | DE and enrichment CSVs |

### `slurm/`
| File | Description |
|------|-------------|
| `cellranger_count.sh` | Run CellRanger 8.0.1 on raw FASTQs |
| `download_fastq.sh` | Download AUD sample FASTQs from SRA |
| `download_control.sh` | Download Control sample FASTQs from SRA |
| `knit_seurat.sh` | Knit `final_project_seurat.Rmd` on HPC |
| `knit_DE_enrichment.sh` | Knit `final_project_DE_enrichment.Rmd` on HPC |
| `knit_manuscript.sh` | Knit `manuscript.Rmd` on HPC |

### `results/`
| File | Description |
|------|-------------|
| `final_project_seurat.html` | Knitted HTML report of the processing pipeline |
| `final_project_DE_enrichment.html` | Knitted HTML report of the DE and enrichment analysis |

### `supplementary/`
| File | Description |
|------|-------------|
| `DE_results_top3_celltypes.csv` | Full differential expression results for oligodendrocytes, astrocytes and excitatory neurons (AUD vs Control) |
| `GO_BP_results_all.xlsx` | GO Biological Process enrichment results for all cell types and directions |
| `KEGG_results_all.xlsx` | KEGG pathway enrichment results for all cell types and directions |

## Reproducing the Analysis

1. Download raw FASTQs from GEO [GSE247416](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE247416) using `slurm/download_fastq.sh` and `slurm/download_control.sh`
2. Run CellRanger with `slurm/cellranger_count.sh`
3. Run `script/final_project_seurat.Rmd` to generate `brain_final.rds`
4. Run `script/final_project_DE_enrichment.Rmd` to generate DE and enrichment results
5. Run `manuscript.Rmd` to generate the final manuscript

## Notes

- Large files (FASTQs, `brain_final.rds`) are not included in this repository
- Raw data available at GEO: [GSE247416](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE247416)
- With n=1 sample per condition, pseudobulk DE was not applicable; 
  Wilcoxon rank-sum test was used instead (exploratory results)
