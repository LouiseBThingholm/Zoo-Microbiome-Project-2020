
# PGLS in caper

# guides:
# http://www.jcsantosresearch.org/Class_2014_Spring_Comparative/pdf/week_11/Mar_19_2015_comparison_ver_5.pdf
# https://cran.r-project.org/web/packages/caper/caper.pdf
# https://cran.r-project.org/web/packages/caper/vignettes/caper.pdf

# prep data with 2.5_PGLS_prep.data.R
# load a function to do ANOVA on the PGLS object

source(file.path(path_scripts, '2.5_PGLS_prep.data.R'))
source(file.path(path_scripts, 'functions/anova.pgls.fixed.R'))


# ZOO DATA
metadata[1:4,1:4]

# PHYLO TREE
phylo.obj$tip.label
phylo.obj.tmp = phylo.obj
phylo.obj.tmp$node.label = NULL # remove node labels as they disturb the model
metadata$Row.names = as.character( metadata$Row.names )

sum(!metadata$Row.names %in% phylo.obj$tip.label) # checj metadata and phylo tree overlap in nodes to rows (one row in meta per tup in tree)

names(metadata)

# prep data for model, with function from package
comparative.data_ZOO <- comparative.data(phylo.obj.tmp, metadata[ , c('Row.names', 'Order', 'Tierpark', 'Shannon_div', 'Diet_Orientation', 'Chao', 'Behavior')], Row.names) # A simple tool to combine phylogenies with datasets and ensure consistent structure and ordering for use in functions.

## Location
# SHANNON:
        mod_location <- pgls(Shannon_div ~ Tierpark , comparative.data_ZOO, lambda='ML')
        summary(mod_location)
        anova.pgls.fixed(mod_location)
        plot(mod_location)
        pgls.confint(mod_location, 'lambda')
        
        mod_location0 <- pgls(Shannon_div ~ Tierpark , comparative.data_ZOO, lambda=0.0001) # lock lambda (effect of host phylogeny) to 0
        summary(mod_location0)
        anova.pgls.fixed(mod_location0)
        
        
        mod_phy <- pgls(Shannon_div ~ 1, comparative.data_ZOO)
        mod_phy_location <- pgls(Shannon_div ~ Tierpark, comparative.data_ZOO)
        
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
        
  

## Diet
# CHAO
    mod_Diet.Chao <- pgls(Chao ~ Tierpark + Diet_Orientation, comparative.data_ZOO, lambda='ML')
    summary(mod_Diet.Chao) # Lambda >0 is evidence of phylogenetic signal
    anova(mod_Diet.Chao)
    # Diet_Orientation   2   1437   718.6  0.9844    0.3747   
    anova.pgls.fixed(mod_Diet.Chao)
    
    # Lambda    is    0:    We    constrained    this    paramenter
    mod_Diet.Chao_0 <- pgls(Chao ~ Tierpark + Diet_Orientation, comparative.data_ZOO, lambda=0.0001)
    summary(mod_Diet.Chao_0) # Lambda >0 is evidence of phylogenetic signal
    anova(mod_Diet.Chao_0)
    
    anova.pgls.fixed(mod_Diet.Chao_0)

# SHANNON
    mod_Diet <- pgls(Shannon_div ~ Tierpark + Diet_Orientation, comparative.data_ZOO, lambda='ML')
    summary(mod_Diet) # Lambda >0 is evidence of phylogenetic signal
    anova(mod_Diet)
    # Diet_Orientation   2 0.01543 0.007717  1.2297    0.2936    
    anova.pgls.fixed(mod_Diet)
    
    # Lambda    is    0:    We    constrained    this    paramenter
    mod_Diet_0 <- pgls(Shannon_div ~ Tierpark + Diet_Orientation, comparative.data_ZOO, lambda=0.0001)
    summary(mod_Diet_0) # Lambda >0 is evidence of phylogenetic signal
    anova(mod_Diet_0)
    
    anova.pgls.fixed(mod_Diet_0)
    
    
######################
### for single taxa
######################
ASV = t(comm)
ASV[1:4,1:4]

# taxa names
ps.rowsum.uniqAnimal
taxa.table.df = as.data.frame( tax_table(ps.rowsum.uniqAnimal))
head(taxa.table.df)

taxa.table.df$Species

taxa.table.df[grep( 'finegoldii' , taxa.table.df$Species ),]
taxa.table.df[grep( 'stercoris' , taxa.table.df$Species ),]
taxa.table.df[grep( 'tissieri' , taxa.table.df$Species ),]
taxa.table.df[grep( 'leptum' , taxa.table.df$Species ),]


# ASV-129 Bacteria Bacteroidetes Bacteroidia Bacteroidales  Rikenellaceae   Alistipes finegoldii
# ASV-134  Bacteria  Bacteroidetes    Bacteroidia    Bacteroidales    Bacteroidaceae Bacteroides stercoris
# ASV-148 Bacteria Actinobacteria Actinobacteria Bifidobacteriales Bifidobacteriaceae Bifidobacterium tissieri
# ASV-318 Bacteria Firmicutes Clostridia Clostridiales Ruminococcaceae Clostridium_IV  leptum

metadata[1:4,1:4]
metadata.ASV = merge(metadata[, c('Row.names', 'Tierpark', 'Shannon_div', 'Diet_Orientation')], ASV[, c('ASV-129', 'ASV-134', 'ASV-148', 'ASV-318')], by=0)
names(metadata.ASV)
names(metadata.ASV)=sub('-', '_', names(metadata.ASV))
comparative.data_ZOO_ASV <- comparative.data(phylo.obj.tmp, metadata.ASV[ , c('Row.names', 'Tierpark', 'Shannon_div', 'Diet_Orientation',
                                                                          'ASV_129', 'ASV_134', 'ASV_148', 'ASV_318')], Row.names) # A simple tool to combine phylogenies with datasets and ensure consistent structure and ordering for use in functions.


mod_own_129 <- pgls(ASV_129 ~ Tierpark , comparative.data_ZOO_ASV, lambda='ML')
summary(mod_own_129) # Lambda >0 is evidence of phylogenetic signal
anova.pgls.fixed(mod_own_129)

# ASV-134  Bacteria  Bacteroidetes    Bacteroidia    Bacteroidales    Bacteroidaceae Bacteroides stercoris
mod_own_134 <- pgls(ASV_134 ~ Tierpark , comparative.data_ZOO_ASV, lambda='ML')
summary(mod_own_134) # Lambda >0 is evidence of phylogenetic signal
anova.pgls.fixed(mod_own_134)

## ASV-148 Bacteria Actinobacteria Actinobacteria Bifidobacteriales Bifidobacteriaceae Bifidobacterium tissieri
mod_own_148 <- pgls(ASV_148 ~ Tierpark , comparative.data_ZOO_ASV, lambda='ML')
summary(mod_own_148) # Lambda >0 is evidence of phylogenetic signal
anova.pgls.fixed(mod_own_148)

mod_own_319 <- pgls(ASV_319 ~ Tierpark , comparative.data_ZOO_ASV, lambda='ML')
summary(mod_own_319) # Lambda >0 is evidence of phylogenetic signal
anova.pgls.fixed(mod_own_319)

