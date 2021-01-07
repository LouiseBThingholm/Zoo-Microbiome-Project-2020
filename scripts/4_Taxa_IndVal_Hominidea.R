
# TAXA analysis 

## get preped data 
source( file.path(path_scripts, "4_Taxa_IndVal_prep.data_biom.species_african.R") )

set.seed(5656)

## HOST Genera
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
# otu_table()   OTU Table:         [ 843 taxa and 266 samples ]

table(sample_data(ps.rowsum.uniqAnimal_biom.spe.gen)$new_genus_var)

# filter taxa
# Remove taxa not seen with count more than 0 in at least 15% of the samples. 
#This is nessesery to incure each taxa is found in at least 1 cluster in the IndVal analysis. After we subset to Hominidae this might not be the case.
ps.rowsum.uniqAnimal_biom.spe.gen.cmm = filter_taxa(ps.rowsum.uniqAnimal_biom.spe.gen, function(x) sum(x > 0.00) > (0.005*length(x)), TRUE) # note change from 1% to 0.5% of samples 
ps.rowsum.uniqAnimal_biom.spe.gen.cmm

taxa_names = as.data.frame(tax_table(ps.rowsum.uniqAnimal_biom.spe.gen.cmm))
rownames(taxa_names) = NULL
head(taxa_names)

#***********************
## Perform test
#***********************

    abund.table = otu_table(ps.rowsum.uniqAnimal_biom.spe.gen.cmm)
    colnames(abund.table) = paste(tax_table(ps.rowsum.uniqAnimal_biom.spe.gen.cmm)[,'Genus'], tax_table(ps.rowsum.uniqAnimal_biom.spe.gen.cmm)[,'Species'], 
                                  1:nrow(tax_table(ps.rowsum.uniqAnimal_biom.spe.gen.cmm)), sep = '_')
    
    clustering = sample_data(ps.rowsum.uniqAnimal_biom.spe.gen.cmm)$new_genus_var
    
    metadata_df = as.data.frame(sample_data( ps.rowsum.uniqAnimal_biom.spe.gen.cmm))
    abund.table_Tierpark =  merge(abund.table, metadata_df[, 'Tierpark'], by=0)
    # regress out effect of location >> NOTE DONE AS HUMAN SUBGROUP CORRRELATA 100% WITH LOCATION

