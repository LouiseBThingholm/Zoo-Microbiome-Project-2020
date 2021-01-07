
# BETA DIVERSITET

source(file.path(path_scripts, "1_MASTERFILE.R") )
source(file.path(path_scripts, "/functions/small_functions.R") )

# DATA
# use the subsampled -lowest-level- and rarefyed data. In DADA2, that is the ASV table.

ps.rowsum_glom = readRDS(  file.path(path_data, "16S_DADA2_processed/Zoo.rowsum_spe.rds") )
ps.rowsum_glom
# otu_table()   OTU Table:         [ 1381 taxa and 417 samples ]

# Remove taxa not seen with count more than 3 in at least 15% of the samples. 
#This protects against an OTU with small mean & trivially large C.V.
ps.rowsum.gen.cmm = filter_taxa(ps.rowsum_glom, function(x) sum(x > 0.00) > (0.01*length(x)), TRUE)
ps.rowsum.gen.cmm
ps.rowsum = ps.rowsum.gen.cmm

# select one sample per animal (as some animals had multiple samples collected)

listIDs_onPerAnimal = c("TieG003", "TieG024", "TieG017", "TieG022", "TieG008", "TieG023", "TieG002", "TieG004", "TieG012", "TieG009", "TieG019", "TieG031", "TieG032", "TieG020", "TieG021", "TieG025", "TieG016", "TieG066", "TieG054", "TieG052", "TieG065", "TieG062", "TieG063", "TieG064", "TieG051", "TieG038", "TieG037", "TieG041", "TieG039", "TieG040", "TieG061", "TieG140", "TieG147", "TieG067", "TieG143", "TieG149", "TieG076", "TieG075", "TieG078", "TieG124", "TieG121", "TieG122", "TieG125", "TieG101", "TieG102", "TieG128", "TieG126", "TieG105", "TiH017", "TiH023", "TiH025", "TiH010", "TiA033", "TiA018", "TiA045", "TiA038", "TiA029", "TiA016", "TiA034", "TiA044", "TiA021", "TiA013", "TiA024", "TiA031", "TiA032", "TiA026", "TiA025", "TiA039", "TiA030", "TiA022", "TiA040", "TiA006", "TiA035", "TiA007", "TiA015", "TiB002", "TiB022", "TieG119", "TiA046", "ZOL010", "ZOL011", "TieG034", "ZOL012", "Til017", "TiH001", "TiB037", "TieG013", "ZOL013", "TieG112", "TieG055", "TieG015", "TieG060", "ZOL002", "Til006", "TieG110", "ZOL003", "TieG097", "TieG096", "TiA010", "NecBac", "TieG070", "TieG085", "TieG086", "TieG082", "TieG077", "TieG050", "Til033", "TiA011", "Til004", "TieG104", "TieG106", "ZOL004", "Til038", "ZOL005", "TiB029", "Til031", "Til039", "Til025", "Til020", "TiA001", "TiB080", "TiA023", "TieG092", "TieG036", "Til014", "TiA003", "ZOL014", "TieG111", "TiB079", "TiB063", "TieG088", "TieG069", "TieG079", "TieG093", "TieG071", "TieG074", "TieG115", "TieG089", "TieG027", "Til009", "TiN011", "Til019", "Til016", "TieG053", "TiB052", "Til007", "Til022", "TiH019", "TieG095", "TieG099", "Til005", "TieG057", "TieG058", "TieG030", "TieG118", "Til013", "TiH012", "Til029", "TiA017", "Til018", "TieG109", "TieG098", "TieG107", "Til012", "ZOL006", "Til001", "TiA012", "TiB044", "TieG114", "TieG006", "TieG113", "TieG127", "Til032", "Til044", "Til011", "Til030", "Til034", "Til015", "TiA019", "TieG090", "ZOL007", "TiB075", "ZOL008St", "TiA008", "TieG035", "Til008", "TiN086", "TiN036", "TiN071", "TiN055", "TiN087", "TiN056", "TiN031", "TiN079", "TiN083", "TiN053", "TiN080", "TiN058", "TiN078", "TiN093", "TiN023", "TiN091", "TiN049", "TiN067", "TiN096", "TiN029", "TiN066", "TiN050", "TiN048", "TiN024", "TiN094", "TiN097", "TiN068", "TiN022", "TiN064", "TiN075", "TiN041", "TiN044", "TiN046", "TiN072", "TiN051", "TiN054", "TiN052", "TiN035", "TiN033", "TiN085", "TiN084", "TiN081", "TiN082", "TiN099", "TiN090", "TiN028", "TiN095", "TiN040", "TiN069", "TiN100", "TiN074", "TiN061", "TiN062", "TiN030", "TiN098", "TiN047", "TiN073", "TiN043", "TiN092", "TiN042", "TiN063", "TiN045", "TiN027", "TiN088", "TiN026", "TiN060", "TiN039", "TiN038", "TiN021", "TiN065", "TiN059", "TiN057", "TiN025", "TiN076", "TiN037", "TiN089", "TiB058", "TiB077", "TiB007", "TiB071", "TiB018", "TiB042", "TiB053", "TiB047", "TiB011", "TiB026", "TiB040", "TiB060", "TiB054", "TiB059", "TiB061", "TiB027", "TiB051", "TiB064", "TiB038", "TiB028", "TiB045", "TiB001", "TiB009", "TiB010", "TiB024", "TiB015", "TiB025", "TiB030", "TiB076", "TiB003", "TiB008", "TiB073", "TiB004", "TiB017", "TiB062", "TiB013", "TiB014", "TiB019", "TiB012", "TiH006", "Til040", "Til002", "Til027", "Til041", "TiH004", "TieG116", "Til010", "TiH007", "Til043", "TieG056", "Til026", "TieG026", "Til023", "TieG028", "TieG103", "TiH016", "TiB020", "Til036", "TiH008", "ZOL009", "TiA041", "TiA005", "TiA004", "TiN001", "TieG123", "Til035", "TieG029", "TieG080", "TiA009", "ZOL001", "TieG108", "Til024", "Til042", "Til021")
length(listIDs_onPerAnimal)
# add humans
listID_human = c("EMGE001", "EMGE002", "EMGE004", "EMGE005", "EMGE006", "EMGE007", "EMGE012", "EMGE015", "EMGE017", "EMGE020", "EMGE024", "EMGE027", "EMGE028", "EMGE041", "EMGE042", "EMGE045", "EMGE049", "EMGE050", "EMGE051", "EMGE056", "EMGE068", "EMGE072", "EMGE088", "EMGE094", "EMGE098", "EMGE103", "EMGE108", "EMGE110", "EMGE112", "EMGE121", "EMGE127", "EMGE129", "EMGE140", "EMGE143", "EMGE144", "EMGE145", "EMGE147", "EMGE149", "EMGE151", "EMGE154", "EMGE159", "EMGE160", "EMGE162", "EMGE165")
listIDs_onPerAnimal_and_human = c(listIDs_onPerAnimal, listID_human)

