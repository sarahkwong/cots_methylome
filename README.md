# **Workflow Guide for Methylome Profiling using Oxford Nanopore Technology (ONT)**  

This repository contains bioinformatic scripts for processing Oxford Nanopore sequencing data, covering basecalling and methylation analysis. The workflow is designed to generate a comprehensive methylome profile from raw sequencing reads.

### Citation 
Kwong, S. L. T., Budd, M., Hung, J., Villacorta-Rath, C., & Uthicke, S. (manuscript under review) *Methylome profiling of a deuterostome invertebrate using Oxford Nanopore Technology (ONT).*  

---

## **1. Post-hoc canonical and modified (5mC) basecalling**  
 
Raw Nanopore Fast5 files are converted into modbam files containing both canonical and 5mC modified basecalls. The super-accurate (SUP) model is used to ensure low error rate. Using a GPU-supported system is highly recommended, as it significantly reduces processing time.

- **Script:** `basecall.sh`
- **Software:** Guppy v6.5.7 (GPU version) 
- **Input:** Fast5 files  
- **Output:** modbam files (BAM format with methylation annotations)  

## **2.  Convert modbam to bedMethyl**  

Methylation data is extracted from modbam files and converted into a bedMethyl format for downstream analysis compatibility.

- **Script:** `modkit.sh`
- **Software:** Modkit v0.2.1 
- **Input:** modbam files  
- **Output:** bedMethyl (methylation scores per CpG sites)

## **3. Methylome Analyses**  

### **3.1 Load data**

Extract, clean, and merge methylation data from bedMethyl files across all samples to prepare for downstream analysis.

- **Script:** `load_data.R`

### **3.2 Circos Plot**  

Generate a Circos plot to visualize overall methylation patterns.

- **Script:** `circos.md`
- **Software:** Circos v0.69-9
  
### **3.3 Correlation Analysis**  

Correlation between specimens is assessed by methylation distribution profiles, pairwise Pearson’s correlation coefficients, and correlation plots.

- **Script:** `correlation.R`
- **Package:** methylKit v1.28.0

### **3.4 Cross-taxa comparison**

Construct phylogenetic tree to illustrate evolutionary relationships and place the CoTS methylome in a broader context.

- **Script:** `cross_taxa.R`
- **Package:** TToL5

### **3.5 Identification of methylation targets**  

Genomic regions are defined based on the NCBI RefSeq annotation of the CoTS genome to identify primary targets of methylation. This classification helps distinguish methylation patterns across exons, introns, promoters, and intergenic regions.

- **Script:** `meth_target.R`
- **Package:** GenomicRanges v1.54.1

### **3.6 Gene body methylation profiling**  

Methylation levels are analyzed across gene bodies and their 2 kbp flanking regions using the plotProfile function in deepTools2, providing a visual representation of methylation distribution and potential regulatory patterns.

- **Script:** `gene_body_profile.md`
- **Package:** deepTools2
