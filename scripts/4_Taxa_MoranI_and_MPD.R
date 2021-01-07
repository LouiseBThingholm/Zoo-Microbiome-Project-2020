rm(list=ls())

# COMMUNITY DATA

ps.rowsum = readRDS( file.path(path_data_processed, "Zoo.rowsum_spe.rds"))
ps.rowsum
taxa_names(ps.rowsum) <- paste0("ASV-", 1:length(taxa_names(ps.rowsum)))

# select one sample per animal (as some animals had multiple samples collected)

listIDs_onPerAnimal = c("TieG003", "TieG024", "TieG017", "TieG022", "TieG008", "TieG023", "TieG002", "TieG004", "TieG012", "TieG009", "TieG019", "TieG031", "TieG032", "TieG020", "TieG021", "TieG025", "TieG016", "TieG066", "TieG054", "TieG052", "TieG065", "TieG062", "TieG063", "TieG064", "TieG051", "TieG038", "TieG037", "TieG041", "TieG039", "TieG040", "TieG061", "TieG140", "TieG147", "TieG067", "TieG143", "TieG149", "TieG076", "TieG075", "TieG078", "TieG124", "TieG121", "TieG122", "TieG125", "TieG101", "TieG102", "TieG128", "TieG126", "TieG105", "TiH017", "TiH023", "TiH025", "TiH010", "TiA033", "TiA018", "TiA045", "TiA038", "TiA029", "TiA016", "TiA034", "TiA044", "TiA021", "TiA013", "TiA024", "TiA031", "TiA032", "TiA026", "TiA025", "TiA039", "TiA030", "TiA022", "TiA040", "TiA006", "TiA035", "TiA007", "TiA015", "TiB002", "TiB022", "TieG119", "TiA046", "ZOL010", "ZOL011", "TieG034", "ZOL012", "Til017", "TiH001", "TiB037", "TieG013", "ZOL013", "TieG112", "TieG055", "TieG015", "TieG060", "ZOL002", "Til006", "TieG110", "ZOL003", "TieG097", "TieG096", "TiA010", "NecBac", "TieG070", "TieG085", "TieG086", "TieG082", "TieG077", "TieG050", "Til033", "TiA011", "Til004", "TieG104", "TieG106", "ZOL004", "Til038", "ZOL005", "TiB029", "Til031", "Til039", "Til025", "Til020", "TiA001", "TiB080", "TiA023", "TieG092", "TieG036", "Til014", "TiA003", "ZOL014", "TieG111", "TiB079", "TiB063", "TieG088", "TieG069", "TieG079", "TieG093", "TieG071", "TieG074", "TieG115", "TieG089", "TieG027", "Til009", "TiN011", "Til019", "Til016", "TieG053", "TiB052", "Til007", "Til022", "TiH019", "TieG095", "TieG099", "Til005", "TieG057", "TieG058", "TieG030", "TieG118", "Til013", "TiH012", "Til029", "TiA017", "Til018", "TieG109", "TieG098", "TieG107", "Til012", "ZOL006", "Til001", "TiA012", "TiB044", "TieG114", "TieG006", "TieG113", "TieG127", "Til032", "Til044", "Til011", "Til030", "Til034", "Til015", "TiA019", "TieG090", "ZOL007", "TiB075", "ZOL008St", "TiA008", "TieG035", "Til008", "TiN086", "TiN036", "TiN071", "TiN055", "TiN087", "TiN056", "TiN031", "TiN079", "TiN083", "TiN053", "TiN080", "TiN058", "TiN078", "TiN093", "TiN023", "TiN091", "TiN049", "TiN067", "TiN096", "TiN029", "TiN066", "TiN050", "TiN048", "TiN024", "TiN094", "TiN097", "TiN068", "TiN022", "TiN064", "TiN075", "TiN041", "TiN044", "TiN046", "TiN072", "TiN051", "TiN054", "TiN052", "TiN035", "TiN033", "TiN085", "TiN084", "TiN081", "TiN082", "TiN099", "TiN090", "TiN028", "TiN095", "TiN040", "TiN069", "TiN100", "TiN074", "TiN061", "TiN062", "TiN030", "TiN098", "TiN047", "TiN073", "TiN043", "TiN092", "TiN042", "TiN063", "TiN045", "TiN027", "TiN088", "TiN026", "TiN060", "TiN039", "TiN038", "TiN021", "TiN065", "TiN059", "TiN057", "TiN025", "TiN076", "TiN037", "TiN089", "TiB058", "TiB077", "TiB007", "TiB071", "TiB018", "TiB042", "TiB053", "TiB047", "TiB011", "TiB026", "TiB040", "TiB060", "TiB054", "TiB059", "TiB061", "TiB027", "TiB051", "TiB064", "TiB038", "TiB028", "TiB045", "TiB001", "TiB009", "TiB010", "TiB024", "TiB015", "TiB025", "TiB030", "TiB076", "TiB003", "TiB008", "TiB073", "TiB004", "TiB017", "TiB062", "TiB013", "TiB014", "TiB019", "TiB012", "TiH006", "Til040", "Til002", "Til027", "Til041", "TiH004", "TieG116", "Til010", "TiH007", "Til043", "TieG056", "Til026", "TieG026", "Til023", "TieG028", "TieG103", "TiH016", "TiB020", "Til036", "TiH008", "ZOL009", "TiA041", "TiA005", "TiA004", "TiN001", "TieG123", "Til035", "TieG029", "TieG080", "TiA009", "ZOL001", "TieG108", "Til024", "Til042", "Til021")
length(listIDs_onPerAnimal)
# add humans
listID_human = c("EMGE001", "EMGE002", "EMGE004", "EMGE005", "EMGE006", "EMGE007", "EMGE012", "EMGE015", "EMGE017", "EMGE020", "EMGE024", "EMGE027", "EMGE028", "EMGE041", "EMGE042", "EMGE045", "EMGE049", "EMGE050", "EMGE051", "EMGE056", "EMGE068", "EMGE072", "EMGE088", "EMGE094", "EMGE098", "EMGE103", "EMGE108", "EMGE110", "EMGE112", "EMGE121", "EMGE127", "EMGE129", "EMGE140", "EMGE143", "EMGE144", "EMGE145", "EMGE147", "EMGE149", "EMGE151", "EMGE154", "EMGE159", "EMGE160", "EMGE162", "EMGE165")
listIDs_onPerAnimal_and_human = c(listIDs_onPerAnimal, listID_human)

