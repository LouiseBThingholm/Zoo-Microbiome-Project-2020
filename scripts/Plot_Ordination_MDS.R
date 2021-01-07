
# Visualization -- Beta diversity / ordination evaluation

# DATA
    
    ps.rowsum = readRDS(file.path(path_data, "16S_DADA2_processed/Zoo.rowsum_spe.rds"))
    ps.rowsum
    
    #Remove taxa 
    #This protects against an OTU with small mean & trivially large C.V.
    ps.rowsum.gen.cmm = filter_taxa(ps.rowsum, function(x) sum(x > 0.00) > (0.01*length(x)), TRUE)
    ps.rowsum.gen.cmm
    ps.rowsum = ps.rowsum.gen.cmm
    
    
    table((sample_data(ps.rowsum)$Family ))
    
    # select one sample per animal, removing animals that only have one sample per order-level group
    
    table(sample_data(ps.rowsum)$Order)
    table(sample_data(ps.rowsum)$Family)
    
    # list Verschickungscode for selected animal-uniq sample from "Meta_one-sample-per-animal_ManuallySelected.txt"
    listIDs_onPerAnimal = c("TieG003", "TieG024", "TieG017", "TieG022", "TieG008", "TieG023", "TieG002", "TieG004", "TieG012", "TieG009", "TieG019", "TieG031", "TieG032", "TieG020", "TieG021", "TieG025", "TieG016", "TieG066", "TieG054", "TieG052", "TieG065", "TieG062", "TieG063", "TieG064", "TieG051", "TieG038", "TieG037", "TieG041", "TieG039", "TieG040", "TieG061", "TieG140", "TieG147", "TieG067", "TieG143", "TieG149", "TieG076", "TieG075", "TieG078", "TieG124", "TieG121", "TieG122", "TieG125", "TieG101", "TieG102", "TieG128", "TieG126", "TieG105", "TiH017", "TiH023", "TiH025", "TiH010", "TiA033", "TiA018", "TiA045", "TiA038", "TiA029", "TiA016", "TiA034", "TiA044", "TiA021", "TiA013", "TiA024", "TiA031", "TiA032", "TiA026", "TiA025", "TiA039", "TiA030", "TiA022", "TiA040", "TiA006", "TiA035", "TiA007", "TiA015", "TiB002", "TiB022", "TieG119", "TiA046", "ZOL010", "ZOL011", "TieG034", "ZOL012", "Til017", "TiH001", "TiB037", "TieG013", "ZOL013", "TieG112", "TieG055", "TieG015", "TieG060", "ZOL002", "Til006", "TieG110", "ZOL003", "TieG097", "TieG096", "TiA010", "NecBac", "TieG070", "TieG085", "TieG086", "TieG082", "TieG077", "TieG050", "Til033", "TiA011", "Til004", "TieG104", "TieG106", "ZOL004", "Til038", "ZOL005", "TiB029", "Til031", "Til039", "Til025", "Til020", "TiA001", "TiB080", "TiA023", "TieG092", "TieG036", "Til014", "TiA003", "ZOL014", "TieG111", "TiB079", "TiB063", "TieG088", "TieG069", "TieG079", "TieG093", "TieG071", "TieG074", "TieG115", "TieG089", "TieG027", "Til009", "TiN011", "Til019", "Til016", "TieG053", "TiB052", "Til007", "Til022", "TiH019", "TieG095", "TieG099", "Til005", "TieG057", "TieG058", "TieG030", "TieG118", "Til013", "TiH012", "Til029", "TiA017", "Til018", "TieG109", "TieG098", "TieG107", "Til012", "ZOL006", "Til001", "TiA012", "TiB044", "TieG114", "TieG006", "TieG113", "TieG127", "Til032", "Til044", "Til011", "Til030", "Til034", "Til015", "TiA019", "TieG090", "ZOL007", "TiB075", "ZOL008St", "TiA008", "TieG035", "Til008", "TiN086", "TiN036", "TiN071", "TiN055", "TiN087", "TiN056", "TiN031", "TiN079", "TiN083", "TiN053", "TiN080", "TiN058", "TiN078", "TiN093", "TiN023", "TiN091", "TiN049", "TiN067", "TiN096", "TiN029", "TiN066", "TiN050", "TiN048", "TiN024", "TiN094", "TiN097", "TiN068", "TiN022", "TiN064", "TiN075", "TiN041", "TiN044", "TiN046", "TiN072", "TiN051", "TiN054", "TiN052", "TiN035", "TiN033", "TiN085", "TiN084", "TiN081", "TiN082", "TiN099", "TiN090", "TiN028", "TiN095", "TiN040", "TiN069", "TiN100", "TiN074", "TiN061", "TiN062", "TiN030", "TiN098", "TiN047", "TiN073", "TiN043", "TiN092", "TiN042", "TiN063", "TiN045", "TiN027", "TiN088", "TiN026", "TiN060", "TiN039", "TiN038", "TiN021", "TiN065", "TiN059", "TiN057", "TiN025", "TiN076", "TiN037", "TiN089", "TiB058", "TiB077", "TiB007", "TiB071", "TiB018", "TiB042", "TiB053", "TiB047", "TiB011", "TiB026", "TiB040", "TiB060", "TiB054", "TiB059", "TiB061", "TiB027", "TiB051", "TiB064", "TiB038", "TiB028", "TiB045", "TiB001", "TiB009", "TiB010", "TiB024", "TiB015", "TiB025", "TiB030", "TiB076", "TiB003", "TiB008", "TiB073", "TiB004", "TiB017", "TiB062", "TiB013", "TiB014", "TiB019", "TiB012", "TiH006", "Til040", "Til002", "Til027", "Til041", "TiH004", "TieG116", "Til010", "TiH007", "Til043", "TieG056", "Til026", "TieG026", "Til023", "TieG028", "TieG103", "TiH016", "TiB020", "Til036", "TiH008", "ZOL009", "TiA041", "TiA005", "TiA004", "TiN001", "TieG123", "Til035", "TieG029", "TieG080", "TiA009", "ZOL001", "TieG108", "Til024", "Til042", "Til021")
    length(listIDs_onPerAnimal)
    # add humans
    listID_human = c("EMGE001", "EMGE002", "EMGE004", "EMGE005", "EMGE006", "EMGE007", "EMGE012", "EMGE015", "EMGE017", "EMGE020", "EMGE024", "EMGE027", "EMGE028", "EMGE041", "EMGE042", "EMGE045", "EMGE049", "EMGE050", "EMGE051", "EMGE056", "EMGE068", "EMGE072", "EMGE088", "EMGE094", "EMGE098", "EMGE103", "EMGE108", "EMGE110", "EMGE112", "EMGE121", "EMGE127", "EMGE129", "EMGE140", "EMGE143", "EMGE144", "EMGE145", "EMGE147", "EMGE149", "EMGE151", "EMGE154", "EMGE159", "EMGE160", "EMGE162", "EMGE165")
    listIDs_onPerAnimal_and_human = c(listIDs_onPerAnimal, listID_human)
       
    ps.rowsum.uniqAnimal = subset_samples(ps.rowsum, Verschickungscode %in% listIDs_onPerAnimal_and_human)
    ps.rowsum.uniqAnimal

    
