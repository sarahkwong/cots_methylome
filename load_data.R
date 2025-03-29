library(tidyverse)

# Adjust `num` to match the appropriate sample name
for (num in c("01", "02", "03")) {
  
  df <-
    
    read_tsv(
      paste0("../data/raw/sample", num, ".bed"),      
      col_select = c(1, 2, 3, 10),
      col_names = FALSE
    ) %>% 
    
    separate(
      "X10",
      into = c("cov", "frac_mod", "n_mod", "n_can", "n_othermod", "n_del", "n_fail", "n_diff", "n_nocall"),
      sep = " "
    ) %>% 
    
    dplyr::rename("seqid" = X1, "start" = X2, "end" = X3) %>% 
    
    mutate(across(2:12, as.numeric))
  
  assign(paste0("sample", num), df)
  
}

sample_list <- mget(paste0("barcode0", 1:3))