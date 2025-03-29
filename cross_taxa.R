library(ggpubr)
library(ape)
library(ggtree)
library(ggtreeExtra)
library(tidyverse)
library(ggtext)
library(showtext)

## read in meth data (csv containing species and genome-wide methylation levels)
meth <- read.csv("meth.csv") %>%
  group_by(common_name, scientific_name, group) %>%
  summarise(mean_meth = mean(global_meth_perc)) ## get average meth

## get list of species
meth_species <- meth %>%
  pull(scientific_name)

## export for time tree
writeLines(meth_species, "meth_species.txt")

## read in tree (exported as .nwk file)
meth_spp_tree <- read.tree("meth_species.nwk")

## replace underscores
meth_spp_tree$tip.label <- gsub("_", " ", meth_spp_tree$tip.label)

# Create the labels with common name followed by scientific name in italics in brackets
labs <- sapply(1:nrow(meth), function(i) {
  paste0("'", meth$common_name[i], "'~'('*italic('", meth$scientific_name[i], "')*')'")
})

# Match these labels to the tree tips
meth_spp_tree$tip.label <- labs[match(meth_spp_tree$tip.label, meth$scientific_name)]

# Reconstruct modified_label to match the tip.label format
meth$modified_label <- sapply(1:nrow(meth), function(i) {
  paste0("'", meth$common_name[i], "'~'('*italic('", meth$scientific_name[i], "')*')'")
})

## plot tree
p <- ggtree(meth_spp_tree)+xlim_tree(1000)+geom_tiplab(size = 3.5, align = TRUE, parse = TRUE)

## plot tree + meth
meth$group <- factor(meth$group, levels = c("Vertebrate", "Invertebrate deuterostome", "Protostome", "Prebilaterian"))

p + 
  geom_fruit(data=meth,
             geom=geom_bar,
             mapping=aes(y=modified_label,
                         fill=group,
                         x=mean_meth),
             pwidth=0.4,
             offset=3,
             stat="identity")+
  
  geom_fruit(data = meth,
             geom = geom_text,
             mapping = aes(y = modified_label,
                           label = paste(sprintf("%.0f", mean_meth), "%"),
                           x = mean_meth),
             hjust = 1,
             color = "black",
             size = 3)+
  
  scale_fill_viridis_d(direction = 1) +
  
  theme(legend.title = element_blank())