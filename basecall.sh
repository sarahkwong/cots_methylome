#!/bin/bash
#SBATCH --ntasks=1
#SBATCH --partition=gpuq
#SBATCH --mem=500GB
#SBATCH --job-name=basecall
#SBATCH --gres=gpu:1
#SBATCH --time=100:00:00
#SBATCH --cpus-per-task=4

# load module
module load guppy

# basecall
guppy_basecaller \
--config dna_r10.4.1_e8.2_260bps_modbases_5mc_cg_sup.cfg \
--device cuda:0 \
--chunks_per_runner 512 \
--bam_out \
--index \
--enable_trim_barcodes \
--barcode_kits SQK-NBD114-24 \
--align_ref /path/to/refgenome.fna \
--recursive \
--input_path /path/to/input/directory \
--save_path /path/to/output/directory

# Use --resume to continue the run if it stops for any reasons