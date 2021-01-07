
# BETA DIVERSITET
source(file.path(path_scripts, "1_MASTERFILE.R") )
source(file.path(path_scripts, "functions/small_functions.R") )

ps.rowsum_glom = readRDS( file.path(path_data, "16S_DADA2_processed/Zoo.rowsum_spe.rds"))
ps.rowsum_glom
# otu_table()   OTU Table:         [ 1381 taxa and 417 samples ]

listIDs_onPerAnimal = c("TieG003", "TieG024", "TieG017", "TieG022", "TieG008", "TieG023", "TieG002", "TieG004", "TieG012", "TieG009", "TieG019", "TieG031", "TieG032", "TieG020", "TieG021", "TieG025", "TieG016", "TieG066", "TieG054", "TieG052", "TieG065", "TieG062", "TieG063", "TieG064", "TieG051", "TieG038", "TieG037", "TieG041", "TieG039", "TieG040", "TieG061", "TieG140", "TieG147", "TieG067", "TieG143", "TieG149", "TieG076", "TieG075", "TieG078", "TieG124", "TieG121", "TieG122", "TieG125", "TieG101", "TieG102", "TieG128", "TieG126", "TieG105", "TiH017", "TiH023", "TiH025", "TiH010", "TiA033", "TiA018", "TiA045", "TiA038", "TiA029", "TiA016", "TiA034", "TiA044", "TiA021", "TiA013", "TiA024", "TiA031", "TiA032", "TiA026", "TiA025", "TiA039", "TiA030", "TiA022", "TiA040", "TiA006", "TiA035", "TiA007", "TiA015", "TiB002", "TiB022", "TieG119", "TiA046", "ZOL010", "ZOL011", "TieG034", "ZOL012", "Til017", "TiH001", "TiB037", "TieG013", "ZOL013", "TieG112", "TieG055", "TieG015", "TieG060", "ZOL002", "Til006", "TieG110", "ZOL003", "TieG097", "TieG096", "TiA010", "NecBac", "TieG070", "TieG085", "TieG086", "TieG082", "TieG077", "TieG050", "Til033", "TiA011", "Til004", "TieG104", "TieG106", "ZOL004", "Til038", "ZOL005", "TiB029", "Til031", "Til039", "Til025", "Til020", "TiA001", "TiB080", "TiA023", "TieG092", "TieG036", "Til014", "TiA003", "ZOL014", "TieG111", "TiB079", "TiB063", "TieG088", "TieG069", "TieG079", "TieG093", "TieG071", "TieG074", "TieG115", "TieG089", "TieG027", "Til009", "TiN011", "Til019", "Til016", "TieG053", "TiB052", "Til007", "Til022", "TiH019", "TieG095", "TieG099", "Til005", "TieG057", "TieG058", "TieG030", "TieG118", "Til013", "TiH012", "Til029", "TiA017", "Til018", "TieG109", "TieG098", "TieG107", "Til012", "ZOL006", "Til001", "TiA012", "TiB044", "TieG114", "TieG006", "TieG113", "TieG127", "Til032", "Til044", "Til011", "Til030", "Til034", "Til015", "TiA019", "TieG090", "ZOL007", "TiB075", "ZOL008St", "TiA008", "TieG035", "Til008", "TiN086", "TiN036", "TiN071", "TiN055", "TiN087", "TiN056", "TiN031", "TiN079", "TiN083", "TiN053", "TiN080", "TiN058", "TiN078", "TiN093", "TiN023", "TiN091", "TiN049", "TiN067", "TiN096", "TiN029", "TiN066", "TiN050", "TiN048", "TiN024", "TiN094", "TiN097", "TiN068", "TiN022", "TiN064", "TiN075", "TiN041", "TiN044", "TiN046", "TiN072", "TiN051", "TiN054", "TiN052", "TiN035", "TiN033", "TiN085", "TiN084", "TiN081", "TiN082", "TiN099", "TiN090", "TiN028", "TiN095", "TiN040", "TiN069", "TiN100", "TiN074", "TiN061", "TiN062", "TiN030", "TiN098", "TiN047", "TiN073", "TiN043", "TiN092", "TiN042", "TiN063", "TiN045", "TiN027", "TiN088", "TiN026", "TiN060", "TiN039", "TiN038", "TiN021", "TiN065", "TiN059", "TiN057", "TiN025", "TiN076", "TiN037", "TiN089", "TiB058", "TiB077", "TiB007", "TiB071", "TiB018", "TiB042", "TiB053", "TiB047", "TiB011", "TiB026", "TiB040", "TiB060", "TiB054", "TiB059", "TiB061", "TiB027", "TiB051", "TiB064", "TiB038", "TiB028", "TiB045", "TiB001", "TiB009", "TiB010", "TiB024", "TiB015", "TiB025", "TiB030", "TiB076", "TiB003", "TiB008", "TiB073", "TiB004", "TiB017", "TiB062", "TiB013", "TiB014", "TiB019", "TiB012", "TiH006", "Til040", "Til002", "Til027", "Til041", "TiH004", "TieG116", "Til010", "TiH007", "Til043", "TieG056", "Til026", "TieG026", "Til023", "TieG028", "TieG103", "TiH016", "TiB020", "Til036", "TiH008", "ZOL009", "TiA041", "TiA005", "TiA004", "TiN001", "TieG123", "Til035", "TieG029", "TieG080", "TiA009", "ZOL001", "TieG108", "Til024", "Til042", "Til021")
length(listIDs_onPerAnimal) #336
# add humans
listID_human = c("EMGE001", "EMGE002", "EMGE004", "EMGE005", "EMGE006", "EMGE007", "EMGE012", "EMGE015", "EMGE017", "EMGE020", "EMGE024", "EMGE027", "EMGE028", "EMGE041", "EMGE042", "EMGE045", "EMGE049", "EMGE050", "EMGE051", "EMGE056", "EMGE068", "EMGE072", "EMGE088", "EMGE094", "EMGE098", "EMGE103", "EMGE108", "EMGE110", "EMGE112", "EMGE121", "EMGE127", "EMGE129", "EMGE140", "EMGE143", "EMGE144", "EMGE145", "EMGE147", "EMGE149", "EMGE151", "EMGE154", "EMGE159", "EMGE160", "EMGE162", "EMGE165")
length(listID_human) #44
listIDs_onPerAnimal_and_human = c(listIDs_onPerAnimal, listID_human)

