
# PGLS in caper

# guides:
# http://www.jcsantosresearch.org/Class_2014_Spring_Comparative/pdf/week_11/Mar_19_2015_comparison_ver_5.pdf
# https://cran.r-project.org/web/packages/caper/caper.pdf
# https://cran.r-project.org/web/packages/caper/vignettes/caper.pdf

source(file.path(path_scripts, '2.5_PGLS_prep.data_Homi.R'))
source(file.path(path_scripts, 'functions/anova.pgls.fixed.R'))

# ZOO DATA
metadata[1:4,1:4]

phylo.obj$tip.label
phylo.obj.tmp = phylo.obj
phylo.obj.tmp$node.label = NULL
metadata$Row.names = as.character( metadata$Row.names )

sum(!metadata$Row.names %in% phylo.obj$tip.label)

comparative.data_ZOO <- comparative.data(phylo.obj.tmp, metadata[ , c('Row.names', 'Tierpark', 'Shannon_div', 'Diet_Orientation', 'Chao')], Row.names) # A simple tool to combine phylogenies with datasets and ensure consistent structure and ordering for use in functions.

## Location
# SHANNON:
        mod_location <- pgls(Shannon_div ~ Tierpark , comparative.data_ZOO, lambda='ML')
        summary(mod_location)
        anova.pgls.fixed(mod_location)
        plot(mod_location)
        pgls.confint(mod_location, 'lambda')
        
        mod_location0 <- pgls(Shannon_div ~ Tierpark , comparative.data_ZOO, lambda=0.0001)
        summary(mod_location0)
        anova.pgls.fixed(mod_location0)
        
        
# CAHO
        mod_location_chao <- pgls(Chao ~ Tierpark , comparative.data_ZOO, lambda='ML')
        summary(mod_location_chao)
        anova.pgls.fixed(mod_location_chao)
        plot(mod_location_chao)
        #pgls.confint(mod_location_chao, 'lambda')
        
        mod_location0_chao <- pgls(Chao ~ Tierpark , comparative.data_ZOO, lambda=0.0001)
        summary(mod_location0_chao)
        anova.pgls.fixed(mod_location0_chao)
        
        