# Indicspecies
    
    inv_raw = multipatt(abund.table, clustering, func = "IndVal.g", control = how(
        nperm = 10000
    ))
    
    #inv_raw = multipatt(abund.table, clustering, func = "r.g", control = how(nperm=999))
    #inv_res = multipatt(abund.table_res, clustering, func = "r.g", control = how(nperm=999))
    # function: Four values are accepted "IndVal", "IndVal.g", "r" and "r.g"
    # by using duleg=TRUE, which leads to consider single site-groups only;
    
    inv=inv_raw
    #inv=inv_res
    str(inv)
    
    str.df=inv$str # A matrix the association strength for all combinations studied.
    #rownames(str.df)=NULL
    str.df[1:5,1:5]
    
    A.df=inv$A # A matrix the association strength for all combinations studied.
    #rownames(str.df)=NULL
    A.df[1:5,1:10]
    sum(A.df[1,1:4])
    
    B.df=inv$B # A matrix the association strength for all combinations studied.
    #rownames(str.df)=NULL
    B.df[1:5,1:15]
    
    
    sign.df=(inv$sign)
    sum(!rownames(sign.df) == colnames(abund.table) ) # order has not changed so we can assign taxa name
    #sign.df$Taxa = paste(tax_table(ps.rowsum.uniqAnimal_biom.spe.gen.cmm)[,'Genus'], tax_table(ps.rowsum.uniqAnimal_biom.spe.gen.cmm)[,'Species'], sep = '_')
    #rownames(sign.df) = NULL
    head(sign.df)
    sign.df$p.adj = p.adjust(sign.df$p.value, method = 'BH')
    head(sign.df)
    
    sign.df_anno = cbind(sign.df, taxa_names)
    head(sign.df_anno)
    
    sign.df_anno_tmp= sign.df_anno[ !is.na( sign.df_anno$p.adj),  ]
    head(sign.df_anno_tmp)
    sign.df_anno=sign.df_anno_tmp
    
    sum(sign.df_anno$p.adj <0.05) #141
    sum(sign.df_anno$p.adj <0.001) #51
    sign.df_signif = sign.df_anno[ sign.df_anno$p.adj <0.05, ]
    head(sign.df_signif)
    sum(sign.df_signif[, 1] == 1) # Africa    38
    sum(sign.df_signif[, 2] == 1) # Kiel       71
    sum(sign.df_signif[, 3] == 1) # Pan   59
    sum(sign.df_signif[, 4] == 1) # Pongo  76

    # uniq to one order:
    df=sign.df_signif
    nrow( df[ df[, 1] == 1 &  df[, c(2)] == 0 &  df[, c(3)] == 0 &  df[, c(4)] == 0, ] ) # 2
    nrow(df[ df[, 1] == 0 &  df[, c(2)] == 1 &  df[, c(3)] == 0 &  df[, c(4)] == 0 , ] ) # 35
    nrow(df[ df[, 1] == 0 &  df[, c(2)] == 0 &  df[, c(3)] == 1 &  df[, c(4)] == 0 ,] ) # 8
    nrow(df[ df[, 1] == 0 &  df[, c(2)] == 0 &  df[, c(3)] == 0 &  df[, c(4)] == 1 ,] ) # 20
    
    
    df[ df[, 1] == 1 &  df[, c(2)] == 0 &  df[, c(3)] == 0 &  df[, c(4)] == 0, ] # Africa specific
    
    df_Kiel_specific = df[ df[, 1] == 0 &  df[, c(2)] == 1 &  df[, c(3)] == 0 &  df[, c(4)] == 0 , ] # Kiel
    table( as.character( df_Kiel_specific$Family))
    table( as.character( df_Kiel_specific$Genus))
    
    
    
    sign.df_anno[ which(sign.df_anno$Phylum == 'Spirochaetes'), ]
    str.df_anno = cbind(str.df, taxa_names)
    str.df_anno[ which(str.df_anno$Phylum == 'Spirochaetes'), ]
    
    A.df_anno = cbind(A.df, taxa_names) # relab
    A.df_anno[ which(A.df_anno$Phylum == 'Spirochaetes'), ]
    
    abund.table_tmp = cbind( clustering, data.frame(abund.table))
    abund.table_tmp[1:4,1:4]
    
    tmp.res=tapply(abund.table_tmp$Brachyspira_aalborgi_322, abund.table_tmp$clustering, mean) # mean of A, within clusters given by B tapply(A, B, mean)
    tmp.res[1]/tmp.res[2] # how many times heigher in Africa than Kiel
    
    tmp.res=tapply(abund.table_tmp$Brachyspira_pilosicoli_336, abund.table_tmp$clustering, mean) # mean of A, within clusters given by B tapply(A, B, mean)
    tmp.res[1]/tmp.res[2] # how many times heigher in Africa than Kiel
    tmp2=tapply(abund.table_tmp$Brachyspira_pilosicoli_336, abund.table_tmp$clustering, function(c)sum(c!=0)) #
    tmp2
    tmp2/table(clustering)
    
    B.df_anno = cbind(B.df, taxa_names) # precense
    B.df_anno[ which(B.df_anno$Phylum == 'Spirochaetes'), ]
    
    # specificty to humans
    nrow(df[ df[, 1] == 1 &  df[, c(2)] == 1 &  df[, c(3)] == 0 &  df[, c(4)] == 0, ])
    df[ df[, 1] == 1 &  df[, c(2)] == 1 &  df[, c(3)] == 0 &  df[, c(4)] == 0, ] 
    
    
    # All but Kiel
    sign.df_anno[ which(sign.df_anno$Genus == 'Prevotella') , ]

    tmp.res=tapply(abund.table_tmp$Prevotella_NA_42, abund.table_tmp$clustering, mean) # mean of A, within clusters given by B tapply(A, B, mean)
    tmp.res
    tmp2=tapply(abund.table_tmp$Prevotella_NA_42, abund.table_tmp$clustering, function(c)sum(c!=0)) #
    tmp2
    tmp2/table(clustering)
    
    
    tmp.res=tapply(abund.table_tmp$Prevotella_copri_53, abund.table_tmp$clustering, mean) # mean of A, within clusters given by B tapply(A, B, mean)
    tmp.res
    tmp2=tapply(abund.table_tmp$Prevotella_copri_53, abund.table_tmp$clustering, function(c)sum(c!=0)) #
    tmp2
    tmp2/table(clustering)
    
    # All Kiel
    
    df1=sign.df_anno[ which(sign.df_anno$Family == 'Bacteroidaceae'), ]
    df1[ df1$p.adj<0.05, ]
    
    df1=sign.df_anno[ which(sign.df_anno$Family == 'Porphyromonadaceae'), ]
    df1[ df1$p.adj<0.05, ]
    
    df1=sign.df_anno[ which(sign.df_anno$Family == 'Rikenellaceae'), ]
    df1[ df1$p.adj<0.05, ]
    
    df1=sign.df_anno[ which(sign.df_anno$Family == 'Ruminococcaceae'), ]
    df1[ df1$p.adj<0.05, ]
    
    df1=sign.df_anno[ which(sign.df_anno$Family == 'Streptococcaceae'), ]
    df1[ df1$p.adj<0.05, ]
    
    
    

    # SAVE
    setwd(path_table)
    write.table(sign.df_anno, "TAXA_multipatt_Hominidea.txt", col.names = T, row.names = F, quote = F, sep = '\t')
    
    sign.df_anno.padj0.05 = sign.df_anno[ sign.df_anno$p.adj < 0.05, ]
    dim(sign.df_anno.padj0.05)
    



