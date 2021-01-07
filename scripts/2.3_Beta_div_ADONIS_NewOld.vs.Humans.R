
# ADONIS analysis 
set.seed(666)

## get preped data 
source(file.path(path_scripts, "/4_Taxa_IndVal_prep.data_biom.species_african.R") )

# FAMILY
table(sample_data(ps.rowsum.uniqAnimal_biom.spe)$Family)

table(sample_data(ps.rowsum.uniqAnimal_biom.spe)$Family)[
  table(sample_data(ps.rowsum.uniqAnimal_biom.spe)$Family) > 4 ]

ps.rowsum.uniqAnimal_biom.spe.fam = subset_samples(ps.rowsum.uniqAnimal_biom.spe, 
                                                   Family == 'Hominidae' |
                                                     Family == 'Cercopithecidae'|
                                                     Family == 'Cebidae'|
                                                     Family == 'Callitrichidae')


ps.rowsum.uniqAnimal_biom.spe.fam
table(sample_data(ps.rowsum.uniqAnimal_biom.spe.fam)$Family)
table(sample_data(ps.rowsum.uniqAnimal_biom.spe.fam)$NewWorld.OldWorld)

## HOST Genera
# make new variable that seperates the humans into african and european

new_genus_var =  as.character( sample_data(ps.rowsum.uniqAnimal_biom.spe.fam)$Genus) 
new_genus_var[as.character( sample_data(ps.rowsum.uniqAnimal_biom.spe.fam)$Genus) == 'Homo' & as.character( sample_data(ps.rowsum.uniqAnimal_biom.spe.fam)$Tierpark) == 'Kiel' ] = 'Homo - Kiel'
new_genus_var[as.character( sample_data(ps.rowsum.uniqAnimal_biom.spe.fam)$Genus) == 'Homo' & as.character( sample_data(ps.rowsum.uniqAnimal_biom.spe.fam)$Tierpark) == 'Africa' ] = 'Homo - Africa'
new_genus_var[new_genus_var == "Homo"] = 'Homo - Zoo keeper'
table(new_genus_var)
sample_data(ps.rowsum.uniqAnimal_biom.spe.fam)$new_genus_var = new_genus_var

# subsetting phyloseq object - remove zoo keepers
ps.rowsum.uniqAnimal_biom.spe.fam = subset_samples(ps.rowsum.uniqAnimal_biom.spe.fam, new_genus_var != 'Homo - Zoo keeper' )
ps.rowsum.uniqAnimal_biom.spe.fam
# otu_table()   OTU Table:         [ 843 taxa and 351 samples ]
table(sample_data(ps.rowsum.uniqAnimal_biom.spe.fam)$new_genus_var)

# filter taxa
# Remove taxa not seen with count more than x in at least y% of the samples. 
#This is nessesery to incure each taxa is found in at least 1 cluster in the IndVal analysis. After we subset to Hominidae this might not be the case.
ps.rowsum.uniqAnimal_biom.spe.fam.cmm = filter_taxa(ps.rowsum.uniqAnimal_biom.spe.fam, function(x) sum(x > 0.00) > (0.005*length(x)), TRUE) # note change from 1% to 0.5% of samples 
ps.rowsum.uniqAnimal_biom.spe.fam.cmm

# ADONIS
table(sample_data(ps.rowsum.uniqAnimal_biom.spe.fam)$new_genus_var)
table(sample_data(ps.rowsum.uniqAnimal_biom.spe.fam)$Family)

## Perform test

#  Kiel Humans vs Cercopithecidae (old world) 
    Sub1 = subset_samples(ps.rowsum.uniqAnimal_biom.spe.fam, 
                                                         Family == 'Cercopithecidae'|
                                                          new_genus_var == 'Homo - Kiel')
    
    abund.table_Sub1 = otu_table(Sub1)
    colnames(abund.table_Sub1) = paste(tax_table(Sub1)[,'Genus'], tax_table(Sub1)[,'Species'], sep = '_')
    
    clustering_Sub1 = sample_data(Sub1)$Family
    clustering_Sub1 = as.factor(clustering_Sub1)
    
    
    print(("Taxonomy"))
    ord.1 = (adonis2( abund.table_Sub1 ~ clustering_Sub1, method = 'bray', perm=999))
    print(ord.1)
    # clustering_Sub1  1   6.9202 0.35583 51.925  0.001 ***

#  Kiel Humans vs Pan 
    Sub2 = subset_samples(ps.rowsum.uniqAnimal_biom.spe.fam, 
                          new_genus_var == 'Homo - Kiel' |
                            new_genus_var == 'Pan')
    
    abund.table_Sub2 = otu_table(Sub2)
    colnames(abund.table_Sub2) = paste(tax_table(Sub2)[,'Genus'], tax_table(Sub2)[,'Species'], sep = '_')
    
    clustering_Sub2 = sample_data(Sub2)$new_genus_var
    clustering_Sub2 = as.factor(clustering_Sub2)
    clustering_Sub2
    
    print(("Taxonomy"))
    ord.2 = (adonis2( abund.table_Sub2 ~ clustering_Sub2, method = 'bray', perm=999))
    print(ord.2)
    # clustering_Sub2   1    7.891 0.3965 65.042  0.001 ***
    
