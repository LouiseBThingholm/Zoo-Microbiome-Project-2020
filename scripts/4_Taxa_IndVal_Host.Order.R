
# TAXA analysis 

# Core mamalian microbiome

## get preped data 
source( file.path( path_scripts, "4_Taxa_IndVal_prep.data_biom.species.R") )

table(sample_data(ps.rowsum.uniqAnimal_biom.spe)$Order)

# filter taxa
# Remove taxa not seen with count more than 0 in at least 15% of the samples. 
#This is nessesery to incure each taxa is found in at least 1 cluster in the IndVal analysis. After we subset to Hominidae this might not be the case.
ps.rowsum.uniqAnimal_biom.spe.cmm = filter_taxa(ps.rowsum.uniqAnimal_biom.spe, function(x) sum(x > 0.00) > (0.005*length(x)), TRUE) # note change from 1% to 0.5% of samples 
ps.rowsum.uniqAnimal_biom.spe.cmm
# otu_table()   OTU Table:         [ 602 taxa and 368 samples ]

# save taxa annotations to df
taxa_names = as.data.frame(tax_table(ps.rowsum.uniqAnimal_biom.spe.cmm))
rownames(taxa_names) = NULL
head(taxa_names)

names( sample_data( ps.rowsum.uniqAnimal_biom.spe.cmm) )

#***********************
## Perform test
#***********************

abund.table = otu_table(ps.rowsum.uniqAnimal_biom.spe.cmm)


colnames(abund.table) = paste(tax_table(ps.rowsum.uniqAnimal_biom.spe.cmm)[,'Genus'], tax_table(ps.rowsum.uniqAnimal_biom.spe.cmm)[,'Species'], 
                              1:nrow(tax_table(ps.rowsum.uniqAnimal_biom.spe.cmm)), sep = '_')

clustering = sample_data(ps.rowsum.uniqAnimal_biom.spe.cmm)$Order

abund.table_tmp = cbind( clustering, data.frame(abund.table))
abund.table_tmp[1:4,1:4]

# regress out effect of location
metadata_df = as.data.frame(sample_data( ps.rowsum.uniqAnimal_biom.spe.cmm))
abund.table_Tierpark =  merge(abund.table, metadata_df[, 'Tierpark'], by=0)
tail(names(abund.table_Tierpark))
abund.table_res = abund.table

t=colnames(abund.table)[1]
for (t in colnames(abund.table)  ){
  
  #glm.obj = glm(  meta.comm.bi[, t]  ~ meta.comm.bi$Tierpark , family = binomial(link = "logit"))
  glm.obj = lm(  sqrt(abund.table_Tierpark[, t])  ~ abund.table_Tierpark$Tierpark )
  summary(glm.obj)
  abund.table_res[, t] = residuals(glm.obj)
  
  par(mfrow=c(2,1), oma=c(3,3,2,2), mar=c(3,3,2,2))
  plot(density(abund.table[, t]))
  plot(density(abund.table_res[, t]))

}