ps.rowsum.uniqAnimal = subset_samples(ps.rowsum, Verschickungscode %in% listIDs_onPerAnimal_and_human)
ps.rowsum.uniqAnimal
# otu_table()   OTU Table:         [ 1381 taxa and 368 samples ]

# RECODE HOST SPECIES
# recode host species to match host-phylogeny file (best guess species names)
names(sample_data(ps.rowsum.uniqAnimal))
species.latin = as.character(sample_data(ps.rowsum.uniqAnimal)$Species..latein.)
#same as
# get_variable(ps.rowsum.uniqAnimal, "Species..latein.")
length(table(species.latin)) #38

species.latin[species.latin=="Bos primigenius f. taurus"] <- "Bos primigenius"
species.latin[species.latin=="Camelus ferus f. bactrianus"] <- "Camelus ferus"
species.latin[species.latin=="Capra aegagrus f. hircus"] <- "Capra aegagrus"
species.latin[species.latin=="Equus quagga"] <- "Equus burchellii" # just the former name

species.latin[species.latin=="Equus asinus f. asinus"] <- "Equus asinus" # miniature is not in the system
species.latin[species.latin=="Equus ferus"] <- "Equus caballus" # I cannot find a better species level name that is in the system
species.latin[species.latin=="Macropus eugenii or rufogriseus"] <- "Macropus eugenii"
species.latin[species.latin=="Taurotragus oryx"] <- "Tragelaphus oryx"

