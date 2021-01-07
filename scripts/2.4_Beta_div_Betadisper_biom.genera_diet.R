# _biom.gen


source( file.path( path_scripts, "2.4_Beta_div_Betadisper/2.4_Beta_div_Betadisper_prep.data_biom.genera.R") )

## DIET ORIENTATION

table(sample_data(ps.rowsum.uniqAnimal_biom.gen)$Diet_Orientation)

metadata=sample_data(ps.rowsum.uniqAnimal_biom.gen)
names(metadata)
rownames(metadata)


dis23_biom.gen = vegdist(otu_table(ps.rowsum.uniqAnimal_biom.gen), method = 'bray', binary=F)
mod23_biom.gen <- betadisper(dis23_biom.gen, as.character( sample_data(ps.rowsum.uniqAnimal_biom.gen)$Diet_Orientation) , bias.adjust=T)

tapply(mod23_biom.gen$distances, as.factor( sample_data(ps.rowsum.uniqAnimal_biom.gen)$Diet_Orientation), mean)
#  Carnivore Herbivores   Omnivore 
# 0.5504835  0.3533861  0.5131510 

## Perform test
obj_biom.gen = anova(mod23_biom.gen)
obj_biom.gen

setwd(paste(path_illustrations, 'Betadisper', sep='/'))
tiff(paste('Betadisper__DietOrientation_n156_biom.gen.tiff', sep=''), width = 30, height = 15, res=75, units="in", family="Helvetica") # width and height are in inches, and res is in pixels/inch

par(mfrow=c(1,2), mar=c(10,5,2,2))
plot(mod23_biom.gen, main = 'Mammalian subgroups by diet orientation', cex=1.5, cex.lab=2, cex.main=2.1)
boxplot(mod23_biom.gen, las=2, main='Distance to centroide in each group', cex=1, cex.lab=2, cex.main=2.1, cex.axis=1.5)

dev.off()

# number species per diet-group
metadata.sub =sample_data(ps.rowsum.uniqAnimal_biom.gen)
overview1= table(metadata.sub$Diet_Orientation, metadata.sub$Species..latein.)
ncol(overview1) - rowCounts(overview1, value = 0) 

#######################
## FOR EACH DIET ORIENTATION, SELECT SAMPLES FROM ONLY 5 DIFFERENT SPECIES
#######################

table(metadata$Species..latein., metadata$Diet_Orientation)

# subset by diet
pval.vector = vector()
#Carnivore_aveDist = vector()
Herbivore_aveDist = vector()
Omnivore_aveDist = vector()

for (n in 1:100){
    #metadata.car = subset(metadata, Diet_Orientation == 'Carnivore')
    #x=names(table(metadata.car$Species..latein.))
    #car.sam5= sample(x, 5)
    
    metadata.nerb = subset(metadata, Diet_Orientation == 'Herbivores')
    x=names(table(metadata.nerb$Species..latein.))
    herb.sam5= sample(x, 5)
    
    metadata.omni = subset(metadata, Diet_Orientation == 'Omnivore')
    x=names(table(metadata.omni$Species..latein.))
    omni.sam5= sample(x, 5)
    
    # subsetting phyloseq object
    ps.rowsum.uniqAnimal_biom.gen_dietOrient.n156 = subset_samples(ps.rowsum.uniqAnimal_biom.gen, Species..latein. %in% c( herb.sam5, omni.sam5))
    ps.rowsum.uniqAnimal_biom.gen_dietOrient.n156
    
    # phyloseq-class experiment-level object
    # otu_table()   OTU Table:         [ 8351 taxa and 210 samples ]
    # sample_data() Sample Data:       [ 210 samples by 24 sample variables ]
    # tax_table()   Taxonomy Table:    [ 8351 taxa by 7 taxonomic ranks ]
    
    dis23_biom.gen = vegdist(otu_table(ps.rowsum.uniqAnimal_biom.gen_dietOrient.n156), method = 'bray', binary=F)
    mod23_biom.gen <- betadisper(dis23_biom.gen, as.character( sample_data(ps.rowsum.uniqAnimal_biom.gen_dietOrient.n156)$Diet_Orientation) , bias.adjust=T)
    
    #tapply(mod23$distances, as.factor( sample_data(ps.rowsum.uniqAnimal_dietOrient.n156)$Diet_Orientation), mean)
    #Carnivore_aveDist[n] = tapply(mod23_biom.gen$distances, as.factor( sample_data(ps.rowsum.uniqAnimal_biom.gen_dietOrient.n156)$Diet_Orientation), mean)[1]
    Herbivore_aveDist[n] = tapply(mod23_biom.gen$distances, as.factor( sample_data(ps.rowsum.uniqAnimal_biom.gen_dietOrient.n156)$Diet_Orientation), mean)[1]
    Omnivore_aveDist[n] = tapply(mod23_biom.gen$distances, as.factor( sample_data(ps.rowsum.uniqAnimal_biom.gen_dietOrient.n156)$Diet_Orientation), mean)[2]
    
    ## Perform test
    obj_biom.gen = anova(mod23_biom.gen)
    pval.vector[n] = obj_biom.gen$`Pr(>F)`[1]

}

setwd(paste(path_results, 'Betadisper', sep='/'))
sink('Betadisper__DietOrientation_n5speciesPerDiet_biom.gen.txt')
summary(pval.vector)
#summary(Carnivore_aveDist)
summary(Herbivore_aveDist)
summary(Omnivore_aveDist)
sink()

pval_sensitivity = 1 - (sum(pval.vector < 0.05) / length(pval.vector))
pval_sensitivity

setwd(paste(path_illustrations, 'Betadisper', sep='/'))
tiff(paste('Betadisper__DietOrientation_n5speciesPerDiet_biom.gen.tiff', sep=''), width = 30, height = 15, res=75, units="in", family="Helvetica") # width and height are in inches, and res is in pixels/inch

par(mfrow=c(1,2), mar=c(10,5,2,2))
plot(mod23_biom.gen, main = 'Mammalian subgroups by diet orientation', cex=1.5, cex.lab=2, cex.main=2.1)
boxplot(mod23_biom.gen, las=2, main='Distance to centroide in each group', cex=1, cex.lab=2, cex.main=2.1, cex.axis=1.5)

dev.off()

# number species per diet-group
metadata.sub =sample_data(ps.rowsum.uniqAnimal_biom.gen_dietOrient.n156)
overview1= table(metadata.sub$Diet_Orientation, metadata.sub$Species..latein.)
ncol(overview1) - rowCounts(overview1, value = 0) 


