
# PGLS in caper

source(file.path(path_scripts, 'functions/anova.pgls.fixed.R'))
source(file.path(path_scripts, '2.5_PGLS_prep.data_diet.vs.taxa.R'))

# guides:
# http://www.jcsantosresearch.org/Class_2014_Spring_Comparative/pdf/week_11/Mar_19_2015_comparison_ver_5.pdf
# https://cran.r-project.org/web/packages/caper/caper.pdf
# https://cran.r-project.org/web/packages/caper/vignettes/caper.pdf


# ZOO DATA
metadata[1:4,1:4]

# phylo data
phylo.obj$tip.label
phylo.obj.tmp = phylo.obj
phylo.obj.tmp$node.label = NULL
metadata$Row.names = as.character( metadata$Row.names )

sum(!metadata$Row.names %in% phylo.obj$tip.label)

names(metadata)

comparative.data_ZOO <- comparative.data(phylo.obj.tmp, metadata[ , c('Row.names', 'Order', 'Tierpark', 'Shannon_div', 'Diet_Orientation', 'Chao', 
                                                                      "fruit","vegetables","meat","Eggs", "Vit_B","Multimineral_vitamin","Herbs_tea","greenery")], Row.names) # A simple tool to combine phylogenies with datasets and ensure consistent structure and ordering for use in functions.


# SHANNON:
        mod_location <- pgls(Shannon_div ~ Tierpark + fruit, comparative.data_ZOO, lambda='ML')
        summary(mod_location)
        anova.pgls.fixed(mod_location)
        # fruit1             -1.608375   0.419050 -3.8381 0.0002065 ***
        
        mod_location <- pgls(Shannon_div ~ Tierpark + vegetables, comparative.data_ZOO, lambda='ML')
        summary(mod_location)
        anova.pgls.fixed(mod_location)
        # vegetables   -0.351138   0.217151 -1.6170 0.1087108
        
        mod_location <- pgls(Shannon_div ~ Tierpark + meat, comparative.data_ZOO, lambda='ML')
        summary(mod_location)
        anova.pgls.fixed(mod_location)
        # meat1               0.053578   0.219699  0.2439  0.80778    
        
        mod_location <- pgls(Shannon_div ~ Tierpark + Eggs, comparative.data_ZOO, lambda='ML')
        summary(mod_location)
        anova.pgls.fixed(mod_location)
        # Eggs        -0.69747    0.21290 -3.2760  0.001405 ** 
        
        mod_location <- pgls(Shannon_div ~ Tierpark + Vit_B, comparative.data_ZOO, lambda='ML')
        summary(mod_location)
        anova.pgls.fixed(mod_location)
        # Vit_B       0.18297    0.23498  0.7787   0.4378    
        
        mod_location <- pgls(Shannon_div ~ Tierpark + Multimineral_vitamin, comparative.data_ZOO, lambda='ML')
        summary(mod_location)
        anova.pgls.fixed(mod_location)
        # Multimineral_vitamin   -0.39495    0.19805 -1.9942 0.0485855 * 
        
        mod_location <- pgls(Shannon_div ~ Tierpark + Herbs_tea, comparative.data_ZOO, lambda='ML')
        summary(mod_location)
        anova.pgls.fixed(mod_location)
        # Herbs_tea   -0.183945   0.227509 -0.8085   0.4205    
        
        mod_location <- pgls(Shannon_div ~ Tierpark + greenery, comparative.data_ZOO, lambda='ML')
        summary(mod_location)
        anova.pgls.fixed(mod_location)
        # greenery   1.608375   0.419050  3.8381 0.0002065 ***
        
        
# CAHO
        mod_location_chao <- pgls(Chao ~ Tierpark , comparative.data_ZOO, lambda='ML')
        summary(mod_location_chao)
        anova.pgls.fixed(mod_location_chao)
        plot(mod_location_chao)
        #pgls.confint(mod_location_chao, 'lambda')
        
        mod_location0_chao <- pgls(Chao ~ Tierpark , comparative.data_ZOO, lambda=0.0001)
        summary(mod_location0_chao)
        anova.pgls.fixed(mod_location0_chao)
        
        
        mod_phy_chao <- pgls(Chao ~ 1, comparative.data_ZOO)
        mod_phy_location_chao <- pgls(Chao ~ Tierpark, comparative.data_ZOO)
        
        anova( mod_phy_chao, mod_phy_location_chao)
        
        
        

    
######################
### for single taxa
######################
ASV = t(comm)
ASV[1:4,1:4]

# taxa names
ps.rowsum.uniqAnimal_diet
taxa.table.df = as.data.frame( tax_table(ps.rowsum.uniqAnimal_diet))
head(taxa.table.df)

# Bacteroidaceae
# Prevotella
# Two Prevotella genera, namely Prevotella copri and one unclassified at species level, was tested in the model and both showed significant phylogenetic relatedness 

taxa.table.df[grep( 'Prevotella' , taxa.table.df$Genus ),]
# ASV-26   Bacteria Bacteroidetes Bacteroidia Bacteroidales Prevotellaceae Prevotella           <NA>
# ASV-62   Bacteria Bacteroidetes Bacteroidia Bacteroidales Prevotellaceae Prevotella          copri

