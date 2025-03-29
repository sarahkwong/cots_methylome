library(tidyverse)
library(methylKit)

# Format data for analysis
for (i in seq_along(sample_list)) {
  
  sample_list[[i]] %>%
    rename(chr = seqid, base = end, coverage = cov, freqC = frac_mod) %>% 
    mutate(strand = ".", freqT = 100 - freqC, chrBase = paste(chr, base, sep = ".")) %>% 
    select(chrBase, chr, base, strand, coverage, freqC, freqT) %>% 
    write_tsv(paste0("../data/sample", i))
  
}

# Create file_list
file_list <- list()

for (i in 1:3) {
  file_list[[i]] <- paste0("../data/sample", i)
}

# Read files to methylRawList objects, followed by unite
methylObj <-
  
  methRead(
    file_list,
    sample.id = list("1", "2", "3"),
    assembly = "1",
    treatment = c(1, 1, 1),
    context = "CpG", mincov = 5, dbtype = "tabix",
    dbdir = "../data/methylDB"
  ) %>%
  
  methylKit::unite(mc.cores = 4)

# Correlation plots
getCorrelation(methylObj, plot = TRUE)