#  Kiel Humans vs Pongo 
    Sub3 = subset_samples(ps.rowsum.uniqAnimal_biom.spe.fam, 
                          new_genus_var == 'Homo - Kiel' |
                            new_genus_var == 'Pongo')
    
    abund.table_Sub3 = otu_table(Sub3)
    colnames(abund.table_Sub3) = paste(tax_table(Sub3)[,'Genus'], tax_table(Sub3)[,'Species'], sep = '_')
    
    clustering_Sub3 = sample_data(Sub3)$new_genus_var
    clustering_Sub3 = as.factor(clustering_Sub3)
    clustering_Sub3
    
    print(("Taxonomy"))
    ord.3 = (adonis2( abund.table_Sub3 ~ clustering_Sub3, method = 'bray', perm=999))
    print(ord.3)
    # clustering_Sub3  1   1.9441 0.18994 11.255  0.001 ***
    
    
# African Humans vs Cercopithecidae (old world) 

    Sub4 = subset_samples(ps.rowsum.uniqAnimal_biom.spe.fam, 
                          Family == 'Cercopithecidae'|
                            new_genus_var == 'Homo - Africa')
    
    abund.table_Sub4 = otu_table(Sub4)
    colnames(abund.table_Sub4) = paste(tax_table(Sub4)[,'Genus'], tax_table(Sub4)[,'Species'], sep = '_')
    
    clustering_Sub4 = sample_data(Sub4)$Family
    clustering_Sub4 = as.factor(clustering_Sub4)
    
    
    print(("Taxonomy"))
    ord.4 = (adonis2( abund.table_Sub4 ~ clustering_Sub4, method = 'bray', perm=999))
    print(ord.4)
    # clustering_Sub4   1    8.769 0.24921 69.374  0.001 ***
    
# African Humans vs Pan
    Sub5 = subset_samples(ps.rowsum.uniqAnimal_biom.spe.fam, 
                          new_genus_var == 'Pan'|
                            new_genus_var == 'Homo - Africa')
    
    abund.table_Sub5 = otu_table(Sub5)
    colnames(abund.table_Sub5) = paste(tax_table(Sub5)[,'Genus'], tax_table(Sub5)[,'Species'], sep = '_')
    
    clustering_Sub5 = sample_data(Sub5)$new_genus_var
    clustering_Sub5 = as.factor(clustering_Sub5)
    clustering_Sub5
    
    print(("Taxonomy"))
    ord.5 = (adonis2( abund.table_Sub5 ~ clustering_Sub5, method = 'bray', perm=999))
    print(ord.5)
    # clustering_Sub5   1   10.538 0.28918 87.059  0.001 ***
    
    
######################################    
## betadisper
    table(sample_data(ps.rowsum.uniqAnimal_biom.spe.fam)$new_genus_var)
    table(sample_data(ps.rowsum.uniqAnimal_biom.spe.fam)$Family)
    
    ps.rowsum.uniqAnimal_biom.spe.fam.sub1 = subset_samples(ps.rowsum.uniqAnimal_biom.spe.fam, 
                                                       Family == 'Hominidae' |
                                                         Family == 'Cercopithecidae')
    
    table(sample_data(ps.rowsum.uniqAnimal_biom.spe.fam.sub1)$Family)
    table(sample_data(ps.rowsum.uniqAnimal_biom.spe.fam.sub1)$new_genus_var)
    
    new_clust = paste(sample_data(ps.rowsum.uniqAnimal_biom.spe.fam.sub1)$Family, sample_data(ps.rowsum.uniqAnimal_biom.spe.fam.sub1)$new_genus_var, sep = ' - ')
    table(new_clust)
    
    new_clust[new_clust == 'Cercopithecidae - Cercopithecus'] = 'Cercopithecidae'
    new_clust[new_clust == 'Cercopithecidae - Lophocebus'] = 'Cercopithecidae'
    new_clust[new_clust == 'Cercopithecidae - Macaca'] = 'Cercopithecidae'
    new_clust[new_clust == 'Cercopithecidae - Mandrillus'] = 'Cercopithecidae'
    new_clust[new_clust == 'Cercopithecidae - Papio'] = 'Cercopithecidae'
    
    sample_data(ps.rowsum.uniqAnimal_biom.spe.fam.sub1)$new_clust = new_clust
    
    dis23_biom.spe = vegdist(otu_table(ps.rowsum.uniqAnimal_biom.spe.fam.sub1), method = 'bray', binary=F)
    mod23_biom.spe <- betadisper(dis23_biom.spe, as.character( sample_data(ps.rowsum.uniqAnimal_biom.spe.fam.sub1)$new_clust) , bias.adjust=T)
    
    #head( sample_data(ps.rowsum.uniqAnimal.gen))
    
    ## Perform test
    obj_biom.spe = anova(mod23_biom.spe)
    obj_biom.spe
    
    vegan::permutest(mod23_biom.spe)
    
    par(mfrow=c(1,1), mar=c(10,5,2,2))
    plot(mod23_biom.spe, main = '', cex=1, cex.lab=2, cex.main=2.4)


