library(tidyverse)
library(GenomicRanges)

# Load gff3 (general feature format; tsv describing genomic features)
gff <-
  
  read_tsv("../reference_genome/GCF_001949145.1_OKI-Apl_1.0_genomic.sorted.gff",
           comment = "#",
           col_select = c(1, 3, 4, 5, 7),
           col_name = FALSE) %>% 
  
  dplyr::rename("seqid" = X1, "type" = X3, "start" = X4, "end" = X5, "strand" = X7)

# Function to process different genomic regions
process_region <- function(region_type, barcode_list, gff) {
  
  # Define genomic ranges based on region type
  region_gr <- switch(region_type,
                      "exon" = as(gff %>% filter(type == "exon") %>% select(seqid, start, end), "GRanges"),
                      
                      "intron" = setdiff(
                        as(gff %>% filter(type == "gene") %>% select(seqid, start, end), "GRanges") %>% reduce(),
                        as(gff %>% filter(type == "exon") %>% select(seqid, start, end), "GRanges") %>% reduce()
                      ),
                      
                      "promoter" = setdiff(
                        flank(as(gff %>% filter(type == "gene") %>% select(seqid, start, end, strand), "GRanges"), 2000),
                        as(gff %>% filter(type == "gene") %>% select(seqid, start, end), "GRanges"),
                        ignore.strand = TRUE
                      ),
                      
                      "intergene" = {
                        intergene_gr <- setdiff(
                          as(gff %>% filter(type == "gene") %>% select(seqid, start, end), "GRanges"),
                          as(gff %>% filter(type == "exon") %>% select(seqid, start, end), "GRanges")
                        )
                        setdiff(
                          intergene_gr,
                          flank(as(gff %>% filter(type == "gene") %>% select(seqid, start, end, strand), "GRanges"), 2000),
                          ignore.strand = TRUE
                        )
                      })
  
  # Initialize an empty tibble
  region_data <- tibble()
  
  # Iterate through each sample in the list
  for (i in seq_along(sample_list)) {
    df <- sample_list[[i]]
    name <- names(sample_list)[i]
    
    # Find overlaps and summarize methylation data
    region_data <- bind_rows(region_data,
                             subsetByOverlaps(as(df %>% mutate(start = end), "GRanges"), region_gr) %>%
                               as_tibble() %>%
                               mutate(n_can = as.numeric(n_can)) %>%
                               summarise(
                                 barcode = name,
                                 cpg_count = n(),
                                 meth_cpg = sum(frac_mod > 0),
                                 total_n_mod = sum(n_mod),
                                 avg_frac_mod = mean(frac_mod),
                                 n_mod_ratio = sum(n_mod) / sum(n_mod + n_can) * 100
                               )
    )
  }
  
  return(region_data)
}

# Process each region
exon_data <- process_region("exon", sample_list, gff)
intron_data <- process_region("intron", sample_list, gff)
promoter_data <- process_region("promoter", sample_list, gff)
intergene_data <- process_region("intergene", sample_list, gff)