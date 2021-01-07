# _biom.spe


source( file.path( path_scripts, "2.4_Beta_div_Betadisper/2.4_Beta_div_Betadisper_prep.data_biom.species_african.R") )

## Genera
# make new variable that seperates the humans into african and european

new_genus_var =  as.character( sample_data(ps.rowsum.uniqAnimal_biom.spe.gen)$Genus) 
new_genus_var[as.character( sample_data(ps.rowsum.uniqAnimal_biom.spe.gen)$Genus) == 'Homo' & as.character( sample_data(ps.rowsum.uniqAnimal_biom.spe.gen)$Tierpark) == 'Kiel' ] = 'Homo - Kiel'
new_genus_var[as.character( sample_data(ps.rowsum.uniqAnimal_biom.spe.gen)$Genus) == 'Homo' & as.character( sample_data(ps.rowsum.uniqAnimal_biom.spe.gen)$Tierpark) == 'Africa' ] = 'Homo - Africa'
new_genus_var[new_genus_var == "Homo"] = 'Homo - Zoo keeper'
table(new_genus_var)
sample_data(ps.rowsum.uniqAnimal_biom.spe.gen)$new_genus_var = new_genus_var

# subsetting phyloseq object - remove zoo keepers
ps.rowsum.uniqAnimal_biom.spe.gen = subset_samples(ps.rowsum.uniqAnimal_biom.spe.gen, new_genus_var != 'Homo - Zoo keeper' )
ps.rowsum.uniqAnimal_biom.spe.gen

table(sample_data(ps.rowsum.uniqAnimal_biom.spe.gen)$new_genus_var)

dis23_biom.spe = vegdist(otu_table(ps.rowsum.uniqAnimal_biom.spe.gen), method = 'bray', binary=F)
mod23_biom.spe <- betadisper(dis23_biom.spe, as.character( sample_data(ps.rowsum.uniqAnimal_biom.spe.gen)$new_genus_var) , bias.adjust=T)

tapply(mod23_biom.spe$distances, as.factor( sample_data(ps.rowsum.uniqAnimal_biom.spe.gen)$new_genus_var), mean) # mean 
#Homo - Africa      Homo - Kiel        Pan         Pongo 
# 0.3612950           0.4248156     0.2586513     0.2252952 

#head( sample_data(ps.rowsum.uniqAnimal.gen))

## Perform test
obj_biom.spe = anova(mod23_biom.spe)
obj_biom.spe

vegan::permutest(mod23_biom.spe)

setwd(paste(path_illustrations, 'Betadisper', sep='/'))
png(paste('Betadisper__Genus_biom.spe_African.png', sep=''), width = 30, height = 15, res=75, units="in", family="Helvetica") # width and height are in inches, and res is in pixels/inch

par(mfrow=c(1,2), mar=c(10,5,2,2))
plot(mod23_biom.spe, main = 'Mammal groups at Genus level', cex=1, cex.lab=2, cex.main=2.4)
boxplot(mod23_biom.spe, las=2, main='Distance to centroide in each group', cex=1, cex.lab=2, cex.main=2.4, cex.axis=1.5)

dev.off()

#######################
# SUBSET TO HUMANS ONLY
#######################

    # subsetting phyloseq object
    ps.rowsum.uniqAnimal_biom.spe.gen_human = subset_samples(ps.rowsum.uniqAnimal_biom.spe.gen, new_genus_var == 'Homo - Kiel' | new_genus_var == 'Homo - Africa')
    ps.rowsum.uniqAnimal_biom.spe.gen_human
    # otu_table()   OTU Table:         [ 846 taxa and 203 samples ]
    
    table(sample_data(ps.rowsum.uniqAnimal_biom.spe.gen_human)$new_genus_var)
    
    metadata=sample_data(ps.rowsum.uniqAnimal_biom.spe.gen_human)
    names(metadata)
    rownames(metadata)
    
        dis23_biom.spe = vegdist(otu_table(ps.rowsum.uniqAnimal_biom.spe.gen_human), method = 'bray', binary=F)
        mod23_biom.spe <- betadisper(dis23_biom.spe, as.character( sample_data(ps.rowsum.uniqAnimal_biom.spe.gen_human)$new_genus_var) , bias.adjust=T)
        anova(mod23_biom.spe)

    
        tapply(mod23_biom.spe$distances, as.factor( sample_data(ps.rowsum.uniqAnimal_biom.spe.gen_human)$new_genus_var), mean) # mean
        
        
    setwd(paste(path_results, 'Betadisper', sep='/'))
    sink('Betadisper__HumansLocation__biom.spe.txt')
    anova(mod23_biom.spe)
    sink()
    
      
    setwd(paste(path_illustrations, 'Betadisper', sep='/'))
    png(paste('Betadisper__Genus_biom.spe_African_.png', sep=''), width = 30, height = 15, res=75, units="in", family="Helvetica") # width and height are in inches, and res is in pixels/inch
    
    par(mfrow=c(1,2), mar=c(10,5,2,2))
    plot(mod23_biom.spe, main = 'Hominidae human subgroups', cex=1.5, cex.lab=2, cex.main=2.1)
    boxplot(mod23_biom.spe, las=2, main='Distance to centroide in each group', cex=1, cex.lab=2, cex.main=2.1, cex.axis=1.5)
    
    dev.off()
    