# Indicspecies
  abund.table_res[1:4,1:4]
  
  inv_raw = multipatt(abund.table, clustering, func = "IndVal.g", control = how(nperm=999))
  inv_res = multipatt(abund.table_res, clustering, func = "IndVal.g", control = how(nperm=999))
  # function: Four values are accepted "IndVal", "IndVal.g", "r" and "r.g"
  # by using duleg=TRUE, which leads to consider single site-groups only;
  

  inv_raw = multipatt(abund.table, clustering, func = "IndVal.g", control = how(
    blocks = (factor( abund.table_Tierpark$Tierpark  )),
    nperm = 10000
  ))
  
  
  inv=inv_raw
  str(inv)
  
  str.df=inv$str # A matrix the association strength for all combinations studied.
  #rownames(str.df)=NULL
  str.df[1:5,1:10]
  
  A.df=inv$A # A matrix the association strength for all combinations studied.
  #rownames(str.df)=NULL
  A.df[1:5,1:10]
  sum(A.df[1,1:4])

  B.df=inv$B # A matrix the association strength for all combinations studied.
  #rownames(str.df)=NULL
  B.df[1:5,1:15]

  ## HOW INTERPRET A AND B.
      ## A is the row-normalized mean abundance
      tmp1=tapply(df$Bacteroides_NA_1, df$clustering, mean) # mean of A, within clusters given by B tapply(A, B, mean)
      sum(tmp1)
      tmp1/sum(tmp1)
      A.df[1,1:4]
      
      # B is the within-group presence, normalized by group size == fraction of samples in group with bacterial species
      B.df[1,1:4]
      tmp2=tapply(df$Bacteroides_NA_1, df$clustering, function(c)sum(c!=0)) # mean of A, within clusters given by B tapply(A, B, mean)
      tmp2
      tmp2/table(clustering)
  
  
  sign.df=(inv$sign)
  sum(!rownames(sign.df) == colnames(abund.table) ) # order has not changed so we can assign taxa name
  #sign.df$Taxa = paste(tax_table(ps.rowsum.uniqAnimal_biom.spe.cmm)[,'Genus'], tax_table(ps.rowsum.uniqAnimal_biom.spe.cmm)[,'Species'], sep = '_')
  #rownames(sign.df) = NULL
  head(sign.df)
  sign.df$p.adj = p.adjust(sign.df$p.value, method = 'BH')
  head(sign.df)
  
  sign.df_anno = cbind(sign.df, taxa_names)
  head(sign.df_anno)
  
  sign.df_anno_tmp= sign.df_anno[ !is.na( sign.df_anno$p.adj),  ]
  head(sign.df_anno_tmp)
  sign.df_anno=sign.df_anno_tmp
  
  sum(sign.df_anno$p.adj <0.05) # 305
  sign.df_signif = sign.df_anno[ sign.df_anno$p.adj <0.05, ]
  head(sign.df_signif)
  sum(sign.df_signif[, 1] == 1) # s.Artiodactyla    82
  sum(sign.df_signif[, 2] == 1) # s.Carnivora       156
  sum(sign.df_signif[, 3] == 1) # s.Perissodactyla  114
  sum(sign.df_signif[, 4] == 1) # s.Primates        83
  
  # uniq to one order:
  df=sign.df_signif
  nrow(df[ df[, 1] == 1 &  df[, c(2)] == 0 &  df[, c(3)] == 0 &  df[, c(4)] == 0  , ]) # 10
  nrow(df[ df[, 1] == 0 &  df[, c(2)] == 1 &  df[, c(3)] == 0 &  df[, c(4)] == 0  , ]) # 139 s.Carnivora
  nrow(df[ df[, 1] == 0 &  df[, c(2)] == 0 &  df[, c(3)] == 1 &  df[, c(4)] == 0  , ]) # 45 
  nrow(df[ df[, 1] == 0 &  df[, c(2)] == 0 &  df[, c(3)] == 0 &  df[, c(4)] == 1  , ]) # 24
  
  tmp_carn=df[ df[, 1] == 0 &  df[, c(2)] == 1 &  df[, c(3)] == 0 &  df[, c(4)] == 0  , ] # carnivora specific
  table(tmp_carn$Genus)[table(tmp_carn$Genus) >= 2]
  table(tmp_carn$Family)[table(tmp_carn$Family) >= 4]
  table(tmp_carn$Order)[table(tmp_carn$Order) >= 4]
  
  tmp_prim =df[ df[, 1] == 0 &  df[, c(2)] == 0 &  df[, c(3)] == 0 &  df[, c(4)] == 1  , ] # primates specific
  table(tmp_prim$Family)[table(tmp_prim$Family) >= 2]
  
  nrow(df[ df[, 1] == 1 &  df[, c(2)] == 0 &  df[, c(3)] == 1 &  df[, c(4)] == 1  , ]) # all but carinvorea
  df[ df[, 1] == 1 &  df[, c(2)] == 0 &  df[, c(3)] == 1 &  df[, c(4)] == 1 , ]
  
  nrow(df[ df[, 1] == 1 &  df[, c(2)] == 0 &  df[, c(3)] == 1 &  df[, c(4)] == 0  , ]) # all but carinvorea & primates
  df[ df[, 1] == 1 &  df[, c(2)] == 0 &  df[, c(3)] == 1 &  df[, c(4)] ==  0 , ]
  
  sign.df_anno[ which(sign.df_anno$Phylum == 'Spirochaetes'), ]
  

  # SAVE
  setwd(path_table)
  write.table(sign.df_anno, "TAXA_multipatt_HostOrder.txt", col.names = T, row.names = F, quote = F, sep = '\t')
  
  sign.df_anno.padj0.05 = sign.df_anno[ sign.df_anno$p.adj < 0.05, ]
  dim(sign.df_anno.padj0.05)
  


# A CORE MICROBIOME

# relative prevalence >80% in all order?
head(A.df) # relative frequency of species in classes

hostCore_relfrq = cbind(B.df, taxa_names)
head(hostCore_relfrq)
hostCore_relfrq.80 = as.data.frame(  hostCore_relfrq[,1:4] > 0.50 )
dim(hostCore_relfrq.80)

hostCore_relfrq[ hostCore_relfrq.80$Artiodactyla == TRUE & 
                   hostCore_relfrq.80$Carnivora == TRUE &
                   hostCore_relfrq.80$Perissodactyla == TRUE &
                   hostCore_relfrq.80$Primates == TRUE,  ] #0

dim(hostCore_relfrq[   #hostCore_relfrq.80$Artiodactyla == TRUE & 
                         hostCore_relfrq.80$Carnivora == TRUE &
                         hostCore_relfrq.80$Perissodactyla == TRUE &
                         hostCore_relfrq.80$Primates == TRUE,  ]) # 6

dim(hostCore_relfrq[   hostCore_relfrq.80$Artiodactyla == TRUE & 
                         #hostCore_relfrq.80$Carnivora == TRUE &
                         hostCore_relfrq.80$Perissodactyla == TRUE &
                         hostCore_relfrq.80$Primates == TRUE,  ]) # 31

dim(hostCore_relfrq[   hostCore_relfrq.80$Artiodactyla == TRUE & 
                         hostCore_relfrq.80$Carnivora == TRUE &
                         #hostCore_relfrq.80$Perissodactyla == TRUE &
                         hostCore_relfrq.80$Primates == TRUE,  ]) # 9

dim(hostCore_relfrq[   hostCore_relfrq.80$Artiodactyla == TRUE & 
                     hostCore_relfrq.80$Carnivora == TRUE &
                     hostCore_relfrq.80$Perissodactyla == TRUE 
                     #hostCore_relfrq.80$Primates == TRUE
                   ,  ]) # 7



table(sample_data(ps.rowsum.uniqAnimal_biom.spe)$Order)

