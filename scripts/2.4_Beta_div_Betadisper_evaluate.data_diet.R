
res = as.data.frame( matrix( NA, ncol=10, nrow=3))
names(res) = c('Dietary_preference', 
               'ASV_count', 
               'Spe_count', 'Spe_annotated',
               'Gen_count', 'Gen_annotated',
               'Fam_count', 'Fam_annotated',
               'Clas_count', 'Clas_annotated')
res$Dietary_preference = c('Carnivore', 'Herbivore', 'Omnivore')
rownames(res) = res$Dietary_preference

## biom ASV
    ps.rowsum.uniqAnimal_biom.ASV
    table(sample_data(ps.rowsum.uniqAnimal_biom.ASV)$Diet_Orientation)
    
    ps.rowsum.uniqAnimal_biom.ASV_Carnivore = subset_samples(ps.rowsum.uniqAnimal_biom.ASV, Diet_Orientation=="Carnivore")
    ps.rowsum.uniqAnimal_biom.ASV_Carnivore =prune_taxa(taxa_sums(ps.rowsum.uniqAnimal_biom.ASV_Carnivore) > 0, ps.rowsum.uniqAnimal_biom.ASV_Carnivore) 
    ps.rowsum.uniqAnimal_biom.ASV_Carnivore
    res['Carnivore', 'ASV_count'] = ntaxa(ps.rowsum.uniqAnimal_biom.ASV_Carnivore)
    
    ps.rowsum.uniqAnimal_biom.ASV_Herbivore = subset_samples(ps.rowsum.uniqAnimal_biom.ASV, Diet_Orientation=="Herbivores")
    ps.rowsum.uniqAnimal_biom.ASV_Herbivore=prune_taxa(taxa_sums(ps.rowsum.uniqAnimal_biom.ASV_Herbivore) > 0, ps.rowsum.uniqAnimal_biom.ASV_Herbivore) 
    ps.rowsum.uniqAnimal_biom.ASV_Herbivore
    res['Herbivore', 'ASV_count'] = ntaxa(ps.rowsum.uniqAnimal_biom.ASV_Herbivore)
    
    ps.rowsum.uniqAnimal_biom.ASV_Omnivore  = subset_samples(ps.rowsum.uniqAnimal_biom.ASV, Diet_Orientation=="Omnivore")
    ps.rowsum.uniqAnimal_biom.ASV_Omnivore =prune_taxa(taxa_sums(ps.rowsum.uniqAnimal_biom.ASV_Omnivore ) > 0, ps.rowsum.uniqAnimal_biom.ASV_Omnivore ) 
    ps.rowsum.uniqAnimal_biom.ASV_Omnivore
    res['Omnivore', 'ASV_count'] = ntaxa(ps.rowsum.uniqAnimal_biom.ASV_Omnivore)

