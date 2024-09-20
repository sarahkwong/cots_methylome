#!/bin/bash
#SBATCH --ntasks=1
#SBATCH --partition=cpuq
#SBATCH --mem=50GB
#SBATCH --job-name=modkit
#SBATCH --time=100:00:00
#SBATCH --cpus-per-task=4

# load module
module load samtools
module load modkit

# merge all .bam and index
samtools merge - /path/to/*.bam | samtools sort -o /path/to/merged.bam
samtools index /path/to/merged.bam

# generate bedgraph for IGV
modkit pileup --bedgraph --ref /path/to/refgenome.fna --cpg --prefix [prefix] --combine-strands /path/to/merged.bam /path/to/output/directory

# generate .bed files for analysis
modkit pileup /path/to/merged.bam /path/to/output.bed --ref /path/to/refgenome.fna --preset traditional