# Only in Humans - 

    #  at order level?
    Order_table=table(res.df_names.padj0.05$class, res.df_names.padj0.05$Order)
    res.df_names.p0.05 = res.df_names[ res.df$pval < 0.05, ]
    dim(res.df_names.p0.05)
    Order_table=table(res.df_names.p0.05$class, res.df_names.p0.05$Order)
    reord.ord = data.frame(Order_table[1,] == 0, Order_table[2,] == 0, Order_table[3,] == 0, Order_table[4,] == 0)
    names(reord.ord) = c('Homo - Africa',' Homo - Kiel',        'Pan',     'Pongo')
    reord.ord[ reord.ord[ , 2] == FALSE &     # Yes Kiel  
                 reord.ord[ , 1] == FALSE &  # Yes Africa
                 reord.ord[ , 3] == TRUE &
                 reord.ord[ , 4] == TRUE, ] # No Pan

    res.df_names.sub = subset(res.df_names.p0.05, Order == 'Enterobacteriales')
    res.df_names.sub
    
    
# Only in non-Humans?

    #  at order level?
    Order_table=table(res.df_names$class, res.df_names$Order)
    reord.ord = data.frame(Order_table[1,] == 0, Order_table[2,] == 0, Order_table[3,] == 0, Order_table[4,] == 0)
    names(reord.ord) = c('Homo - Africa',' Homo - Kiel',        'Pan',     'Pongo')
    reord.ord[ reord.ord[ , 2] == TRUE &     # Yes Kiel  
                 reord.ord[ , 1] == TRUE &  # Yes Africa
                 reord.ord[ , 3] == FALSE &
                 reord.ord[ , 4] == FALSE, ] # No Pan
    
    res.df_names.sub = subset(res.df_names, Order == 'Anaeroplasmatales')
    res.df_names.sub
    
    #  at family level?
    Order_table=table(res.df_names$class, res.df_names$Family)
    reord.ord = data.frame(Order_table[1,] == 0, Order_table[2,] == 0, Order_table[3,] == 0, Order_table[4,] == 0)
    names(reord.ord) = c('Homo - Africa',' Homo - Kiel',        'Pan',     'Pongo')
    reord.ord[ reord.ord[ , 2] == TRUE &     # Yes Kiel  
                 reord.ord[ , 1] == TRUE &  # Yes Africa
                 reord.ord[ , 3] == FALSE &
                 reord.ord[ , 4] == FALSE, ] # No Pan
    
    res.df_names.sub = subset(res.df_names, Order == 'Anaeroplasmatales')
    res.df_names.sub
    