# PLOTS
names(sample_data(ps.rowsum.uniqAnimal))
sample_data(ps.rowsum.uniqAnimal)$Species = sample_data(ps.rowsum.uniqAnimal)$Species..latein.
Tierpark = sample_data(ps.rowsum.uniqAnimal)$Tierpark
Species = as.character( sample_data(ps.rowsum.uniqAnimal)$Species)
length(table(Species))

vare.cap = capscale( (otu_table(ps.rowsum.uniqAnimal)) ~ 1,  dist="bray", metaMDS = F)

Total.eigntvalues = sum(as.numeric(vare.cap$CA$eig))
dbRDA1 = round((vare.cap$CA$eig[1] / Total.eigntvalues)*100, digits = 2)
dbRDA2 = round((vare.cap$CA$eig[2] / Total.eigntvalues)*100, digits = 2)
# https://stat.ethz.ch/pipermail/r-sig-ecology/2011-June/002183.html

# res.table
res.table = as.data.frame(matrix(nrow=nrow(sample_data(ps.rowsum.uniqAnimal)), ncol=2))
names(res.table) = c('PC1', 'PC2')

dim(sample_data(ps.rowsum.uniqAnimal))
dim(vare.cap$CA$u)

res.table$PC1 = vare.cap$CA$u[,1]
res.table$PC2 = vare.cap$CA$u[,2]