ps.rowsum.uniqAnimal = subset_samples(ps.rowsum, Verschickungscode %in% listIDs_onPerAnimal_and_human)
ps.rowsum.uniqAnimal
# phyloseq-class experiment-level object
# otu_table()   OTU Table:         [ 602 taxa and 368 samples ]

# RECODE HOST SPECIES
# recode host species to match host-phylogeny file (best guess species names)
        
    species.latin = as.character(sample_data(ps.rowsum.uniqAnimal)$Species..latein.)
    #same as
    # get_variable(ps.rowsum.uniqAnimal, "Species..latein.")
    length(table(species.latin))#40
    
    species.latin[species.latin=="Bos primigenius f. taurus"] <- "Bos primigenius"
    species.latin[species.latin=="Camelus ferus f. bactrianus"] <- "Camelus ferus"
    species.latin[species.latin=="Capra aegagrus f. hircus"] <- "Capra aegagrus"
    species.latin[species.latin=="Equus quagga"] <- "Equus burchellii" # just the former name
    
    species.latin[species.latin=="Equus asinus f. asinus"] <- "Equus asinus" # miniature is not in the system
    species.latin[species.latin=="Equus ferus"] <- "Equus caballus" # I cannot find a better species level name that is in the system
    species.latin[species.latin=="Macropus eugenii or rufogriseus"] <- "Macropus eugenii"
    species.latin[species.latin=="Taurotragus oryx"] <- "Tragelaphus oryx"
    species.latin[species.latin=="Macropus rufogriseus"] <- "Macropus parryi"
    
    length(table(species.latin)) # 38
    
    sample_data(ps.rowsum.uniqAnimal)$Species_bestGuess = as.factor(species.latin)
    
    # how many species have more than 1 sample:                            34
    length(table(sample_data(ps.rowsum.uniqAnimal)$Species_bestGuess)[ 
      table(sample_data(ps.rowsum.uniqAnimal)$Species_bestGuess) > 1 ]) 
    # who only has one:
    names(table(sample_data(ps.rowsum.uniqAnimal)$Species_bestGuess)[ 
      table(sample_data(ps.rowsum.uniqAnimal)$Species_bestGuess) == 1 ]) # 
    # [1] "Lophocebus aterrimus"             "Mandrillus sphinx"                "Pan paniscus"                     "Saguinus imperator subgrisescens"

    
