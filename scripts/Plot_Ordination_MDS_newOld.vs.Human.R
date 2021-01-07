
## get preped data 
source(file.path(path_scripts, "4_Taxa_IndVal_prep.data_biom.species_african.R"))

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
#           New World   Old World 
#   111        33          52 

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
# otu_table()   OTU Table:         [ 846 taxa and 351 samples ]
table(sample_data(ps.rowsum.uniqAnimal_biom.spe.fam)$new_genus_var)

# filter taxa
# This is nessesery to incure each taxa is found in at least 1 cluster in the IndVal analysis. After we subset to Hominidae this might not be the case.
ps.rowsum.uniqAnimal_biom.spe.fam.cmm = filter_taxa(ps.rowsum.uniqAnimal_biom.spe.fam, function(x) sum(x > 0.00) > (0.005*length(x)), TRUE) # note change from 1% to 0.5% of samples 
ps.rowsum.uniqAnimal_biom.spe.fam.cmm
# otu_table()   OTU Table:         [ 501 taxa and 351 samples ]


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

new_clust[new_clust == 'Hominidae - Homo - Africa'] = 'Hominidae - Homo - Guinea-Bissau'
new_clust[new_clust == 'Hominidae - Homo - Kiel'] = 'Hominidae - Homo - German'


sample_data(ps.rowsum.uniqAnimal_biom.spe.fam.sub1)$new_clust = new_clust


# PLOTS

#vare.cap = capscale(data.sub[,data.cap.genera] ~ 1, dist="bray", metaMDS = T)
vare.cap = capscale( (otu_table(ps.rowsum.uniqAnimal_biom.spe.fam.sub1)) ~ 1,  dist="bray", metaMDS = F)

#vare.cap = capscale( (otu_table(ps.rowsum.uniqAnimal)) ~ 1 + Condition(Tierpark),  dist="bray", metaMDS = F)

Total.eigntvalues = sum(as.numeric(vare.cap$CA$eig))
dbRDA1 = round((vare.cap$CA$eig[1] / Total.eigntvalues)*100, digits = 2)
dbRDA2 = round((vare.cap$CA$eig[2] / Total.eigntvalues)*100, digits = 2)
# https://stat.ethz.ch/pipermail/r-sig-ecology/2011-June/002183.html

# res.table
res.table = as.data.frame(matrix(nrow=nrow(sample_data(ps.rowsum.uniqAnimal_biom.spe.fam.sub1)), ncol=2))
names(res.table) = c('PC1', 'PC2')

dim(sample_data(ps.rowsum.uniqAnimal_biom.spe.fam.sub1))
dim(vare.cap$CA$u)

res.table$PC1 = vare.cap$CA$u[,1]
res.table$PC2 = vare.cap$CA$u[,2]

head(res.table)

Species = as.character( sample_data(ps.rowsum.uniqAnimal_biom.spe.fam.sub1)$new_clust)
length(table(Species))
## plotting the results without clustering
p_Species = ggplot(res.table, aes(x=PC1, y=PC2)) +  
  geom_point(aes(color=Species), size=3.5, stroke=1.4) + scale_color_manual(values=c("#5A5156", "#E4E1E3", "#F6222E", "#FE00FA", "#16FF32")) + #"#CC6677", "#AA4466", "#882255" "#FDBF6F", "#FF7F00"
  guides(colour=guide_legend(override.aes=list(size=6))) + #+ guides(shape=TRUE) +
  xlab(paste("PCoA1", dbRDA1, '%')) + ylab(paste("PCoA2", dbRDA2, '%')) +
  ggtitle("") + 
  scale_shape_manual(values = c(18,19:25)) + # manual control the shapes used, here I use numbers  scale_shape_manual(values=rep(c(21:25), times=8))
  theme_light(base_size=23) +
  #theme(axis.text.x=element_blank(), axis.text.y=element_blank()) +
  #scale_colour_brewer(palette = "set2") + 
  theme(legend.text=element_text(size=15), legend.position = "right", 
        legend.box = "vertical",  legend.title =element_text(size=12, face="bold")) # legend.direction = "vertical"

p_Species$labels$colour = "Host clade"
#p_Species$labels$shape = "Zoo"
p_Species

setwd( paste0(path_illustrations, '/Ordinations') )

## genera - order
png(paste('Ordination_CAP_NewOld.vs.human.png', sep=''), width = 15, height = 10, res=300, units="in", family="Helvetica") # width and height are in inches, and res is in pixels/inch
p_Species
dev.off()


setwd( paste0(path_illustrations, '/0_Main_figures') )

## genera - order
png(paste('Figure 5 - Ordination_CAP_NewOld.vs.human.png', sep=''), width = 15, height = 10, res=300, units="in", family="Helvetica") # width and height are in inches, and res is in pixels/inch
p_Species
dev.off()