length(listIDs_onPerAnimal_and_human) # 380

ps.rowsum.uniqAnimal = subset_samples(ps.rowsum_glom, Verschickungscode %in% listIDs_onPerAnimal_and_human)
ps.rowsum.uniqAnimal
# phyloseq-class experiment-level object
# otu_table()   OTU Table:         [ 1381 taxa and 368 samples ]

# RECODE HOST SPECIES
# recode host species to match host-phylogeny file (best guess species names)
names(sample_data(ps.rowsum.uniqAnimal))
species.latin = as.character(sample_data(ps.rowsum.uniqAnimal)$Species..latein.)
#same as
# get_variable(ps.rowsum.uniqAnimal, "Tierart..latein.")
length(table(species.latin))#38

species.latin[species.latin=="Bos primigenius f. taurus"] <- "Bos primigenius"
species.latin[species.latin=="Camelus ferus f. bactrianus"] <- "Camelus ferus"
species.latin[species.latin=="Capra aegagrus f. hircus"] <- "Capra aegagrus"
species.latin[species.latin=="Equus quagga"] <- "Equus burchellii" # just the former name

species.latin[species.latin=="Equus asinus f. asinus"] <- "Equus asinus" # miniature is not in the system
species.latin[species.latin=="Equus ferus"] <- "Equus caballus" # I cannot find a better species level name that is in the system
species.latin[species.latin=="Macropus eugenii or rufogriseus"] <- "Macropus eugenii"
species.latin[species.latin=="Taurotragus oryx"] <- "Tragelaphus oryx"

length(table(species.latin)) # 38
# who is in tree but not in microbiome data?
tree.nodes = c("Macropus parryi", "Alces alces", "Bos primigenius", "Callithrix jacchus", "Camelus ferus", "Capra aegagrus", "Cercopithecus diana", "Equus asinus", "Equus burchellii", "Equus caballus", "Euphractus sexcinctus", "Homo sapiens", "Hylobates lar", "Lemur catta", "Lophocebus aterrimus", "Macaca sylvanus", "Macaca nigra", "Macropus eugenii", "Mandrillus leucophaeus", "Mandrillus sphinx", "Nasua nasua", "Ovis aries", "Pan troglodytes", "Pan paniscus", "Papio hamadryas", "Pithecia pithecia", "Pongo abelii", "Procyon lotor", "Rangifer tarandus", "Saguinus oedipus", "Saguinus midas", "Saguinus labiatus", "Saguinus imperator", "Saimiri sciureus", "Suricata suricatta", "Sus scrofa", "Tapirus terrestris", "Tragelaphus oryx", "Ursus americanus", "Ursus maritimus", "Varecia rubra", "Vicugna pacos")
tree.nodes[!tree.nodes %in% species.latin]
# "Macropus parryi"       "Euphractus sexcinctus" "Macropus eugenii"      "Pithecia pithecia"  
# two species with only one microbiome sample -- filtered out privously in data processing
# and the kangatures

sample_data(ps.rowsum.uniqAnimal)$Species_bestGuess = as.factor(species.latin)
head(sample_data(ps.rowsum.uniqAnimal))

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

dist_BC = vegdist(otu_table(ps.rowsum.uniqAnimal), method="bray")

# # status on BC dissimilarity matrix
summary(as.vector(dist_BC))

#########################
# Host phylogeny
#########################
# full host tree of all 41 unique species in dataset
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
# [1] "Macropus_parryi"       "Macropus_eugenii"      "Pithecia_pithecia"     "Euphractus_sexcinctus"

# in 16S microbiome data, but not in host tree (PROBLEM!)
setdiff(as.character( sample_data(ps.rowsum.uniqAnimal)$Species_bestGuess ), host_tree$tip.label) %>% print
# character(0)

# Filtering host tree
to_rm = setdiff(host_tree$tip.label, as.character( sample_data(ps.rowsum.uniqAnimal)$Species_bestGuess ) ) 
host_tree_prn = drop.tip(host_tree, to_rm)
host_tree_prn
# Phylogenetic tree with 38 tips and 37  internal nodes.

# plotting tree
options(repr.plot.width=6, repr.plot.height=15)
par(mfrow=c(1,1))
plot(host_tree_prn, no.margin=TRUE, cex=0.8)

str(host_tree_prn)
host_tree_prn$tip.label

setwd(path_illustrations)
png(paste('Tree.Host.Species_n38_horizontal.png', sep=''), width = 20, height = 30, res=75, units="in", family="Helvetica") # width and height are in inches, and res is in pixels/inch
par(mar=c(5,25,2,28), xpd=TRUE)
plot(host_tree_prn, no.margin=TRUE, cex=1.5)

dev.off()      


################### END
sessionInfo()

#rm(list=ls())