#########################
## MICROBIOME DISTANCE MATRIX
#########################

    dist_Jaccard = vegdist(otu_table(ps.rowsum.uniqAnimal), method="jaccard", binary=T)
        
  # # status on BC dissimilarity matrix
  summary(as.vector(dist_Jaccard))


#########################
# Host phylogeny
#########################

        # full host tree of all 
        host_tree_file = file.path(path_github_data, '/unique_species_latin_best-guess_V4_n42.nwk')
        # host tree
        host_tree = read.tree(host_tree_file)
        host_tree
        # rooted tree?
        ape::is.rooted(host_tree)
      
        # Microbime Overlap with host tree
        # in host tree, but not in 16S microbiome data?
        setdiff(host_tree$tip.label, as.character( sample_data(ps.rowsum.uniqAnimal)$Species_bestGuess )) %>% print
        
        # replace space with _
        
        sample_data(ps.rowsum.uniqAnimal)$Species_bestGuess = sub(" ", "_", as.character( sample_data(ps.rowsum.uniqAnimal)$Species_bestGuess )  )
        setdiff(host_tree$tip.label, as.character( sample_data(ps.rowsum.uniqAnimal)$Species_bestGuess ) ) %>% print
        # "Pithecia_pithecia"     "Euphractus_sexcinctus"
        
        # in 16S microbiome data, but not in host tree (PROBLEM!)
        setdiff(as.character( sample_data(ps.rowsum.uniqAnimal)$Species_bestGuess ), host_tree$tip.label) %>% print
        # character(0)
        
        # Filtering host tree
        to_rm = setdiff(host_tree$tip.label, as.character( sample_data(ps.rowsum.uniqAnimal)$Species_bestGuess ) ) 
        host_tree_prn = drop.tip(host_tree, to_rm)
        host_tree_prn
        # Phylogenetic tree with 38 tips and 37 internal nodes.
        
        # plotting tree
        options(repr.plot.width=6, repr.plot.height=10)
        plot(host_tree_prn, no.margin=TRUE, cex=0.4)
        
        # Expanding host tree tips
        # Many host species has more than one animal sampled. Add these additional samples to the tree.
        
        # tip label <--> node id
        df_nodes = data.frame(label = host_tree_prn$tip.label,
                              node = 1:length(host_tree_prn$tip.label))
        # adding all host_subj_id (merging metadata 'IDs' with the host-species info)
        metadata=as.data.frame(as.matrix(sample_data(ps.rowsum.uniqAnimal)))
        

        typeof(df_nodes)
        typeof(metadata)
        head(metadata)
        df_nodes = df_nodes %>%
          inner_join(metadata %>% dplyr::select(NewID_Dada2Object, Species_bestGuess), c('label'='Species_bestGuess')) %>% # take the two relevant columns in metadata
          as.data.frame
        head(df_nodes, n=10)
        
        # adding new tips
        tree_exp = host_tree_prn
        map_tmp = metadata 
        
        lab="Macropus_eugenii"
        for(lab in as.character( unique(df_nodes$label))){
          # creating polytomy tree
          samps = df_nodes[df_nodes$label == lab,]
          x = paste(samps$NewID_Dada2Object, collapse=',')
          x = paste0('(', x, ');')
          tree_poly = read.tree(text = x)
          # adding branch lengths 
          tree_poly = compute.brlen(tree_poly, 1e-10)
          
          # getting current node --> label structure
          df_tmp = data.frame(label = tree_exp$tip.label,
                              node = 1:length(tree_exp$tip.label))
          
          # getting node corresponding to tip label 
          x = 1:length(tree_exp$tip.label)
          node = x[which(tree_exp$tip.label==lab)] 
          
          # adding subtree to main tree
          tree_exp = bind.tree(tree_exp, tree_poly, where=node)
        }
        
        tree_exp
        # Phylogenetic tree with 374 tips and 73 internal nodes.
        
        # plotting tree
        options(repr.plot.width=6, repr.plot.height=14)
        plot(tree_exp, no.margin=TRUE, cex=0.4)
 
        # generate a distance matrix
        tree_IndD_d = tree_exp %>% cophenetic %>% as.dist %>% rescale_dist_mtx 
        # So the tree is given to cophenetic() then to as.dist and then to rescale.
        # cophenetic: Computes the cophenetic distances for a hierarchical clustering
        # 
        
        # plot
          options(repr.plot.width=10, repr.plot.height=4)
          plot(hclust(tree_IndD_d), cex=0.4)
        
        # check
          df_tree_IndD_d =as.data.frame(as.matrix(tree_IndD_d))
          df_tree_IndD_d[1:5,1:4]
        
          
  host_tree_d=df_tree_IndD_d
  options(repr.plot.height=4, repr.plot.width=10)
  plot(hclust(host_tree_d), cex=0.4)
  
  # Checking overlap
  
  # beta-div and host tree
  setdiff(dist_Jaccard %>% labels, host_tree_d %>% labels) %>% print
  setdiff(host_tree_d %>% labels, dist_Jaccard %>% labels) %>% print
  
  #character(0)
  #character(0)
  