head(res.table)

Species = as.character( sample_data(ps.rowsum.uniqAnimal)$Species)
length(table(Species))
## plotting the results without clustering
p_Species = ggplot(res.table, aes(x=PC1, y=PC2)) +  
  geom_point(aes(shape = as.factor(Tierpark), color=Species), size=3.5, stroke=1.4) + scale_color_manual(values=c("#5A5156", "#E4E1E3", "#F6222E", "#FE00FA", "#16FF32", "#3283FE", "#FEAF16", "#B00068", "#1CFFCE", "#90AD1C", 
                                                                                                                  "#2ED9FF", "#DEA0FD", "#AA0DFE", "#F8A19F", "#325A9B", "#C4451C", "#1C8356", "#85660D", "#B10DA1", "#FBE426", 
                                                                                                                  "#1CBE4F", "#FA0087", "#FC1CBF", "#F7E1A0", "#C075A6", "#782AB6", "#AAF400", "#BDCDFF", "#822E1C", "#B5EFB5", 
                                                                                                                  "#7ED7D1", "#1C7F93", "#D85FF7", "#683B79", "#66B0FF", "#3B00FB", "#88CCEE","#6699CC",  "#44AA99", "#332288", 
                                                                                                                  "#117733", "#999933", "#DDCC77", "#661100", "#AA4499")) + #"#CC6677", "#AA4466", "#882255" "#FDBF6F", "#FF7F00"
  guides(colour=guide_legend(override.aes=list(size=6))) + #+ guides(shape=TRUE) +
  xlab(paste("PCoA1", dbRDA1, '%')) + ylab(paste("PCoA2", dbRDA2, '%')) +
  ggtitle("") + 
  scale_shape_manual(values = c(18,19:25)) + # manual control the shapes used, here I use numbers  scale_shape_manual(values=rep(c(21:25), times=8))
  theme_light(base_size=23) +
  #theme(axis.text.x=element_blank(), axis.text.y=element_blank()) +
  #scale_colour_brewer(palette = "set2") + 
  theme(legend.text=element_text(size=15), legend.position = "right", 
        legend.box = "vertical",  legend.title =element_text(size=12, face="bold")) # legend.direction = "vertical"

#p1$labels$colour = "Diet"
p_Species$labels$shape = "Zoo"
p_Species

Genus = as.character( sample_data(ps.rowsum.uniqAnimal)$Genus)
length(table(Genus))
## plotting the results without clustering
p_Genus = ggplot(res.table, aes(x=PC1, y=PC2))  +  
  geom_point(aes(shape = as.factor(Tierpark), color=Genus), size=3.5, stroke=1.4) + scale_color_manual(values=c("#5A5156", "#E4E1E3", "#F6222E", "#FE00FA", "#16FF32", "#3283FE", "#FEAF16", "#B00068", "#1CFFCE", "#90AD1C", 
                                                                                                                "#2ED9FF", "#DEA0FD", "#AA0DFE", "#F8A19F", "#325A9B", "#C4451C", "#1C8356", "#85660D", "#B10DA1", "#FBE426", 
                                                                                                                "#1CBE4F", "#FA0087", "#FC1CBF", "#F7E1A0", "#C075A6", "#782AB6", "#AAF400", "#BDCDFF", "#822E1C", "#B5EFB5" 
  )) + # "#7ED7D1", "#1C7F93", "#D85FF7""#683B79", "#66B0FF", "#3B00FB"
  guides(colour=guide_legend(override.aes=list(size=6))) + #+ guides(shape=TRUE) +
  xlab(paste("PCoA1", dbRDA1, '%')) + ylab(paste("PCoA2", dbRDA2, '%')) +
  ggtitle("") + 
  scale_shape_manual(values = c(18,19:25)) + # manual control the shapes used, here I use numbers  scale_shape_manual(values=rep(c(21:25), times=8))
  theme_light(base_size=23) +
  #theme(axis.text.x=element_blank(), axis.text.y=element_blank()) +
  #scale_colour_brewer(palette = "set2") + 
  theme(legend.text=element_text(size=15), legend.position = "right", 
        legend.box = "vertical",  legend.title =element_text(size=12, face="bold")) # legend.direction = "vertical"

