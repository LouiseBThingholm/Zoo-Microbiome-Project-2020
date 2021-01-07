
source( file.path( path_scripts, "1_MASTERFILE.R") )

# DATA

setwd( file.path(path_github_data ))

ASV=readRDS('Zoo.ps.raw_n426_OTU.rds')
ASV[1:4,1:4]
dim(ASV)

taxa = readRDS('Zoo.ps.raw_n426_taxtable.rds')
head(taxa)
dim(taxa)

meta = readRDS('Zoo.ps.raw_n426_sampledata.rds')
head(meta)
dim(meta)

# JOIN THE 3 DATA FRAMES INTO ONE OBJECT

# GENERATE PHYLOSEQ OBJECT

#taxa_sequences = names(as.data.frame( ASV))
meta_names = names(meta)
rownames(meta) = meta$NewID_Dada2Object

tax  = tax_table(as.matrix (taxa))
head(tax)

otu  = otu_table(ASV, taxa_are_rows=F)
otu[1:4,1:4]

sam = sample_data(meta[, meta_names ])
sam[1:4,1:4]


otutax = phyloseq(otu, tax)
ps = merge_phyloseq(otutax, sam)
ps

# phyloseq-class experiment-level object
# otu_table()   OTU Table:         [ 63780 taxa and 426 samples ]
# sample_data() Sample Data:       [ 426 samples by 23 sample variables ]
# tax_table()   Taxonomy Table:    [ 63780 taxa by 7 taxonomic ranks ]

sample_data(ps)$Species..englisch. 

head(sample_data(ps))
saveRDS(ps, paste0(path_data, "16S_DADA2_processed/Zoo.ps.raw_n426.rds") )

# remove kangarues
ps = subset_samples(ps, Genus != 'Macropus')

# remove samples with one per Order level
listIDs_SingleFam = c('TieG096', 'TiH025')
ps = subset_samples(ps, Verschickungscode != 'TieG096')
ps = subset_samples(ps, Verschickungscode != 'TiH025')
ps
#[ 63780 taxa and 417 samples ]

saveRDS(ps, paste0(path_data, "16S_DADA2_processed/Zoo.ps.raw.rds") )

# NORMALIZE
sort(rowSums(ASV)) # lowest read count : 5994
   
  # RAREFY TO KEEP COUNT FORMAT 
    # rarefy to read count keeping count data format
    # we rarefy in order to bring the samples to the same depth (in this case is the 90% of the abundance of the sample with less reads):
    # rarefy without replacement
    ps.rarefied.count = rarefy_even_depth(ps, rngseed=1, sample.size=5900, replace=F)
    # `set.seed(1)` was used to initialize repeatable random subsampling.
    # 6998 OTUs were removed because they are no longer present in any sample after random subsampling
    
  # rarefy by rowsum norm keeping all data
    #remove low-count samples, and normalixe by rowsum: https://joey711.github.io/phyloseq/preprocess.html
    
    #  remove samples with less than 1000 total reads.
    # ps.1000 = prune_samples(sample_sums(ps)>=5000, ps)
    
    # normalize
    ps.rarefied.rowsum  = transform_sample_counts(ps, function(x) x / sum(x) )

    # 
    unname(otu_table(ps.rarefied.rowsum)[1:8,1:12])
    unname(otu_table(ps.rarefied.count)[1:8,1:12])

    # 
    rowSums(otu_table(ps.rarefied.rowsum)) # rowsum =1
    rowSums(otu_table(ps.rarefied.count)) # rowsum = 5900


# save 
    saveRDS(ps.rarefied.rowsum, file.path( path_data, "16S_DADA2_processed/Zoo.rowsum.rds"))
    saveRDS(ps.rarefied.count, file.path( path_data, "16S_DADA2_processed/Zoo.rarefied.count.rds"))
    
    #ps.rarefied.rowsum = readRDS( file.path( path_data, "16S_DADA2_processed/Zoo.rowsum.rds")  )
    
    ps.rarefied.rowsum
    # phyloseq-class experiment-level object
    #otu_table()   OTU Table:         [ 63780 taxa and 417 samples ]
    #sample_data() Sample Data:       [ 417 samples by 23 sample variables ]
    #tax_table()   Taxonomy Table:    [ 63780 taxa by 7 taxonomic ranks ]

    ps.rarefied.rowsum=  readRDS(file.path( path_data, "16S_DADA2_processed/Zoo.rowsum.rds"))
    ps.rarefied.count = readRDS(file.path( path_data, "16S_DADA2_processed/Zoo.rarefied.count.rds"))
    
    
# CONCATENATE AT TAXA LEVEL 
    rank_names(ps.rarefied.rowsum)
    
    # SPECIES
    ps.rarefied.rowsum.spe = tax_glom(ps.rarefied.rowsum, taxrank="Species",NArm=F) 
    ps.rarefied.rowsum.spe
    saveRDS(ps.rarefied.rowsum.spe, file.path( path_data, "16S_DADA2_processed/Zoo.rowsum_spe.rds")  )
    
    ps.rarefied.count.spe = tax_glom(ps.rarefied.count, taxrank="Species",NArm=F) 
    saveRDS(ps.rarefied.count.spe, file.path( path_data, "16S_DADA2_processed/Zoo.count_spe.rds")  )
    print('done for species')
    
    # GENUS
    ps.rarefied.rowsum.gen = tax_glom(ps.rarefied.rowsum, taxrank="Genus",NArm=F)
    saveRDS(ps.rarefied.rowsum.gen, file.path( path_data, "16S_DADA2_processed/Zoo.rowsum_gen.rds"))
    print('done for GENUS')
    
    # FAMILY
    ps.rarefied.rowsum.Family = tax_glom(ps.rarefied.rowsum, taxrank="Family",NArm=F) 
    saveRDS(ps.rarefied.rowsum.Family, file.path( path_data, "16S_DADA2_processed/Zoo.rowsum_Family.rds"))
    print('done for FAMILY')
    
    # CLASS
    ps.rarefied.rowsum.Family = tax_glom(ps.rarefied.rowsum, taxrank="Class",NArm=F) 
    saveRDS(ps.rarefied.rowsum.Family, file.path( path_data, "16S_DADA2_processed/Zoo.rowsum_Class.rds"))
    print('done for CLASS')
    
    # Phylum
    ps.rarefied.rowsum.Phylum = tax_glom(ps.rarefied.rowsum, taxrank="Phylum",NArm=F) 
    saveRDS(ps.rarefied.rowsum.Phylum, file.path( path_data, "16S_DADA2_processed/Zoo.rowsum_Phylum.rds"))
    print('done for Phylum')
    
    head(sample_data( ps.rarefied.rowsum))
    unique( sample_data( ps.rarefied.rowsum)$Species)
    
        
        