taxa.table.df[grep( 'Bacteroidaceae' , taxa.table.df$Family ),]
# ASV-1    Bacteria Bacteroidetes Bacteroidia Bacteroidales Bacteroidaceae   Bacteroides             <NA>
# ASV-8    Bacteria Bacteroidetes Bacteroidia Bacteroidales Bacteroidaceae   Bacteroides            dorei


table(metadata$meat)
metadata[1:4,1:4]
metadata.ASV = merge(metadata[, c('Row.names', 'Tierpark', 'Shannon_div', 'Diet_Orientation',
                                  "fruit","vegetables","meat","Eggs", "Vit_B","Multimineral_vitamin","Herbs_tea","greenery")], ASV[, c('ASV-1', 'ASV-8', 'ASV-26', 'ASV-62')], by=0)
names(metadata.ASV)
names(metadata.ASV)=sub('-', '_', names(metadata.ASV))
comparative.data_ZOO_ASV <- comparative.data(phylo.obj.tmp, metadata.ASV[ , c('Row.names', 'Tierpark', 'Shannon_div', "fruit","vegetables","meat","Eggs", "Vit_B","Multimineral_vitamin","Herbs_tea","greenery", 
                                                                              'ASV_1', 'ASV_8', 'ASV_26', 'ASV_62')], Row.names) # A simple tool to combine phylogenies with datasets and ensure consistent structure and ordering for use in functions.

summary(lm(metadata.ASV$ASV_1 ~ metadata.ASV$meat))
# metadata.ASV$meat1 0.032053   0.008967   3.575 0.000517 ***
summary(lm(metadata.ASV$ASV_8 ~ metadata.ASV$meat))
# -0.003105   0.001705  -1.821  0.07128 . 


library(betareg)
par(mar=c(3,4,2,1), mfrow=c(2,2))

# PREVOTELLA

# ASV-26   Bacteria Bacteroidetes Bacteroidia Bacteroidales Prevotellaceae Prevotella           <NA>
y = (metadata.ASV$ASV_26)/100+0.00001

mod_own_26 <- pgls(ASV_26 ~ Tierpark + meat  , comparative.data_ZOO_ASV, lambda='ML')
summary(mod_own_26) # Lambda >0 is evidence of phylogenetic signal
anova.pgls.fixed(mod_own_26)
# Sequential SS for pgls: lambda = 0.34, delta = 1.00, kappa = 1.00
# 
# Response: ASV_26
# Df    Sum Sq    Mean Sq F value   Pr(>F)    
# Tierpark    2 0.0007040 0.00035199  9.4885 0.000157 ***
#     meat        1 0.0001629 0.00016287  4.3904 0.038415 *

summary(betareg(y ~  metadata.ASV$Tierpark + metadata.ASV$meat))
plot(betareg(y ~  metadata.ASV$Tierpark + metadata.ASV$meat))
#metadata.ASV$meat1               -0.1941     0.1811  -1.072    0.284 

mod_own_26 <- pgls(ASV_26 ~ Tierpark  + vegetables  , comparative.data_ZOO_ASV, lambda='ML')
summary(mod_own_26) # Lambda >0 is evidence of phylogenetic signal
anova.pgls.fixed(mod_own_26)
# vegetables   1 0.0000007 0.00000068  0.0171 0.8962822   

mod_own_26 <- pgls(ASV_26 ~ Tierpark + greenery , comparative.data_ZOO_ASV, lambda='ML')
summary(mod_own_26) # Lambda >0 is evidence of phylogenetic signal
anova.pgls.fixed(mod_own_26)
# greenery    1 0.0001240 0.00012396  3.5003   0.06399 .  
summary(betareg(y ~  metadata.ASV$Tierpark + metadata.ASV$greenery))
plot(betareg(y ~  metadata.ASV$Tierpark + metadata.ASV$greenery))
# metadata.ASV$greenery1           -0.9419     0.2628  -3.585 0.000337 ***

# ASV-62   Bacteria Bacteroidetes Bacteroidia Bacteroidales Prevotellaceae Prevotella          copri

mod_own_62 <- pgls(ASV_62 ~ Tierpark + meat , comparative.data_ZOO_ASV, lambda='ML') # Prevotella copri 
summary(mod_own_62) # Lambda >0 is evidence of phylogenetic signal
anova.pgls.fixed(mod_own_62)
# Sequential SS for pgls: lambda = 0.95, delta = 1.00, kappa = 1.00
# 
# Response: ASV_62
# Df     Sum Sq    Mean Sq F value Pr(>F)
# Tierpark    2 3.4000e-08 1.7050e-08  0.0291 0.9713
# meat        1 2.8600e-07 2.8590e-07  0.4878 0.4864

mod_own_62 <- pgls(ASV_62 ~ Tierpark + vegetables , comparative.data_ZOO_ASV, lambda='ML') # Prevotella copri 
summary(mod_own_62) # Lambda >0 is evidence of phylogenetic signal
anova.pgls.fixed(mod_own_62)
# Sequential SS for pgls: lambda = 0.96, delta = 1.00, kappa = 1.00
# 
# Response: ASV_62
# Df     Sum Sq    Mean Sq F value Pr(>F)
# Tierpark     2 3.1000e-08 1.5670e-08  0.0255 0.9749
# vegetables   1 2.0000e-09 1.6600e-09  0.0027 0.9587
# Residuals  111 6.8302e-05 6.1533e-07  