#p1$labels$colour = "Diet"
p_Genus$labels$shape = "Zoo"
p_Genus

Family = as.character( sample_data(ps.rowsum.uniqAnimal)$Family)
length(table(Family))
## plotting the results without clustering
p_Family = ggplot(res.table, aes(x=PC1, y=PC2))  +  
  geom_point(aes(shape = as.factor(Tierpark), color=Family), size=3.5, stroke=1.4) + scale_color_manual(values=c("#5A5156", "#E4E1E3", "#F6222E", "#FE00FA", "#16FF32", "#3283FE", "#FEAF16", "#B00068", "#1CFFCE", "#90AD1C", 
                                                                                                                 "#2ED9FF", "#DEA0FD", "#AA0DFE", "#F8A19F", "#325A9B", "#C4451C")) + #"#1C8356", "#85660D", "#B10DA1"
  guides(colour=guide_legend(override.aes=list(size=6))) + #+ guides(shape=TRUE) +
  xlab(paste("PCoA1", dbRDA1, '%')) + ylab(paste("PCoA2", dbRDA2, '%')) +
  ggtitle("") + 
  scale_shape_manual(values = c(18,19:25)) + # manual control the shapes used, here I use numbers  scale_shape_manual(values=rep(c(21:25), times=8))
  theme_light(base_size=23) +
  #theme(axis.text.x=element_blank(), axis.text.y=element_blank()) +
  #scale_colour_brewer(palette = "set2") + 
  theme(legend.text=element_text(size=15), legend.position = "right", 
        legend.box = "vertical",  legend.title =element_text(size=12, face="bold")) # legend.direction = "vertical"

#p1$labels$colour = "Diet"
p_Family$labels$shape = "Zoo"
p_Family

Order = as.character( sample_data(ps.rowsum.uniqAnimal)$Order)
length(table(Order))
## plotting the results without clustering
p_Order = ggplot(res.table, aes(x=PC1, y=PC2))  +  
  geom_point(aes(shape = as.factor(Tierpark), color=Order), size=3.5, stroke=1.4) + scale_color_manual(values=c("#B4AF46", "#8B0000", 
                                                                                                                "#8B008B", "#008B45", "#00008B")) +
  guides(colour=guide_legend(override.aes=list(size=6))) + #+ guides(shape=TRUE) +
  xlab(paste("PCoA1", dbRDA1, '%')) + ylab(paste("PCoA2", dbRDA2, '%')) +
  ggtitle("") + 
  scale_shape_manual(values = c(18,19:25)) + # manual control the shapes used, here I use numbers  scale_shape_manual(values=rep(c(21:25), times=8))
  theme_light(base_size=23) +
  #theme(axis.text.x=element_blank(), axis.text.y=element_blank()) +
  #scale_colour_brewer(palette = "set2") + 
  theme(legend.text=element_text(size=15), legend.position = "right", 
        legend.box = "vertical",  legend.title =element_text(size=12, face="bold")) # legend.direction = "vertical"

#p1$labels$colour = "Diet"
p_Order$labels$shape = "Zoo"
p_Order


# save plots

setwd( paste0(path_illustrations, '/Ordinations') )

## genera - order
png(paste('Ordination_CAP_all-animals_one-sample-per-animal_host-level-G-O.png', sep=''), width = 15, height = 30, res=100, units="in", family="Helvetica") # width and height are in inches, and res is in pixels/inch
ggarrange(p_Genus, p_Family, p_Order , #+ rremove("x.text") 
          labels = c("Genea", "Family", "Order"),
          ncol = 1, nrow = 3)
dev.off()    
# species
png(paste('Ordination_CAP_all-animals_one-sample-per-animal_host-level-S.png', sep=''), width = 25, height = 15, res=100, units="in", family="Helvetica") # width and height are in inches, and res is in pixels/inch
ggarrange(p_Species , #+ rremove("x.text") 
          labels = c("Species"),
          ncol = 1, nrow = 1)
dev.off()    