length(table(species.latin)) # 39
# who is in tree but not in microbiome data?
tree.nodes = c("Alces alces", "Bos primigenius", "Callithrix jacchus", "Camelus ferus", "Capra aegagrus", "Cercopithecus diana", "Equus asinus", "Equus burchellii", "Equus caballus", "Euphractus sexcinctus", "Homo sapiens", "Hylobates lar", "Lemur catta", "Lophocebus aterrimus", "Macaca sylvanus", "Macaca nigra", "Macropus eugenii", "Mandrillus leucophaeus", "Mandrillus sphinx", "Nasua nasua", "Ovis aries", "Pan troglodytes", "Pan paniscus", "Papio hamadryas", "Pithecia pithecia", "Pongo abelii", "Procyon lotor", "Rangifer tarandus", "Saguinus oedipus", "Saguinus midas", "Saguinus labiatus", "Saguinus imperator", "Saimiri sciureus", "Suricata suricatta", "Sus scrofa", "Tapirus terrestris", "Tragelaphus oryx", "Ursus americanus", "Ursus maritimus", "Varecia rubra", "Vicugna pacos")
tree.nodes[!tree.nodes %in% species.latin]
# "Euphractus sexcinctus" "Pithecia pithecia"  
# two species with only one microbiome sample -- filtered out privously in data processing?

sample_data(ps.rowsum.uniqAnimal)$Species_bestGuess = as.factor(species.latin)
head(sample_data(ps.rowsum.uniqAnimal))

# add phenotypic variables to ps.rowsum.uniqAnimal

ps = ps.rowsum.uniqAnimal
source(file.path(path_scripts, '1_data_add.pheno.variables.R') )
ps.rowsum.uniqAnimal = ps
head(sample_data(ps.rowsum.uniqAnimal))


## community data :

comm = as.data.frame(  otu_table(ps.rowsum.uniqAnimal) )
class(comm)

rownames(comm) # SAMPLES
head(colnames(comm)) # SPECIES (BUGS)


# TRAIT DATA
# note it is sample-traits not microbe-species traits as the guide uses
# for now that is alpha-diversity
setwd(path_data)

traits = read.table("alpha.div.matrix.meta.txt", 
                    header = T, sep='\t')
# take a peek at the data
head(traits)
pairs(traits[, c("Shannon_div", "Simpson_div", "Richness", "Pileous_Evenness",      "ACE",     "Chao")])

sum(rownames(comm) %in% traits$NewID_Dada2Object) #374
rownames(traits) = traits$NewID_Dada2Object

# Metadata
metadata <- sample_data(ps.rowsum.uniqAnimal)
# take a peek at the data
head(metadata)

# Phylogeny
# If you have a phylogeny in the commonly used Newick or Nexus format it can be imported into R 
# with the read.tree or read.nexus functions.

# full host tree of all 41 unique species in dataset
host_tree_file = file.path(path_github_data, '/unique_species_latin_best-guess_V4_n42.nwk')
# host tree
phylo.obj = read.tree(host_tree_file)
phylo.obj
# rooted tree?
ape::is.rooted(phylo.obj)
class(phylo.obj)


# list the elements of our phylogeny
names(phylo.obj)
# what are the first few tip labels?
phylo.obj$tip.label[1:5]
# how many tips does our phylogeny have?
Ntip(phylo.obj)
# plot our phylogeny (the cex argument makes the labels small enough to
# read)
plot(phylo.obj, cex = 0.7)



## Cleaning and matching data sets ##########

# Microbime Overlap with host tree
# in host tree, but not in 16S microbiome data?
setdiff(phylo.obj$tip.label, as.character( sample_data(ps.rowsum.uniqAnimal)$Species_bestGuess )) %>% print

# replace space with _
sample_data(ps.rowsum.uniqAnimal)$Species_bestGuess = sub(" ", "_", as.character( sample_data(ps.rowsum.uniqAnimal)$Species_bestGuess )  )
setdiff(phylo.obj$tip.label, as.character( sample_data(ps.rowsum.uniqAnimal)$Species_bestGuess ) ) %>% print

# Filtering host tree
to_rm = setdiff(phylo.obj$tip.label, as.character( sample_data(ps.rowsum.uniqAnimal)$Species_bestGuess ) ) 
phy_prn = drop.tip(phylo.obj, to_rm)
phy_prn

# plotting tree
options(repr.plot.width=6, repr.plot.height=15)
par(mfrow=c(1,1))
plot(phy_prn, no.margin=TRUE, cex=0.8)

# Expanding host tree tips
# Many host species has more than one animal sampled. Add these additional samples to the tree.