## biom Family
    ps.rowsum.uniqAnimal_biom.fam
    table(sample_data(ps.rowsum.uniqAnimal_biom.fam)$Diet_Orientation)
    
    ps.rowsum.uniqAnimal_biom.fam_Carnivore = subset_samples(ps.rowsum.uniqAnimal_biom.fam, Diet_Orientation=="Carnivore")
    ps.rowsum.uniqAnimal_biom.fam_Carnivore =prune_taxa(taxa_sums(ps.rowsum.uniqAnimal_biom.fam_Carnivore) > 0, ps.rowsum.uniqAnimal_biom.fam_Carnivore) 
    ps.rowsum.uniqAnimal_biom.fam_Carnivore
    res['Carnivore', 'Fam_count'] = ntaxa(ps.rowsum.uniqAnimal_biom.fam_Carnivore)
    
    ps.rowsum.uniqAnimal_biom.fam_Herbivore = subset_samples(ps.rowsum.uniqAnimal_biom.fam, Diet_Orientation=="Herbivores")
    ps.rowsum.uniqAnimal_biom.fam_Herbivore=prune_taxa(taxa_sums(ps.rowsum.uniqAnimal_biom.fam_Herbivore) > 0, ps.rowsum.uniqAnimal_biom.fam_Herbivore) 
    ps.rowsum.uniqAnimal_biom.fam_Herbivore
    res['Herbivore', 'Fam_count'] = ntaxa(ps.rowsum.uniqAnimal_biom.fam_Herbivore)
    
    ps.rowsum.uniqAnimal_biom.fam_Omnivore  = subset_samples(ps.rowsum.uniqAnimal_biom.fam, Diet_Orientation=="Omnivore")
    ps.rowsum.uniqAnimal_biom.fam_Omnivore =prune_taxa(taxa_sums(ps.rowsum.uniqAnimal_biom.fam_Omnivore ) > 0, ps.rowsum.uniqAnimal_biom.fam_Omnivore ) 
    ps.rowsum.uniqAnimal_biom.fam_Omnivore
    res['Omnivore', 'Fam_count'] = ntaxa(ps.rowsum.uniqAnimal_biom.fam_Omnivore)

    res['Carnivore', 'Fam_annotated'] = sum( !is.na(  as.character( tax_table(ps.rowsum.uniqAnimal_biom.ASV_Carnivore)[, 'Family'] )  ) ) / ntaxa(ps.rowsum.uniqAnimal_biom.ASV_Carnivore) * 100
    res['Herbivore', 'Fam_annotated'] = sum( !is.na(  as.character( tax_table(ps.rowsum.uniqAnimal_biom.ASV_Herbivore)[, 'Family'] )  ) ) / ntaxa(ps.rowsum.uniqAnimal_biom.ASV_Herbivore) * 100
    res['Omnivore', 'Fam_annotated'] = sum( !is.na(  as.character( tax_table(ps.rowsum.uniqAnimal_biom.ASV_Omnivore)[, 'Family'] )  ) ) / ntaxa(ps.rowsum.uniqAnimal_biom.ASV_Omnivore) * 100
    
## biom Species
    ps.rowsum.uniqAnimal_biom.spe
    table(sample_data(ps.rowsum.uniqAnimal_biom.spe)$Diet_Orientation)
    
    ps.rowsum.uniqAnimal_biom.spe_Carnivore = subset_samples(ps.rowsum.uniqAnimal_biom.spe, Diet_Orientation=="Carnivore")
    ps.rowsum.uniqAnimal_biom.spe_Carnivore =prune_taxa(taxa_sums(ps.rowsum.uniqAnimal_biom.spe_Carnivore) > 0, ps.rowsum.uniqAnimal_biom.spe_Carnivore) 
    ps.rowsum.uniqAnimal_biom.spe_Carnivore
    res['Carnivore', 'Spe_count'] = ntaxa(ps.rowsum.uniqAnimal_biom.spe_Carnivore)
    
    ps.rowsum.uniqAnimal_biom.spe_Herbivore = subset_samples(ps.rowsum.uniqAnimal_biom.spe, Diet_Orientation=="Herbivores")
    ps.rowsum.uniqAnimal_biom.spe_Herbivore=prune_taxa(taxa_sums(ps.rowsum.uniqAnimal_biom.spe_Herbivore) > 0, ps.rowsum.uniqAnimal_biom.spe_Herbivore) 
    ps.rowsum.uniqAnimal_biom.spe_Herbivore
    res['Herbivore', 'Spe_count'] = ntaxa(ps.rowsum.uniqAnimal_biom.spe_Herbivore)
    
    ps.rowsum.uniqAnimal_biom.spe_Omnivore  = subset_samples(ps.rowsum.uniqAnimal_biom.spe, Diet_Orientation=="Omnivore")
    ps.rowsum.uniqAnimal_biom.spe_Omnivore =prune_taxa(taxa_sums(ps.rowsum.uniqAnimal_biom.spe_Omnivore ) > 0, ps.rowsum.uniqAnimal_biom.spe_Omnivore ) 
    ps.rowsum.uniqAnimal_biom.spe_Omnivore
    res['Omnivore', 'Spe_count'] = ntaxa(ps.rowsum.uniqAnimal_biom.spe_Omnivore)
    
    res['Carnivore', 'Spe_annotated'] = sum( !is.na(  as.character( tax_table(ps.rowsum.uniqAnimal_biom.ASV_Carnivore)[, 'Species'] )  ) ) / ntaxa(ps.rowsum.uniqAnimal_biom.ASV_Carnivore) * 100
    res['Herbivore', 'Spe_annotated'] = sum( !is.na(  as.character( tax_table(ps.rowsum.uniqAnimal_biom.ASV_Herbivore)[, 'Species'] )  ) ) / ntaxa(ps.rowsum.uniqAnimal_biom.ASV_Herbivore) * 100
    res['Omnivore', 'Spe_annotated'] = sum( !is.na(  as.character( tax_table(ps.rowsum.uniqAnimal_biom.ASV_Omnivore)[, 'Species'] )  ) ) / ntaxa(ps.rowsum.uniqAnimal_biom.ASV_Omnivore) * 100