#################################
# Geographic distance
#################################

  # read data
  setwd(path_github_data)
  zoo.cord = read.csv('locations_coordinates.txt', header = T, sep='\t')
  head(zoo.cord)
  zoo.cord$Adress.used.to.find.coordinates = NULL
  head(zoo.cord)
  
  # join with metadata
  metadata=as.data.frame(as.matrix(sample_data(ps.rowsum.uniqAnimal)))
  head(metadata)
  
  typeof(df_nodes)
  typeof(metadata)
  

  zoo.cord = zoo.cord %>%
    inner_join(metadata %>% dplyr::select(NewID_Dada2Object, Species_bestGuess, Tierpark), c('Location'='Tierpark')) %>% # take the two relevant columns in metadata
    as.data.frame
  head(zoo.cord, n=10)
  dim(zoo.cord) # [1] 374   5
  
  geo = zoo.cord %>% 
    dplyr::select(NewID_Dada2Object, Latitude, Longitude) %>%
    mutate(Latitude = Latitude %>% as.numeric,
           Longitude = Longitude %>% as.numeric) %>%
    as.data.frame
  
  rownames(geo) = geo$NewID_Dada2Object
  
  
  geo$Latitude %>% summary %>% print
  geo$Longitude %>% summary %>% print
  geo %>% head

  
  # calculate distances based on coordinates
  .pairwise_distGeo = function(x, y){
    d = geosphere::distGeo(x[c('Longitude', 'Latitude')],
                           y[,c('Longitude', 'Latitude')])
    return(d)
  }
  
  pairwise_distGeo = function(df){
    x = df[,c('Longitude', 'Latitude')]
    geo_d = apply(x, 1, .pairwise_distGeo, y=x)
    rescale_dist_mtx(as.dist(geo_d))
  }
  
  geo_d = pairwise_distGeo(geo)
  
  options(repr.plot.height=5, repr.plot.width=14)
  plot(hclust(geo_d), cex=0.4)
  
  
  # check by relabel with zoo name
  
  df.geo_d=as.matrix(geo_d, labels=TRUE)
  
  rownames(df.geo_d)
  head(zoo.cord)
  rownames(zoo.cord) = zoo.cord$NewID_Dada2Object
  reord.zoo.cord = zoo.cord[rownames(df.geo_d), ]
  sum(rownames(reord.zoo.cord) == colnames(df.geo_d)) #374
  str(geo_d)
  head(reord.zoo.cord)
  rownames(df.geo_d) = paste(rownames(reord.zoo.cord), reord.zoo.cord$Location)
  colnames(df.geo_d) = paste(colnames(reord.zoo.cord), reord.zoo.cord$Location)
  