# tip label <--> node id
df_nodes = data.frame(label = phy_prn$tip.label,
                      node = 1:length(phy_prn$tip.label))
# adding all host_subj_id (merging metadata 'IDs' with the host-species info)
metadata=as.data.frame(as.matrix(sample_data(ps.rowsum.uniqAnimal)))

#df_nodes$label =  as.character( df_nodes$label)
#metadata$NewID_Dada2Object =metadata$NewID_Dada2Object

typeof(df_nodes)
typeof(metadata)
head(metadata)
df_nodes = df_nodes %>%
  inner_join(metadata %>% dplyr::select(NewID_Dada2Object, Species_bestGuess), c('label'='Species_bestGuess')) %>% # take the two relevant columns in metadata
  as.data.frame
# Warning message:
# Column `label`/`Species_bestGuess` has different attributes on LHS and RHS of join 
head(df_nodes, n=10)

# adding new tips
tree_exp = phy_prn
map_tmp = metadata 

traits[1:4,1:3]
sum(rownames(traits) %in% df_nodes$NewID_Dada2Object)

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
# Phylogenetic tree with 368 tips and 71 internal nodes.

# plotting tree
options(repr.plot.width=6, repr.plot.height=14)
plot(tree_exp, no.margin=TRUE, cex=0.4)


# SUBSET TRAIT DATA TO 2 ALPHA DIV VARIABLES, and merge with meta data
names(traits)

rownames(metadata) = as.character( metadata[, "NewID_Dada2Object"])
all.equal(rownames(traits), rownames(metadata)) # check data is in same order
metadata <- metadata[rownames(traits), ]
all.equal(rownames(traits), rownames(metadata))

# add alpha div to meta data
metadata = merge(metadata, traits[, c("Shannon_div","Chao")], by=0)
dim(metadata)

# check for mismatches/missing samples or microbe-species, depending on what we are analyzing

# NOTE it expects the tree to represent the microbial-taxa (column names in comm).
# but our tree is for hosts (rows in comm)
comm.t = t(comm)
combined <- match.phylo.comm(tree_exp, comm.t)
combined$phy

phylo.obj <- combined$phy
comm <- combined$comm
as.matrix(comm)[1:4,1:4] # taxa as rows

# We should do the matching for our trait data.

metadata[1:3,1:4]
rownames(metadata) = metadata$Row.names
combined <- match.phylo.data(phylo.obj, metadata)
# the resulting object is a list with $phy and $data elements.  replace our
# original data with the sorted/matched data
str(combined)
phylo.obj <- combined$phy
metadata <- combined$data
phylo.obj
dim(metadata)

metadata$Shannon_div  = as.numeric( as.character( metadata$Shannon_div ) )
metadata$Chao  = as.numeric( as.character( metadata$Chao ) )


