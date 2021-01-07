# _biom.spe

source( file.path( path_scripts, "2.4_Beta_div_Betadisper/2.4_Beta_div_Betadisper_prep.data_biom.species.R") )

## DIET ORIENTATION

table(sample_data(ps.rowsum.uniqAnimal_biom.spe)$Diet_Orientation)

metadata=sample_data(ps.rowsum.uniqAnimal_biom.spe)
names(metadata)
rownames(metadata)


dis23_biom.spe = vegdist(otu_table(ps.rowsum.uniqAnimal_biom.spe), method = 'bray', binary=F)
mod23_biom.spe <- betadisper(dis23_biom.spe, as.character( sample_data(ps.rowsum.uniqAnimal_biom.spe)$Diet_Orientation) , bias.adjust=T)

tapply(mod23_biom.spe$distances, as.factor( sample_data(ps.rowsum.uniqAnimal_biom.spe)$Diet_Orientation), mean)
# Carnivore Herbivores   Omnivore 
# 0.5631954  0.3539651  0.5184707 


## Perform test
obj_biom.spe = anova(mod23_biom.spe)
obj_biom.spe
# Analysis of Variance Table
# 
# Response: Distances
# Df  Sum Sq Mean Sq F value   Pr(>F)    
# Groups      2  1.7863 0.89314  28.802 2.43e-12 ***
#     Residuals 365 11.3186 0.03101                     
# ---
#     Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

setwd(paste(path_illustrations, 'Betadisper', sep='/'))
tiff(paste('Betadisper__DietOrientation_n156_biom.spe_diet.tiff', sep=''), width = 30, height = 15, res=75, units="in", family="Helvetica") # width and height are in inches, and res is in pixels/inch

par(mfrow=c(1,2), mar=c(10,5,2,2))
plot(mod23_biom.spe, main = 'Mammalian subgroups by diet orientation', cex=1.5, cex.lab=2, cex.main=2.1)
boxplot(mod23_biom.spe, las=2, main='Distance to centroide in each group', cex=1, cex.lab=2, cex.main=2.1, cex.axis=1.5)

dev.off()

# number species per diet-group
metadata.sub =sample_data(ps.rowsum.uniqAnimal_biom.spe)
overview1= table(metadata.sub$Diet_Orientation, metadata.sub$Species..latein.)
ncol(overview1) - rowCounts(overview1, value = 0) 

#######################
## FOR EACH DIET ORIENTATION, SELECT SAMPLES FROM ONLY 5 DIFFERENT SPECIES
#######################

table(metadata$Species..englisch., metadata$Diet_Orientation)
table( metadata$Diet_Orientation)

# subset by diet
pval.vector = vector()
Carnivore_aveDist = vector()
Herbivore_aveDist = vector()
Omnivore_aveDist = vector()
n=1
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
    ps.rowsum.uniqAnimal_biom.spe_dietOrient.n156 = subset_samples(ps.rowsum.uniqAnimal_biom.spe, Species..latein. %in% c( herb.sam5, omni.sam5))
    ps.rowsum.uniqAnimal_biom.spe_dietOrient.n156

    
    dis23_biom.spe = vegdist(otu_table(ps.rowsum.uniqAnimal_biom.spe_dietOrient.n156), method = 'bray', binary=F)
    mod23_biom.spe <- betadisper(dis23_biom.spe, as.character( sample_data(ps.rowsum.uniqAnimal_biom.spe_dietOrient.n156)$Diet_Orientation) , bias.adjust=T)
    
    #tapply(mod23$distances, as.factor( sample_data(ps.rowsum.uniqAnimal_dietOrient.n156)$Diet_Orientation), mean)
    #Carnivore_aveDist[n] = tapply(mod23_biom.spe$distances, as.factor( sample_data(ps.rowsum.uniqAnimal_biom.spe_dietOrient.n156)$Diet_Orientation), mean)[1]
    Herbivore_aveDist[n] = tapply(mod23_biom.spe$distances, as.factor( sample_data(ps.rowsum.uniqAnimal_biom.spe_dietOrient.n156)$Diet_Orientation), mean)[1]
    Omnivore_aveDist[n] = tapply(mod23_biom.spe$distances, as.factor( sample_data(ps.rowsum.uniqAnimal_biom.spe_dietOrient.n156)$Diet_Orientation), mean)[2]
    
    ## Perform test
    obj_biom.spe = anova(mod23_biom.spe)
    pval.vector[n] = obj_biom.spe$`Pr(>F)`[1]

}

setwd(paste(path_results, 'Betadisper', sep='/'))
sink('Betadisper__DietOrientation_n5speciesPerDiet_biom.spe.txt')
summary(pval.vector)
#summary(Carnivore_aveDist)
summary(Herbivore_aveDist)
summary(Omnivore_aveDist)
sink()

pval_sensitivity = 1 - (sum(pval.vector < 0.05) / length(pval.vector))
pval_sensitivity
plot((pval.vector))

setwd(paste(path_illustrations, 'Betadisper', sep='/'))
tiff(paste('Betadisper__DietOrientation_n5speciesPerDiet_biom.spe.tiff', sep=''), width = 30, height = 15, res=75, units="in", family="Helvetica") # width and height are in inches, and res is in pixels/inch

par(mfrow=c(1,2), mar=c(10,5,2,2))
plot(mod23_biom.spe, main = 'Mammalian subgroups by diet orientation', cex=1.5, cex.lab=2, cex.main=2.1)
boxplot(mod23_biom.spe, las=2, main='Distance to centroide in each group', cex=1, cex.lab=2, cex.main=2.1, cex.axis=1.5)

dev.off()




