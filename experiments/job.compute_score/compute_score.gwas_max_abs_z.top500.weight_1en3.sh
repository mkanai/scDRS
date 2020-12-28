#!/bin/bash
#SBATCH -n 1                # Number of cores (-n)
#SBATCH -N 1                # Ensure that all cores are on one Node (-N)
#SBATCH -t 0-06:00          # Runtime in D-HH:MM, minimum of 10 minutes
#SBATCH -p serial_requeue   # Partition to submit to
#SBATCH --mem=32000           # Memory pool for all cores (see also --mem-per-cpu)
#SBATCH --array=0,30           # Memory pool for all cores (see also --mem-per-cpu)
#SBATCH -o /n/home11/mjzhang/gwas_informed_scRNAseq/scTRS/experiments/job_info/job_%A_%a.out # Standard output
#SBATCH -e /n/home11/mjzhang/gwas_informed_scRNAseq/scTRS/experiments/job_info/job_%A_%a.err # Standard error

BATCH_NUM=$SLURM_ARRAY_TASK_ID
# BATCH_NUM=0
H5AD_FILE=/n/holystore01/LABS/price_lab/Users/mjzhang/scTRS_data/tabula_muris_senis/tabula-muris-senis-facs-official-raw-obj.h5ad
GS_FILE=/n/holystore01/LABS/price_lab/Users/mjzhang/scTRS_data/gs_file/gwas_max_abs_z.top500.batch$BATCH_NUM.gs
OUT_FOLDER=/n/holystore01/LABS/price_lab/Users/mjzhang/scTRS_data/score_file/score.facs.gwas_max_abs_z.top500.weight_1en3

python /n/home11/mjzhang/gwas_informed_scRNAseq/scTRS/compute_score.py \
    --h5ad_file $H5AD_FILE\
    --h5ad_species mouse\
    --gs_file $GS_FILE\
    --gs_species human\
    --out_folder $OUT_FOLDER\
    --flag_filter True\
    --flag_raw_count True\
    --flag_return_ctrl_raw_score True\
    --flag_return_ctrl_norm_score True