#################################
# Ordering matrices  
#################################
  
  # microbiome: dist_Jaccard
  # location:   geo_d
  # host:       host_tree_d
  
  
  # ordering by beta-div metrix
  X = labels(dist_Jaccard)
  host_tree_d_o = dist_mtx_order(host_tree_d, X)
  geo_d_o = dist_mtx_order(geo_d, X)
  
  # check
  X %>% length %>% print                           # 368
  geo_d_o %>% labels %>% length %>% print          # 368
  host_tree_d_o %>% labels %>% length %>% print    # 368
  dist_Jaccard %>% labels %>% length %>% print          # 368
  
#################################
# MRM intra-spec sensitivity
#################################
  # renaming output
  rename_df = data.frame(old_name = c('m$geo', 'm$host_phy'),
                         new_name = c('Geography', 'Phylogeny'))
  
  # grouping samples by species
  df_grps = metadata %>% 
    filter(NewID_Dada2Object %in% labels(dist_Jaccard)) %>%
    dplyr::select(NewID_Dada2Object, Species_bestGuess)
  df_grps %>% head
  
  X = labels(dist_Jaccard)
  host_tree_d_o = dist_mtx_order(host_tree_d, X)
  geo_d_o = dist_mtx_order(geo_d, X)
  
  # creating subsample permutations of the distance matrices
  # list with the 3 dist-objects
  L = list(beta = dist_Jaccard,
           host_phy = host_tree_d_o,
           geo = geo_d_o)
  str(L)
  
  # number of permutated SpecD datasetst
  nperm_datasets = 100
  # number of permutations per MRM analysis
  nperm = 1000
  
  m_perm = lapply(as.list(1:nperm_datasets), function(x) one_per_group(L, df_grps, x))
  m_perm %>% length
  
  # MRM on each permutation (in parallel)
  #doParallel::registerDoParallel(threads)
  x = as.list(1:length(m_perm))
  f =  'm$beta ~ m$host_phy + m$geo' # 'm$beta ~  m$geo + m$host_phy'
  mrm_res = plyr::llply(x, mrm_each, L=m_perm, f=f, nperm=nperm, .parallel=F)
  mrm_res = do.call(rbind, mrm_res)
  mrm_res %>% head
  
  # summary of overall model
  mrm_res %>%
    distinct(R2, pval, rep) %>%
    summary
  
  # formatting results
  mrm_res_s = mrm_res %>% 
    filter(variable != 'Int') %>%
    gather(category, value, -variable, -R2, -pval, -F, -rep) %>%
    mutate(category = ifelse(category == 'coef', 'Coef.', 'Adj. P-value'))
  
  mrm_res_s = mrm_res_s %>%
    inner_join(rename_df, c('variable'='old_name')) %>%
    dplyr::select(-variable) %>%
    rename(c( new_name = 'variable'))
  head(mrm_res_s)
  
  p = ggplot(mrm_res_s, aes(variable, value)) +
    geom_boxplot() +
    facet_grid(category ~ ., scales='free_y') +
    theme_bw() +
    theme(plot.title = element_text(size = rel(5)),  # X and Y labels
          axis.text.x =element_text(size=30),
          axis.text.y =element_text(size=20)) +
    theme(                                          # the facet_grid labels
      strip.text.x = element_text(
        size = 34, color = "black", face = "bold"    #bold.italic
      ),
      strip.text.y = element_text(
        size = 24, color = "black", face = "bold"
      )
    ) + xlab("") + ylab("")
  
  options(repr.plot.width=5, repr.plot.height=3)
  plot(p)
  
  # save
  setwd(paste(path_illustrations, "MRM", sep = "/"))
  png(paste('MRM_boxplot_indD_location-and-host_jaccard.png', sep=''), width = 10, height = 15, units='in', family = "Helvetica", res=300)
  plot(p)
  dev.off()
  
  setwd(paste(path_illustrations, "0_Supplement_figures", sep = "/"))
  png(paste('MRM_boxplot_indD_location-and-host_jaccard.png', sep=''), width = 10, height = 15, units='in', family = "Helvetica", res=300)
  plot(p)
  dev.off()
  

  # phylogeny median coef
  table(mrm_res_s$variable)
  mrm_res_s.phylogeny.coef = subset(mrm_res_s,   variable == 'Phylogeny'  & category == 'Coef.')
  dim(mrm_res_s.phylogeny.coef)
  table(mrm_res_s.phylogeny.coef$category)
  median(mrm_res_s.phylogeny.coef$value)

  
  # Geo median coef
  mrm_res_s.Geography.coef = subset(mrm_res_s,   variable == 'Geography'  & category == 'Coef.')
  dim(mrm_res_s.Geography.coef)
  table(mrm_res_s.Geography.coef$category)
  median(mrm_res_s.Geography.coef$value)

  
  
  # significance

  # manual
      mrm_res.host_phy =subset(mrm_res, variable=='m$host_phy')
      median(mrm_res.host_phy$coef_pval)
      pval_sensitivity.host_phy = 1 - sum(mrm_res.host_phy$coef_pval < 0.05) / length(mrm_res.host_phy$pval)
      
      mrm_res.geo =subset(mrm_res, variable=='m$geo')
      median(mrm_res.geo$coef_pval)
      pval_sensitivity.geo = 1 - sum(mrm_res.geo$coef_pval < 0.05) / length(mrm_res.geo$pval)
      
      
      data.tab = as.data.frame(cbind('var' = c('host_phy', 'geo'), 'Coef.'=c(0, 0),  'pval_median'=c(0, 0), 
                                     'pval_q25'=c(0, 0),   'pval_q75'=c(0, 0), 'pval_sensitivity'=c(0, 0)))
      data.tab$pval_sensitivity = as.numeric(data.tab$pval_sensitivity)
      data.tab$Coef. = as.numeric(data.tab$Coef.)
      data.tab$pval_median = as.numeric(data.tab$pval_median)
      data.tab$pval_sensitivity = c(pval_sensitivity.host_phy, pval_sensitivity.geo)
      data.tab$Coef. = c( median(mrm_res_s.phylogeny.coef$value), median(mrm_res_s.Geography.coef$value))
      data.tab$pval_median = c(median(mrm_res.host_phy$coef_pval), median(mrm_res.geo$coef_pval))
      data.tab$pval_q25 = c(quantile(mrm_res.host_phy$coef_pval)[2], quantile(mrm_res.geo$coef_pval)[2])
      data.tab$pval_q75 = c(quantile(mrm_res.host_phy$coef_pval)[4], quantile(mrm_res.geo$coef_pval)[4])
      
      str(data.tab)
      mutate(data.tab, sig_pval_sensitivity = pval_sensitivity < 0.05)
      
      
  
  # save
  setwd(paste(path_results, "MRM", sep = "/"))
  sink('MRM_perm_indD_location-and-host_Jaccard.txt')
  
  mutate(data.tab, sig_pval_sensitivity = pval_sensitivity < 0.05)

  
  sink()
  
  
################### END
sessionInfo()
rm(list=ls())
