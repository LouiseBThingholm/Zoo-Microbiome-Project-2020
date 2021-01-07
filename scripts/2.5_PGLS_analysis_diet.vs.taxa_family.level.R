
# PGLS in caper

# guides:
# http://www.jcsantosresearch.org/Class_2014_Spring_Comparative/pdf/week_11/Mar_19_2015_comparison_ver_5.pdf
# https://cran.r-project.org/web/packages/caper/caper.pdf
# https://cran.r-project.org/web/packages/caper/vignettes/caper.pdf

source(file.path(path_scripts, 'functions/anova.pgls.fixed.R'))
source(file.path(path_scripts, '2.5_PGLS_prep.data_diet.vs.taxa_family.level.R'))



# ZOO DATA
metadata[1:4,1:4]

phylo.obj$tip.label
phylo.obj.tmp = phylo.obj
phylo.obj.tmp$node.label = NULL
metadata$Row.names = as.character( metadata$Row.names )

sum(!metadata$Row.names %in% phylo.obj$tip.label)

names(metadata)
summary(metadata$Behavior)

comparative.data_ZOO <- comparative.data(phylo.obj.tmp, metadata[ , c('Row.names', 'Order', 'Tierpark', 'Shannon_div', 'Diet_Orientation', 'Chao', 
                                                                      "fruit","vegetables","meat","Eggs", "Vit_B","Multimineral_vitamin","Herbs_tea","greenery")], Row.names) # A simple tool to combine phylogenies with datasets and ensure consistent structure and ordering for use in functions.


    
######################
### for single taxa
######################
ASV = t(comm)
ASV[1:4,1:4]

# taxa names
ps.rowsum.uniqAnimal_diet
taxa.table.df = ( tax_table(ps.rowsum.uniqAnimal_diet))
head(taxa.table.df)

# Bacteroidaceae

taxa.table.df[grep( 'Bacteroidaceae' , taxa.table.df[, 'Family'] ),]
# Taxonomy Table:     [1 taxa by 7 taxonomic ranks]:
#     Kingdom    Phylum          Class         Order           Family           Genus Species
# ASV-1 "Bacteria" "Bacteroidetes" "Bacteroidia" "Bacteroidales" "Bacteroidaceae" NA    NA     

table(metadata$meat)
metadata[1:4,1:4]
metadata.ASV = merge(metadata[, c('Row.names', 'Tierpark', 'Shannon_div', 'Diet_Orientation',
                                  "fruit","vegetables","meat","Eggs", "Vit_B","Multimineral_vitamin","Herbs_tea","greenery")], ASV[, c('ASV-1', 'ASV-2')], by=0)
names(metadata.ASV)
names(metadata.ASV)=sub('-', '_', names(metadata.ASV))
comparative.data_ZOO_ASV <- comparative.data(phylo.obj.tmp, metadata.ASV[ , c('Row.names', 'Tierpark', 'Shannon_div', 
                                                                              "fruit","vegetables","meat","Eggs", "Vit_B","Multimineral_vitamin","Herbs_tea","greenery", 
                                                                              'ASV_1', 'ASV_2')], Row.names) # A simple tool to combine phylogenies with datasets and ensure consistent structure and ordering for use in functions.


mod_own_1 <- pgls(ASV_1 ~ Tierpark + meat, comparative.data_ZOO_ASV, lambda='ML')
summary(mod_own_1) # Lambda >0 is evidence of phylogenetic signal
anova.pgls.fixed(mod_own_1)

library(betareg)
par(mar=c(3,4,2,1), mfrow=c(2,2))
y = (metadata.ASV$ASV_1)/100+0.00001

summary(betareg(y ~  metadata.ASV$Tierpark + metadata.ASV$meat))
plot(betareg(y ~  metadata.ASV$Tierpark + metadata.ASV$meat))
# metadata.ASV$meat1                0.4831     0.1898   2.546   0.0109 *  


# ASV-2 "Bacteria" "Proteobacteria" "Gammaproteobacteria" "Enterobacteriales" "Enterobacteriaceae" NA    NA     

mod_own_2 <- pgls(ASV_2 ~ Tierpark + meat, comparative.data_ZOO_ASV, lambda='ML')
summary(mod_own_2) # Lambda >0 is evidence of phylogenetic signal
anova.pgls.fixed(mod_own_2)
# Sequential SS for pgls: lambda = 0.24, delta = 1.00, kappa = 1.00
# 
# Response: ASV_2
# Df    Sum Sq    Mean Sq F value Pr(>F)  
# Tierpark    2 0.0003994 0.00019971  2.1533 0.12093  
# meat        1 0.0004483 0.00044828  4.8333 0.02999 *

library(betareg)
par(mar=c(3,4,2,1), mfrow=c(2,2))
y = (metadata.ASV$ASV_2)/100+0.00001

summary(betareg(y ~  metadata.ASV$Tierpark + metadata.ASV$meat))
plot(betareg(y ~  metadata.ASV$Tierpark + metadata.ASV$meat))
# metadata.ASV$meat1                0.8508     0.1907   4.461 8.15e-06 ***
