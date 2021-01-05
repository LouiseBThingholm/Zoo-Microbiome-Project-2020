

set.seed(99)

# MASTERFILE

# set working directories
project_path = ""

path_scripts = file.path(project_path, "scripts/")
path_data = file.path(project_path, "scripts/")
path_data_processed = file.path(project_path, "data/16S_DADA2_processed//")
path_results = file.path(project_path, "results/")
path_illustrations = file.path(project_path, "results/Illustrations/")
path_table = file.path(project_path, "results/Tables/")

path_github_data = file.path(project_path, "data/BMC_data_prep/B_processed_data_to_Github/")

# load packages

# if (!requireNamespace("BiocManager", quietly = TRUE))
#   install.packages("BiocManager")
# BiocManager::install("DESeq2", version = "3.8")

library(caper)
library(dplyr)
library(phyloseq)
library(grid)
library(gridBase)
library(gridExtra)
library(gridGraphics)
library(ggplot2)
library(vegan)
library(caret)  
library(Rtsne)
library(ggpubr)
library(reshape)
require(reshape2)
require(plyr)
require(ggplot2)
#library(extrafont);  loadfonts() ## for pdf()
library(RColorBrewer)
library(dendextend)
library(ggsignif)
library(phyloseq)
library(metafor)
library(pscl)
library(vegan)
library(ggplot2)
library(tidyr)
library(stringr)
library(ape)
library(ecodist)
library(doParallel)
library(geosphere)
library(matrixStats)
library(labdsv)
library(nlme)
library(picante)
library(indicspecies)
library("grid")
library("ggplotify")
library(cowplot)
library(pheatmap)


sessionInfo()



