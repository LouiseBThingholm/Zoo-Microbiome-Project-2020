
# Visualization -- Beta diversity / ordination evaluation



# DATA
ps.rowsum = readRDS(file.path(path_data, "16S_DADA2_processed/Zoo.rowsum_spe.rds")
ps.rowsum

# Remove taxa 
# This protects against an OTU with small mean & trivially large C.V.
ps.rowsum.gen.cmm = filter_taxa(ps.rowsum, function(x) sum(x > 0.00) > (0.01*length(x)), TRUE)
ps.rowsum.gen.cmm
ps.rowsum = ps.rowsum.gen.cmm


table((sample_data(ps.rowsum)$Order ))

# select one sample per animal, removing animals that only have one sample per order-level group

# list Verschickungscode for selected animal-uniq sample from "Meta_one-sample-per-animal_ManuallySelected.txt"
listIDs_onPerAnimal = c("TieG003", "TieG024", "TieG017", "TieG022", "TieG008", "TieG023", "TieG002", "TieG004", "TieG012", "TieG009", "TieG019", "TieG031", "TieG032", "TieG020", "TieG021", "TieG025", "TieG016", "TieG066", "TieG054", "TieG052", "TieG065", "TieG062", "TieG063", "TieG064", "TieG051", "TieG038", "TieG037", "TieG041", "TieG039", "TieG040", "TieG061", "TieG140", "TieG147", "TieG067", "TieG143", "TieG149", "TieG076", "TieG075", "TieG078", "TieG124", "TieG121", "TieG122", "TieG125", "TieG101", "TieG102", "TieG128", "TieG126", "TieG105", "TiH017", "TiH023", "TiH025", "TiH010", "TiA033", "TiA018", "TiA045", "TiA038", "TiA029", "TiA016", "TiA034", "TiA044", "TiA021", "TiA013", "TiA024", "TiA031", "TiA032", "TiA026", "TiA025", "TiA039", "TiA030", "TiA022", "TiA040", "TiA006", "TiA035", "TiA007", "TiA015", "TiB002", "TiB022", "TieG119", "TiA046", "ZOL010", "ZOL011", "TieG034", "ZOL012", "Til017", "TiH001", "TiB037", "TieG013", "ZOL013", "TieG112", "TieG055", "TieG015", "TieG060", "ZOL002", "Til006", "TieG110", "ZOL003", "TieG097", "TieG096", "TiA010", "NecBac", "TieG070", "TieG085", "TieG086", "TieG082", "TieG077", "TieG050", "Til033", "TiA011", "Til004", "TieG104", "TieG106", "ZOL004", "Til038", "ZOL005", "TiB029", "Til031", "Til039", "Til025", "Til020", "TiA001", "TiB080", "TiA023", "TieG092", "TieG036", "Til014", "TiA003", "ZOL014", "TieG111", "TiB079", "TiB063", "TieG088", "TieG069", "TieG079", "TieG093", "TieG071", "TieG074", "TieG115", "TieG089", "TieG027", "Til009", "TiN011", "Til019", "Til016", "TieG053", "TiB052", "Til007", "Til022", "TiH019", "TieG095", "TieG099", "Til005", "TieG057", "TieG058", "TieG030", "TieG118", "Til013", "TiH012", "Til029", "TiA017", "Til018", "TieG109", "TieG098", "TieG107", "Til012", "ZOL006", "Til001", "TiA012", "TiB044", "TieG114", "TieG006", "TieG113", "TieG127", "Til032", "Til044", "Til011", "Til030", "Til034", "Til015", "TiA019", "TieG090", "ZOL007", "TiB075", "ZOL008St", "TiA008", "TieG035", "Til008", "TiN086", "TiN036", "TiN071", "TiN055", "TiN087", "TiN056", "TiN031", "TiN079", "TiN083", "TiN053", "TiN080", "TiN058", "TiN078", "TiN093", "TiN023", "TiN091", "TiN049", "TiN067", "TiN096", "TiN029", "TiN066", "TiN050", "TiN048", "TiN024", "TiN094", "TiN097", "TiN068", "TiN022", "TiN064", "TiN075", "TiN041", "TiN044", "TiN046", "TiN072", "TiN051", "TiN054", "TiN052", "TiN035", "TiN033", "TiN085", "TiN084", "TiN081", "TiN082", "TiN099", "TiN090", "TiN028", "TiN095", "TiN040", "TiN069", "TiN100", "TiN074", "TiN061", "TiN062", "TiN030", "TiN098", "TiN047", "TiN073", "TiN043", "TiN092", "TiN042", "TiN063", "TiN045", "TiN027", "TiN088", "TiN026", "TiN060", "TiN039", "TiN038", "TiN021", "TiN065", "TiN059", "TiN057", "TiN025", "TiN076", "TiN037", "TiN089", "TiB058", "TiB077", "TiB007", "TiB071", "TiB018", "TiB042", "TiB053", "TiB047", "TiB011", "TiB026", "TiB040", "TiB060", "TiB054", "TiB059", "TiB061", "TiB027", "TiB051", "TiB064", "TiB038", "TiB028", "TiB045", "TiB001", "TiB009", "TiB010", "TiB024", "TiB015", "TiB025", "TiB030", "TiB076", "TiB003", "TiB008", "TiB073", "TiB004", "TiB017", "TiB062", "TiB013", "TiB014", "TiB019", "TiB012", "TiH006", "Til040", "Til002", "Til027", "Til041", "TiH004", "TieG116", "Til010", "TiH007", "Til043", "TieG056", "Til026", "TieG026", "Til023", "TieG028", "TieG103", "TiH016", "TiB020", "Til036", "TiH008", "ZOL009", "TiA041", "TiA005", "TiA004", "TiN001", "TieG123", "Til035", "TieG029", "TieG080", "TiA009", "ZOL001", "TieG108", "Til024", "Til042", "Til021")
length(listIDs_onPerAnimal)
# add humans
listID_human = c("EMGE001", "EMGE002", "EMGE004", "EMGE005", "EMGE006", "EMGE007", "EMGE012", "EMGE015", "EMGE017", "EMGE020", "EMGE024", "EMGE027", "EMGE028", "EMGE041", "EMGE042", "EMGE045", "EMGE049", "EMGE050", "EMGE051", "EMGE056", "EMGE068", "EMGE072", "EMGE088", "EMGE094", "EMGE098", "EMGE103", "EMGE108", "EMGE110", "EMGE112", "EMGE121", "EMGE127", "EMGE129", "EMGE140", "EMGE143", "EMGE144", "EMGE145", "EMGE147", "EMGE149", "EMGE151", "EMGE154", "EMGE159", "EMGE160", "EMGE162", "EMGE165")
listIDs_onPerAnimal_and_human = c(listIDs_onPerAnimal, listID_human)

ps.rowsum.uniqAnimal = subset_samples(ps.rowsum, Verschickungscode %in% listIDs_onPerAnimal_and_human)
ps.rowsum.uniqAnimal
# otu_table()   OTU Table:         [ 602 taxa and 368 samples ]

# PLOTS
sample_data(ps.rowsum.uniqAnimal)$Species = sample_data(ps.rowsum.uniqAnimal)$Species..latein.

# subset by order

    table( sample_data(ps.rowsum.uniqAnimal)$Order)
    
    ps.rowsum.uniqAnimal_Perissodactyla = subset_samples(ps.rowsum.uniqAnimal, Order %in% 'Perissodactyla')
    ps.rowsum.uniqAnimal_Perissodactyla
    
    ps.rowsum.uniqAnimal_Artiodactyla = subset_samples(ps.rowsum.uniqAnimal, Order %in% 'Artiodactyla')
    ps.rowsum.uniqAnimal_Artiodactyla
    
    ps.rowsum.uniqAnimal_Carnivora = subset_samples(ps.rowsum.uniqAnimal, Order %in% 'Carnivora')
    ps.rowsum.uniqAnimal_Carnivora
    
    ps.rowsum.uniqAnimal_Primates = subset_samples(ps.rowsum.uniqAnimal, Order %in% 'Primates')
    ps.rowsum.uniqAnimal_Primates
    
# Perissodactyla
    ps.rowsum.uniqAnimal_Perissodactyla

    
    horse_sub=subset_samples(ps.rowsum.uniqAnimal_Perissodactyla, Species..englisch. %in% 'Horse' & Tierpark %in% 'ArcheWarder')
    sample_data(horse_sub)
    
    ps.rowsum.uniqAnimal_Perissodactyla=subset_samples(ps.rowsum.uniqAnimal_Perissodactyla, !Verschickungscode %in% 'TiA005') # removing an outlier
    
    Tierpark_Perissodactyla = sample_data(ps.rowsum.uniqAnimal_Perissodactyla)$Tierpark
    Species_Perissodactyla = as.character( sample_data(ps.rowsum.uniqAnimal_Perissodactyla)$Species)
    
    vare.cap_Perissodactyla = capscale( (otu_table(ps.rowsum.uniqAnimal_Perissodactyla)) ~ 1,  dist="bray", metaMDS = F, sqrt.dist = F)
    
    Total.eigntvalues_Perissodactyla = sum(as.numeric(vare.cap_Perissodactyla$CA$eig))
    dbRDA1_Perissodactyla = round((vare.cap_Perissodactyla$CA$eig[1] / Total.eigntvalues_Perissodactyla)*100, digits = 2)
    dbRDA2_Perissodactyla = round((vare.cap_Perissodactyla$CA$eig[2] / Total.eigntvalues_Perissodactyla)*100, digits = 2)
    # https://stat.ethz.ch/pipermail/r-sig-ecology/2011-June/002183.html
    
    # res.table
    res.table_Perissodactyla = as.data.frame(matrix(nrow=nrow(sample_data(ps.rowsum.uniqAnimal_Perissodactyla)), ncol=2))
    names(res.table_Perissodactyla) = c('PC1', 'PC2')
    
    dim(sample_data(ps.rowsum.uniqAnimal_Perissodactyla))
    dim(vare.cap_Perissodactyla$CA$u)
    
    res.table_Perissodactyla$PC1 = vare.cap_Perissodactyla$CA$u[,1]
    res.table_Perissodactyla$PC2 = vare.cap_Perissodactyla$CA$u[,2]
    
    head(res.table_Perissodactyla)
    
    length(table(Species_Perissodactyla))
    ## plotting the results without clustering
    p_Perissodactyla = ggplot(res.table_Perissodactyla, aes(x=PC1, y=PC2)) +  
      geom_point(aes(shape = as.factor(Tierpark_Perissodactyla), color=Species_Perissodactyla), size=3.5, stroke=1.4) + scale_color_manual(values=c("#5A5156", "#E4E1E3", "#F6222E", "#FE00FA", "#16FF32", "#3283FE", "#FEAF16",
                                                                                                                                                    "#CC6677", "#AA4466")) + #"#CC6677", "#AA4466", "#882255" "#FDBF6F", "#FF7F00"
      guides(colour=guide_legend(override.aes=list(size=6))) + #+ guides(shape=TRUE) +
      xlab( paste("PCoA1", dbRDA1_Perissodactyla, '%')) + ylab(paste("PCoA2", dbRDA2_Perissodactyla, '%')) +
      ggtitle("") + 
      scale_shape_manual(values = c(18,19:25)) + # manual control the shapes used, here I use numbers  scale_shape_manual(values=rep(c(21:25), times=8))
      theme_light(base_size=23) +
      #theme(axis.text.x=element_blank(), axis.text.y=element_blank()) +
      #scale_colour_brewer(palette = "set2") + 
      theme(legend.text=element_text(size=15), legend.position = "right", 
            legend.box = "vertical",  legend.title =element_text(size=12, face="bold"), legend.direction = "vertical") # legend.direction = "vertical"
    
    #p1$labels$colour = "Diet"
    p_Perissodactyla$labels$shape = "Zoo"
    p_Perissodactyla$labels$colour = "Species"
    p_Perissodactyla

    
# Artiodactyla
    ps.rowsum.uniqAnimal_Artiodactyla
    
    
    Tierpark_Artiodactyla = sample_data(ps.rowsum.uniqAnimal_Artiodactyla)$Tierpark
    Species_Artiodactyla = as.character( sample_data(ps.rowsum.uniqAnimal_Artiodactyla)$Species)
    
    vare.cap_Artiodactyla = capscale( (otu_table(ps.rowsum.uniqAnimal_Artiodactyla)) ~ 1,  dist="bray", metaMDS = F)
    
    #vare.cap = capscale( (otu_table(ps.rowsum.uniqAnimal)) ~ 1 + Condition(Tierpark),  dist="bray", metaMDS = F)
    
    Total.eigntvalues_Artiodactyla = sum(as.numeric(vare.cap_Artiodactyla$CA$eig))
    dbRDA1_Artiodactyla = round((vare.cap_Artiodactyla$CA$eig[1] / Total.eigntvalues_Artiodactyla)*100, digits = 2)
    dbRDA2_Artiodactyla = round((vare.cap_Artiodactyla$CA$eig[2] / Total.eigntvalues_Artiodactyla)*100, digits = 2)
    # https://stat.ethz.ch/pipermail/r-sig-ecology/2011-June/002183.html
    
    # res.table
    res.table_Artiodactyla = as.data.frame(matrix(nrow=nrow(sample_data(ps.rowsum.uniqAnimal_Artiodactyla)), ncol=2))
    names(res.table_Artiodactyla) = c('PC1', 'PC2')
    
    dim(sample_data(ps.rowsum.uniqAnimal_Artiodactyla))
    dim(vare.cap_Artiodactyla$CA$u)
    
    res.table_Artiodactyla$PC1 = vare.cap_Artiodactyla$CA$u[,1]
    res.table_Artiodactyla$PC2 = vare.cap_Artiodactyla$CA$u[,2]
    
    head(res.table_Artiodactyla)
    
    length(table(Species_Artiodactyla))
    ## plotting the results without clustering
    p_Artiodactyla = ggplot(res.table_Artiodactyla, aes(x=PC1, y=PC2)) +  
      geom_point(aes(shape = as.factor(Tierpark_Artiodactyla), color=Species_Artiodactyla), size=3.5, stroke=1.4) + scale_color_manual(values=c("#5A5156", "#E4E1E3", "#F6222E", "#FE00FA", "#16FF32", "#3283FE", "#FEAF16", "#B00068", "#1CFFCE", "#90AD1C", 
                                                                                                                                                "#2ED9FF")) + #"#CC6677", "#AA4466", "#882255" "#FDBF6F", "#FF7F00"
      guides(colour=guide_legend(override.aes=list(size=6))) + #+ guides(shape=TRUE) +
      xlab( paste("PCoA1", dbRDA1_Artiodactyla, '%')) + ylab(paste("PCoA2", dbRDA2_Artiodactyla, '%')) +
      ggtitle("") + 
      scale_shape_manual(values = c(18,19:25)) + # manual control the shapes used, here I use numbers  scale_shape_manual(values=rep(c(21:25), times=8))
      theme_light(base_size=23) +
      #theme(axis.text.x=element_blank(), axis.text.y=element_blank()) +
      #scale_colour_brewer(palette = "set2") + 
      theme(legend.text=element_text(size=15), legend.position = "right", 
            legend.box = "vertical",  legend.title =element_text(size=12, face="bold")) # legend.direction = "vertical"
    
    #p1$labels$colour = "Diet"
    p_Artiodactyla$labels$shape = "Zoo"
    p_Artiodactyla$labels$colour = "Species"
    p_Artiodactyla
    
# Carnivora
    ps.rowsum.uniqAnimal_Carnivora
    
    
    Tierpark_Carnivora = sample_data(ps.rowsum.uniqAnimal_Carnivora)$Tierpark
    Species_Carnivora = as.character( sample_data(ps.rowsum.uniqAnimal_Carnivora)$Species)
    
    vare.cap_Carnivora = capscale( (otu_table(ps.rowsum.uniqAnimal_Carnivora)) ~ 1,  dist="bray", metaMDS = F)
    
    #vare.cap = capscale( (otu_table(ps.rowsum.uniqAnimal)) ~ 1 + Condition(Tierpark),  dist="bray", metaMDS = F)
    
    Total.eigntvalues_Carnivora = sum(as.numeric(vare.cap_Carnivora$CA$eig))
    dbRDA1_Carnivora = round((vare.cap_Carnivora$CA$eig[1] / Total.eigntvalues_Carnivora)*100, digits = 2)
    dbRDA2_Carnivora = round((vare.cap_Carnivora$CA$eig[2] / Total.eigntvalues_Carnivora)*100, digits = 2)
    # https://stat.ethz.ch/pipermail/r-sig-ecology/2011-June/002183.html
    
    # res.table
    res.table_Carnivora = as.data.frame(matrix(nrow=nrow(sample_data(ps.rowsum.uniqAnimal_Carnivora)), ncol=2))
    names(res.table_Carnivora) = c('PC1', 'PC2')
    
    dim(sample_data(ps.rowsum.uniqAnimal_Carnivora))
    dim(vare.cap_Carnivora$CA$u)
    
    res.table_Carnivora$PC1 = vare.cap_Carnivora$CA$u[,1]
    res.table_Carnivora$PC2 = vare.cap_Carnivora$CA$u[,2]
    
    head(res.table_Carnivora)
    
    length(table(Species_Carnivora))
    ## plotting the results without clustering
    p_Carnivora = ggplot(res.table_Carnivora, aes(x=PC1, y=PC2)) +  
      geom_point(aes(shape = as.factor(Tierpark_Carnivora), color=Species_Carnivora), size=3.5, stroke=1.4) + scale_color_manual(values=c("#5A5156", "#E4E1E3", "#F6222E", "#FE00FA", "#16FF32")) + #"#CC6677", "#AA4466", "#882255" "#FDBF6F", "#FF7F00"
      guides(colour=guide_legend(override.aes=list(size=6))) + #+ guides(shape=TRUE) +
      xlab( paste("PCoA1", dbRDA1_Carnivora, '%')) + ylab(paste("PCoA2", dbRDA2_Carnivora, '%')) +
      ggtitle("") + 
      scale_shape_manual(values = c(18,19:25)) + # manual control the shapes used, here I use numbers  scale_shape_manual(values=rep(c(21:25), times=8))
      theme_light(base_size=23) +
      #theme(axis.text.x=element_blank(), axis.text.y=element_blank()) +
      #scale_colour_brewer(palette = "set2") + 
      theme(legend.text=element_text(size=15), legend.position = "right", 
            legend.box = "vertical",  legend.title =element_text(size=12, face="bold")) # legend.direction = "vertical"
    
    #p1$labels$colour = "Diet"
    p_Carnivora$labels$shape = "Zoo"
    p_Carnivora$labels$colour = "Species"
    p_Carnivora
    

# Primates
    ps.rowsum.uniqAnimal_Primates
    
    Tierpark_Primates = sample_data(ps.rowsum.uniqAnimal_Primates)$Tierpark
    Species_Primates = as.character( sample_data(ps.rowsum.uniqAnimal_Primates)$Species)
    
    vare.cap_Primates = capscale( otu_table(ps.rowsum.uniqAnimal_Primates) ~ 1,  dist="bray", metaMDSdist = F, sqrt.dist = T)
    
    #vare.cap = capscale( (otu_table(ps.rowsum.uniqAnimal)) ~ 1 + Condition(Tierpark),  dist="bray", metaMDS = F)
    
    Total.eigntvalues_Primates = sum(as.numeric(vare.cap_Primates$CA$eig))
    dbRDA1_Primates = round((vare.cap_Primates$CA$eig[1] / Total.eigntvalues_Primates)*100, digits = 2)
    dbRDA2_Primates = round((vare.cap_Primates$CA$eig[2] / Total.eigntvalues_Primates)*100, digits = 2)
    # https://stat.ethz.ch/pipermail/r-sig-ecology/2011-June/002183.html
    
    # res.table
    res.table_Primates = as.data.frame(matrix(nrow=nrow(sample_data(ps.rowsum.uniqAnimal_Primates)), ncol=2))
    names(res.table_Primates) = c('PC1', 'PC2')
    
    dim(sample_data(ps.rowsum.uniqAnimal_Primates))
    dim(vare.cap_Primates$CA$u)
    
    res.table_Primates$PC1 = vare.cap_Primates$CA$u[,1]
    res.table_Primates$PC2 = vare.cap_Primates$CA$u[,2]
    
    head(res.table_Primates)
    
    
    # White-handed gibbon		Hylobates lar
    # Chimp		Pan troglodytes
    head(sample_data(ps.rowsum.uniqAnimal_Primates))
    toheighlight=as.character( sample_data(ps.rowsum.uniqAnimal_Primates)$Tierart )
    toheighlight[toheighlight=='Mensch (pflegt Schimpansen, Gibbon)'] <- 'Caretaker for hylobates lar and pan troglodytes'
    toheighlight[toheighlight=='Mensch (pflegt Katta, Vari und Co.)'] <- 'Caretaker for lemur catta, varecia rubra and saguinus species'
    table(toheighlight)
    
    res.table_Primates$label = toheighlight
    
    ## plotting the results without clustering
    p_Primates = ggplot(res.table_Primates, aes(x=PC1, y=PC2)) +  
      geom_point(aes(shape = as.factor(Tierpark_Primates), color=Species_Primates), size=3.5, stroke=1.4) + scale_color_manual(values=c("#7FC97F", "#BEAED4", "#FDC086", "#FFFF99", "#386CB0",
                                                                                                                                        "#F0027F", "#BF5B17", "#666666", "#1B9E77", "#D95F02",
                                                                                                                                        "#7570B3", "#E7298A", "#66A61E", "#E6AB02", "#A6761D",
                                                                                                                                        "#666666", "#A6CEE3", "#1F78B4", "#B2DF8A", "#33A02C")) + #"#CC6677", "#AA4466", "#882255" "#FDBF6F", "#FF7F00"
      guides(colour=guide_legend(override.aes=list(size=6))) + #+ guides(shape=TRUE) +
      xlab( paste("PCoA1", dbRDA1_Primates, '%')) + ylab(paste("PCoA2", dbRDA2_Primates, '%')) +
      ggtitle("") + 
      scale_shape_manual(values = c(18,19:25)) + # manual control the shapes used, here I use numbers  scale_shape_manual(values=rep(c(21:25), times=8))
      theme_light(base_size=23) +
      #theme(axis.text.x=element_blank(), axis.text.y=element_blank()) +
      #scale_colour_brewer(palette = "set2") + 
      theme(legend.text=element_text(size=15), legend.position = "right", 
            legend.box = "vertical",  legend.title =element_text(size=12, face="bold")) # legend.direction = "vertical"
    
    #p1$labels$colour = "Diet"
    p_Primates$labels$shape = "Zoo"
    p_Primates$labels$colour = "Species"
    p_Primates
    #length(table(Species_Primates))
    
    
    # White-handed gibbon		Hylobates lar
    # Chimp		Pan troglodytes
    circle_factor = rep('', nrow(sample_data(ps.rowsum.uniqAnimal_Primates)))
    circle_factor[ sample_data(ps.rowsum.uniqAnimal_Primates)$Species..latein.=='Hylobates lar' ] = 'one'
    circle_factor[ sample_data(ps.rowsum.uniqAnimal_Primates)$Species..latein.=='Pan troglodytes' ] = 'one'
    circle_factor[ sample_data(ps.rowsum.uniqAnimal_Primates)$Species..latein.=='Varecia rubra' | 
                     sample_data(ps.rowsum.uniqAnimal_Primates)$Species..latein.=='Lemur catta' | 
                     sample_data(ps.rowsum.uniqAnimal_Primates)$Species..latein.=='Saguinus imperator' | 
                     sample_data(ps.rowsum.uniqAnimal_Primates)$Species..latein.=='Saguinus labiatus' | 
                     sample_data(ps.rowsum.uniqAnimal_Primates)$Species..latein.=='Saguinus midas' | 
                     sample_data(ps.rowsum.uniqAnimal_Primates)$Species..latein.=='Saguinus oedipus'] = 'two'
    
    
    p_Primates=p_Primates + geom_point(data=res.table_Primates[61, ], aes(x=PC1, y=PC2), colour="red", size=10)+
      geom_text(aes(label=ifelse(res.table_Primates$label=='Caretaker for hylobates lar and pan troglodytes', as.character(label),'')),hjust=0.5,vjust=-2, size=5) +
      geom_point(data=res.table_Primates[63, ], aes(x=PC1, y=PC2), colour="orange", size=10)+
      geom_text(aes(label=ifelse(res.table_Primates$label=='Caretaker for lemur catta, varecia rubra and saguinus species', as.character(label),'')),hjust=0.5,vjust=-2.5, size=5) 
    p_Primates


# save plots

  setwd( paste0(path_illustrations, '/Ordinations') )

## all order levels
 

top_row = plot_grid(p_Artiodactyla, p_Perissodactyla,
                   ncol=2, labels = c("Artiodactyla", "Perissodactyla"), label_size = 18)
bottom_row = plot_grid(p_Carnivora, p_Primates,
                       ncol=2,rel_widths=c(1,2), labels = c("Carnivora", "Primates"), label_size = 18)

png(paste('Ordination_CAP_animalsByOrder_one-sample-per-animal_species.png', sep=''), width = 35, height = 20, res=150, units="in", family="Helvetica") # width and height are in inches, and res is in pixels/inch

plot_grid(top_row,
          bottom_row, ncol=1)


dev.off() 

# arrange with the main all-samples plot with hosts coloured by order level - load using "Plot_Ordination_MDS.R"

bottom_left = plot_grid(p_Artiodactyla, 
                      ncol=1, nrow=1, rel_widths=c(1,1), labels = c("C) Artiodactyla"), label_size = 22)

bottom_right = plot_grid(p_Perissodactyla, p_Carnivora,
                        ncol=1, nrow=2, rel_widths=c(1,1), labels = c("D) Perissodactyla", "E) Carnivora"), label_size = 22)
bottom = plot_grid(bottom_left, bottom_right,
                 ncol=2, nrow=1, rel_widths=c(1,1), labels = c(), label_size = 22)
top_rows = plot_grid(p_Order,p_Primates,
                    ncol=1, nrow=2, rel_widths=c(2,1), label_size = 22, labels = c( "A) Taxonomic order of mammals", "B) Primates"))



png(paste('Ordination_CAP_animalsByOrder_one-sample-per-animal_species_incl.hostOrder.png', sep=''), width = 20, height = 30, res=300, units="in", family="Helvetica") # width and height are in inches, and res is in pixels/inch

plot_grid(  
  top_rows,
  bottom, ncol=1, nrow=2, rel_heights=c(2,1))


dev.off() 

# with table

bottom_left = plot_grid(p_Artiodactyla, g.form,
                        ncol=1, nrow=2, rel_widths=c(1,1), labels = c("C) Artiodactyla", "E) permanova analysis"), label_size = 22)

bottom_right = plot_grid(p_Perissodactyla, p_Carnivora,
                         ncol=1, nrow=2, rel_widths=c(1,1), labels = c("D) Perissodactyla", "E) Carnivora"), label_size = 22)
bottom = plot_grid(bottom_right, bottom_left,
                   ncol=2, nrow=1, rel_widths=c(1,1), labels = c(), label_size = 22)
top_rows = plot_grid(p_Order,p_Primates,
                     ncol=1, nrow=2, rel_widths=c(2,1), label_size = 22, labels = c( "A) Taxonomic order of mammals", "B) Primates"))


png(paste('Ordination_CAP_animalsByOrder_one-sample-per-animal_species_incl.hostOrder.table.png', sep=''), width = 20, height = 30, res=300, units="in", family="Helvetica") # width and height are in inches, and res is in pixels/inch

plot_grid(  
  top_rows,
  bottom, ncol=1, nrow=2, rel_heights=c(2,1))


dev.off()



