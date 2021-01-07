

source( file.path( path_scripts, "1_MASTERFILE.R") )

# DATA

setwd( file.path(path_github_data ))

ASV=readRDS('Zoo.ps.raw_n159_OTU.rds')
ASV[1:4,1:4]
dim(ASV)

taxa = readRDS('Zoo.ps.raw_n159_taxtable.rds')
head(taxa)
dim(taxa)

meta = readRDS('Zoo.ps.raw_n159_sampledata.rds')
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

sample_data(ps)$NewID_Dada2Object

# phyloseq-class experiment-level object
# otu_table()   OTU Table:         [ 37244 taxa and 159 samples ] # note we have ASVs from the full africa dataset of 1250 sampples
# sample_data() Sample Data:       [ 159 samples by 23 sample variables ]
# tax_table()   Taxonomy Table:    [ 37244 taxa by 7 taxonomic ranks ]

saveRDS(ps, paste0(path_data, "16S_DADA2_processed_African/Zoo.ps.raw.rds") ) # note in backup I renamed this saved phyloseq object to Zoo.ps.raw_n159.rds

ps=readRDS(paste0(path_data, "16S_DADA2_processed_African/Zoo.ps.raw.rds"))

# JOIN WITH ZOO PROJECT DATA

ps.ZOO = readRDS( file.path( path_data, "16S_DADA2_processed/Zoo.ps.raw.rds") )
ps.ZOO
# otu_table()   OTU Table:         [ 63780 taxa and 417 samples ]
# sample_data() Sample Data:       [ 417 samples by 23 sample variables ]
# tax_table()   Taxonomy Table:    [ 63780 taxa by 7 taxonomic ranks ]
length(table(sample_data(ps.ZOO)$Species..latein.  )) # 38
sample_data(ps.ZOO)

ps_merged = merge_phyloseq(ps.ZOO, ps)
ps_merged
# phyloseq-class experiment-level object
# otu_table()   OTU Table:         [ 95557 taxa and 576 samples ]
# sample_data() Sample Data:       [ 576 samples by 23 sample variables ]
# tax_table()   Taxonomy Table:    [ 95557 taxa by 7 taxonomic ranks ]

sample_data(ps_merged)$Genus
length(table(sample_data(ps_merged)$Species..latein.  )) # 38

# NORMALIZE
head(sort(rowSums(otu_table(ps_merged)))) # lowest read count : 5994
   
  # RAREFY TO KEEP COUNT FORMAT 
    # rarefy to read count keeping count data format
    # we rarefy in order to bring the samples to the same depth (in this case is the 90% of the abundance of the sample with less reads):
    # rarefy without replacement
    ps.rarefied.count = rarefy_even_depth(ps_merged, rngseed=1, sample.size=5900, replace=F)
    # `set.seed(1)` was used to initialize repeatable random subsampling.
    
    # 30.451 OTUs were removed because they are no longer present in any sample after random subsampling
    # 5.305 OTUs were removed when subsampling the ZOO data only !!!!
    
    ps.rarefied.count
    # otu_table()   OTU Table:         [ 65106 taxa and 576 samples ]
    
  # rarefy by rowsun norm keeping all data
    #remove low-count samples, and normalixe by rowsum: https://joey711.github.io/phyloseq/preprocess.html
    
    #  remove samples with less than 1000 total reads.
    # ps.1000 = prune_samples(sample_sums(ps)>=5000, ps)
    
    # normalize
    ps.rarefied.rowsum  = transform_sample_counts(ps_merged, function(x) x / sum(x) )
    
    unname(otu_table(ps.rarefied.rowsum)[1:8,1:12])
    unname(otu_table(ps.rarefied.count)[1:8,1:12])

    # 
    rowSums(otu_table(ps.rarefied.rowsum)) # rowsum =1
    rowSums(otu_table(ps.rarefied.count)) # rowsum = 5900

# save 
    saveRDS(ps.rarefied.rowsum, file.path( path_data, "16S_DADA2_processed_African/Zoo.rowsum.rds"))
    saveRDS(ps.rarefied.count, file.path( path_data, "16S_DADA2_processed_African/Zoo.rarefied.count.rds"))
    
    #ps.rarefied.rowsum = readRDS( file.path( path_data, "16S_DADA2_processed/Zoo.rowsum.rds")  )
    
    ps.rarefied.rowsum
    # phyloseq-class experiment-level object
    # otu_table()   OTU Table:         [ 95.557 taxa and 576 samples ]


# CONCATENATE AT TAXA LEVEL 
    rank_names(ps.rarefied.rowsum)
    
    # SPECIES
    ps.rarefied.rowsum.spe = tax_glom(ps.rarefied.rowsum, taxrank="Species",NArm=F) 
    ps.rarefied.rowsum.spe
    # otu_table()   OTU Table:         [ 1564 taxa and 576 samples ]
    saveRDS(ps.rarefied.rowsum.spe, file.path( path_data, "16S_DADA2_processed_African/Zoo.rowsum_spe.rds")  )
    
    ps.rarefied.count.spe = tax_glom(ps.rarefied.count, taxrank="Species",NArm=F) 
    saveRDS(ps.rarefied.count.spe, file.path( path_data, "16S_DADA2_processed_African/Zoo.count_spe.rds")  )
    
    
    # GENUS
    ps.rarefied.rowsum.gen = tax_glom(ps.rarefied.rowsum, taxrank="Genus",NArm=F)
    saveRDS(ps.rarefied.rowsum.gen, file.path( path_data, "16S_DADA2_processed_African/Zoo.rowsum_gen.rds"))
    
    # FAMILY
    ps.rarefied.rowsum.Family = tax_glom(ps.rarefied.rowsum, taxrank="Family",NArm=F) 
    saveRDS(ps.rarefied.rowsum.Family, file.path( path_data, "16S_DADA2_processed_African/Zoo.rowsum_Family.rds"))
    
    # CLASS
    ps.rarefied.rowsum.Phylum = tax_glom(ps.rarefied.rowsum, taxrank="Phylum",NArm=F) 
    saveRDS(ps.rarefied.rowsum.Phylum, file.path( path_data, "16S_DADA2_processed_African/Zoo.rowsum_Phylum.rds"))
  
    head(sample_data( ps.rarefied.rowsum))
    unique( sample_data( ps.rarefied.rowsum)$Species..latein.)

           
        
        
        