## biom genera
    ps.rowsum.uniqAnimal_biom.gen
    table(sample_data(ps.rowsum.uniqAnimal_biom.gen)$Diet_Orientation)
    
    ps.rowsum.uniqAnimal_biom.gen_Carnivore = subset_samples(ps.rowsum.uniqAnimal_biom.gen, Diet_Orientation=="Carnivore")
    ps.rowsum.uniqAnimal_biom.gen_Carnivore =prune_taxa(taxa_sums(ps.rowsum.uniqAnimal_biom.gen_Carnivore) > 0, ps.rowsum.uniqAnimal_biom.gen_Carnivore) 
    ps.rowsum.uniqAnimal_biom.gen_Carnivore
    res['Carnivore', 'Gen_count'] = ntaxa(ps.rowsum.uniqAnimal_biom.gen_Carnivore)
    
    ps.rowsum.uniqAnimal_biom.gen_Herbivore = subset_samples(ps.rowsum.uniqAnimal_biom.gen, Diet_Orientation=="Herbivores")
    ps.rowsum.uniqAnimal_biom.gen_Herbivore=prune_taxa(taxa_sums(ps.rowsum.uniqAnimal_biom.gen_Herbivore) > 0, ps.rowsum.uniqAnimal_biom.gen_Herbivore) 
    ps.rowsum.uniqAnimal_biom.gen_Herbivore
    res['Herbivore', 'Gen_count'] = ntaxa(ps.rowsum.uniqAnimal_biom.gen_Herbivore)
    
    ps.rowsum.uniqAnimal_biom.gen_Omnivore  = subset_samples(ps.rowsum.uniqAnimal_biom.gen, Diet_Orientation=="Omnivore")
    ps.rowsum.uniqAnimal_biom.gen_Omnivore =prune_taxa(taxa_sums(ps.rowsum.uniqAnimal_biom.gen_Omnivore ) > 0, ps.rowsum.uniqAnimal_biom.gen_Omnivore ) 
    ps.rowsum.uniqAnimal_biom.gen_Omnivore
    res['Omnivore', 'Gen_count'] = ntaxa(ps.rowsum.uniqAnimal_biom.gen_Omnivore)

    res['Carnivore', 'Gen_annotated'] = sum( !is.na(  as.character( tax_table(ps.rowsum.uniqAnimal_biom.ASV_Carnivore)[, 'Genus'] )  ) ) / ntaxa(ps.rowsum.uniqAnimal_biom.ASV_Carnivore) * 100
    res['Herbivore', 'Gen_annotated'] = sum( !is.na(  as.character( tax_table(ps.rowsum.uniqAnimal_biom.ASV_Herbivore)[, 'Genus'] )  ) ) / ntaxa(ps.rowsum.uniqAnimal_biom.ASV_Herbivore) * 100
    res['Omnivore', 'Gen_annotated'] = sum( !is.na(  as.character( tax_table(ps.rowsum.uniqAnimal_biom.ASV_Omnivore)[, 'Genus'] )  ) ) / ntaxa(ps.rowsum.uniqAnimal_biom.ASV_Omnivore) * 100
    
    

setwd(paste(path_results, 'Tables', sep='/'))
write.table(res, 'Betadisper_evaluate.data.txt', col.names = T, row.names = F, sep = '\t', quote = F)