## phylogenetic relatedness od single taxa
 
 # We use MPD. We use this and not FD, because we want to correct for the phylogenetic pattern of richness:
 
 
 ## linear regression on bug was used to regress out the effects of location, and 
 #   the residuals were used for tests
 
 comm_bi=comm
 #comm_bi[comm>0]<-1
 comm.bi.t=t(comm_bi)
 comm.bi.t[1:4,1:4]
 metadata[1:4,1:4]
 meta.comm.bi = merge(metadata, comm.bi.t, by=0)
 meta.comm.bi[1:4,1:4]
 meta.comm.bi_res = meta.comm.bi
 
 # t='ASV-20'
 for (t in rownames(comm)  ){
   
   glm.obj = lm(  sqrt(meta.comm.bi[, t])  ~ meta.comm.bi$Tierpark )
    summary(glm.obj)
    meta.comm.bi_res[, t] = residuals(glm.obj)
 
  par(mfrow=c(2,1), oma=c(3,3,2,2), mar=c(3,3,2,2))
   plot(density(meta.comm.bi[, t]))
   plot(density(meta.comm.bi_res[, t]))
   
 }
 
 rownames(meta.comm.bi_res) = meta.comm.bi_res$Row.names
 comm_cor = meta.comm.bi_res[, rownames(comm)  ]
 metadata_cor = meta.comm.bi_res[, colnames(metadata)  ]
 
 comm_cor[1:4,1:4]
 metadata_cor[1:4,1:4]
 
 combined <- match.phylo.data(phylo.obj, (comm_cor))
 # the resulting object is a list with $phy and $data elements.  replace our
 # original data with the sorted/matched data
 str(combined)
 phylo.obj <- combined$phy
 comm_cor <- combined$data
 
 # convert phylogenety to a distance matrix
 phy.dist <- cophenetic(phylo.obj)
 as.matrix(phy.dist)[1:4,1:4]
 
 # include only taxa observed in at least 5 samples
 comm_cor[1:4,1:4]
 comm_cor.t=t(comm_cor)
 
 comm_tmp = comm 
 comm_tmp[comm>0]<-1
 comm_tmp[1:4,1:4]
 
 comm.t = t(comm); comm.t[1:4,1:4]
 
 sum(rowSums(comm_tmp) > 5)
 comm_tmp = comm_tmp[ rowSums(comm_tmp) > 5 , ]
 dim(comm_tmp)
 comm_cor_ab = comm_cor.t[ rownames(comm_cor.t) %in% rownames(comm_tmp) , ]
 comm_cor_ab[1:4,1:4]
 
 
 # calculate ses.mpd
 comm.sesmpd <- ses.mpd(comm_cor_ab, phy.dist, null.model = "richness", abundance.weighted = T, 
                        runs = 999)

 sum(is.na(comm.sesmpd$mpd.obs.p)) # 0
 
 head(comm.sesmpd)
 tail(comm.sesmpd, n=10)
 
 head(comm.sesmpd[order(comm.sesmpd$mpd.obs.p),], n=10 )
 sum(comm.sesmpd$mpd.obs.p < 0.05)
 
 par(mar=c(3,3,3,3))
 plot(comm.sesmpd$ntaxa,  comm.sesmpd$mpd.obs.p)
 
 comm.sesmpd$mpd.obs.p.adj = p.adjust(comm.sesmpd$mpd.obs.p, method = 'BH')
 head(comm.sesmpd[order(comm.sesmpd$mpd.obs.p),], n=10 )
 sum(comm.sesmpd$mpd.obs.p.adj < 0.05)
 sum(comm.sesmpd$mpd.obs.p.adj < 0.05) / nrow(comm.sesmpd) *100 # percentage of ASVs that show phylogenetic association
 
 taxa_annotation = as.data.frame(tax_table(ps.rowsum.uniqAnimal ))
 head(taxa_annotation)
  
 comm.sesmpd_anno = merge(comm.sesmpd, taxa_annotation, by=0)
 head(comm.sesmpd_anno)
 names(comm.sesmpd_anno)[1] = 'ASV_ID'
 
 comm.sesmpd_anno_signif = comm.sesmpd_anno[ comm.sesmpd_anno$mpd.obs.p.adj < 0.05 ,  ]
 dim(comm.sesmpd_anno_signif)
 table(comm.sesmpd_anno_signif$Order)
 
 table(comm.sesmpd_anno_signif$Class) / table(comm.sesmpd_anno$Class) *100
 table(comm.sesmpd_anno_signif$Phylum) / table(comm.sesmpd_anno$Phylum) *100
 
 # prevotella
 comm.sesmpd_anno$Genus[comm.sesmpd_anno$Genus == 'Prevotella']
 
 comm.sesmpd_anno_sub = comm.sesmpd_anno[ !is.na( comm.sesmpd_anno$Genus ) , ]
 comm.sesmpd_anno_sub[ comm.sesmpd_anno_sub$Genus == 'Prevotella', ]
 
 # Spirochaetes
 comm.sesmpd_anno$Phylum[comm.sesmpd_anno$Phylum == 'Spirochaetes']
 
 comm.sesmpd_anno_sub = comm.sesmpd_anno[ !is.na( comm.sesmpd_anno$Phylum ) , ]
 comm.sesmpd_anno_sub[ comm.sesmpd_anno_sub$Phylum == 'Spirochaetes', ]
 

 # SAVE results
 setwd(path_table)
 write.table(comm.sesmpd_anno, 'TAXA_sesmpd_species.n536.txt', col.names = T, row.names = F, quote = F, sep='\t')
 
 
 
