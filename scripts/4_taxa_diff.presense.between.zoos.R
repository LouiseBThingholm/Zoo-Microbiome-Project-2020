
# ANY ZOO SPECIFIC TAXA

# DATA
source(file.path(path_scripts, "1_MASTERFILE.R") )
ps = readRDS( file.path(path_data, '16S_DADA2_processed/Zoo.rowsum_spe.rds'))
ps


# select one sample per animal

# list Verschickungscode for selected animal-uniq sample from "Meta_one-sample-per-animal_ManuallySelected.txt"
listIDs_onPerAnimal = c("TieG003", "TieG024", "TieG017", "TieG022", "TieG008", "TieG023", "TieG002", "TieG004", "TieG012", "TieG009", "TieG019", "TieG031", "TieG032", "TieG020", "TieG021", "TieG025", "TieG016", "TieG066", "TieG054", "TieG052", "TieG065", "TieG062", "TieG063", "TieG064", "TieG051", "TieG038", "TieG037", "TieG041", "TieG039", "TieG040", "TieG061", "TieG140", "TieG147", "TieG067", "TieG143", "TieG149", "TieG076", "TieG075", "TieG078", "TieG124", "TieG121", "TieG122", "TieG125", "TieG101", "TieG102", "TieG128", "TieG126", "TieG105", "TiH017", "TiH023", "TiH025", "TiH010", "TiA033", "TiA018", "TiA045", "TiA038", "TiA029", "TiA016", "TiA034", "TiA044", "TiA021", "TiA013", "TiA024", "TiA031", "TiA032", "TiA026", "TiA025", "TiA039", "TiA030", "TiA022", "TiA040", "TiA006", "TiA035", "TiA007", "TiA015", "TiB002", "TiB022", "TieG119", "TiA046", "ZOL010", "ZOL011", "TieG034", "ZOL012", "Til017", "TiH001", "TiB037", "TieG013", "ZOL013", "TieG112", "TieG055", "TieG015", "TieG060", "ZOL002", "Til006", "TieG110", "ZOL003", "TieG097", "TieG096", "TiA010", "NecBac", "TieG070", "TieG085", "TieG086", "TieG082", "TieG077", "TieG050", "Til033", "TiA011", "Til004", "TieG104", "TieG106", "ZOL004", "Til038", "ZOL005", "TiB029", "Til031", "Til039", "Til025", "Til020", "TiA001", "TiB080", "TiA023", "TieG092", "TieG036", "Til014", "TiA003", "ZOL014", "TieG111", "TiB079", "TiB063", "TieG088", "TieG069", "TieG079", "TieG093", "TieG071", "TieG074", "TieG115", "TieG089", "TieG027", "Til009", "TiN011", "Til019", "Til016", "TieG053", "TiB052", "Til007", "Til022", "TiH019", "TieG095", "TieG099", "Til005", "TieG057", "TieG058", "TieG030", "TieG118", "Til013", "TiH012", "Til029", "TiA017", "Til018", "TieG109", "TieG098", "TieG107", "Til012", "ZOL006", "Til001", "TiA012", "TiB044", "TieG114", "TieG006", "TieG113", "TieG127", "Til032", "Til044", "Til011", "Til030", "Til034", "Til015", "TiA019", "TieG090", "ZOL007", "TiB075", "ZOL008St", "TiA008", "TieG035", "Til008", "TiN086", "TiN036", "TiN071", "TiN055", "TiN087", "TiN056", "TiN031", "TiN079", "TiN083", "TiN053", "TiN080", "TiN058", "TiN078", "TiN093", "TiN023", "TiN091", "TiN049", "TiN067", "TiN096", "TiN029", "TiN066", "TiN050", "TiN048", "TiN024", "TiN094", "TiN097", "TiN068", "TiN022", "TiN064", "TiN075", "TiN041", "TiN044", "TiN046", "TiN072", "TiN051", "TiN054", "TiN052", "TiN035", "TiN033", "TiN085", "TiN084", "TiN081", "TiN082", "TiN099", "TiN090", "TiN028", "TiN095", "TiN040", "TiN069", "TiN100", "TiN074", "TiN061", "TiN062", "TiN030", "TiN098", "TiN047", "TiN073", "TiN043", "TiN092", "TiN042", "TiN063", "TiN045", "TiN027", "TiN088", "TiN026", "TiN060", "TiN039", "TiN038", "TiN021", "TiN065", "TiN059", "TiN057", "TiN025", "TiN076", "TiN037", "TiN089", "TiB058", "TiB077", "TiB007", "TiB071", "TiB018", "TiB042", "TiB053", "TiB047", "TiB011", "TiB026", "TiB040", "TiB060", "TiB054", "TiB059", "TiB061", "TiB027", "TiB051", "TiB064", "TiB038", "TiB028", "TiB045", "TiB001", "TiB009", "TiB010", "TiB024", "TiB015", "TiB025", "TiB030", "TiB076", "TiB003", "TiB008", "TiB073", "TiB004", "TiB017", "TiB062", "TiB013", "TiB014", "TiB019", "TiB012", "TiH006", "Til040", "Til002", "Til027", "Til041", "TiH004", "TieG116", "Til010", "TiH007", "Til043", "TieG056", "Til026", "TieG026", "Til023", "TieG028", "TieG103", "TiH016", "TiB020", "Til036", "TiH008", "ZOL009", "TiA041", "TiA005", "TiA004", "TiN001", "TieG123", "Til035", "TieG029", "TieG080", "TiA009", "ZOL001", "TieG108", "Til024", "Til042", "Til021")
length(listIDs_onPerAnimal)
# add humans
listID_human = c("EMGE001", "EMGE002", "EMGE004", "EMGE005", "EMGE006", "EMGE007", "EMGE012", "EMGE015", "EMGE017", "EMGE020", "EMGE024", "EMGE027", "EMGE028", "EMGE041", "EMGE042", "EMGE045", "EMGE049", "EMGE050", "EMGE051", "EMGE056", "EMGE068", "EMGE072", "EMGE088", "EMGE094", "EMGE098", "EMGE103", "EMGE108", "EMGE110", "EMGE112", "EMGE121", "EMGE127", "EMGE129", "EMGE140", "EMGE143", "EMGE144", "EMGE145", "EMGE147", "EMGE149", "EMGE151", "EMGE154", "EMGE159", "EMGE160", "EMGE162", "EMGE165")
listIDs_onPerAnimal_and_human = c(listIDs_onPerAnimal, listID_human)
length(listIDs_onPerAnimal_and_human)

ps.rowsum.uniqAnimal = subset_samples(ps, Verschickungscode %in% listIDs_onPerAnimal_and_human)
ps.rowsum.uniqAnimal
# otu_table()   OTU Table:         [ 1381 taxa and 368 samples ]

# DATA FILTER
    
    #Remove taxa not seen with count more than x in at least y% of the samples. 
    #This protects against an OTU with small mean & trivially large C.V.
    ps.rowsum.uniqAnimal.cmm = filter_taxa(ps.rowsum.uniqAnimal, function(x) sum(x > 1e-5) > (0.03*length(x)), TRUE)
    ps.rowsum.uniqAnimal.cmm
    
    # otu_table()   OTU Table:         [ 348 taxa and 368 samples ]
    

# presense / absense
    
    species = as.data.frame( otu_table(ps.rowsum.uniqAnimal.cmm) )
    species[species > 0] <- 1
    species[1:4,1:4]
    
    
    taxa.spe = as.data.frame(tax_table(ps.rowsum.uniqAnimal.cmm))
    head(taxa.spe)
    
    length(names(species))
    length(taxa.spe$Species)
    names(species) = paste(taxa.spe$Phylum, taxa.spe$Class, '...', taxa.spe$Genus,  taxa.spe$Species, sep = ' - ')
    
    meta = as.data.frame( sample_data(ps.rowsum.uniqAnimal.cmm) )
    meta[1:4,1:4]
    
    meta.spe = merge(meta, species, by=0)
    dim(meta.spe)    
    meta.spe[1:4,1:34]

    spe_names = paste(taxa.spe$Phylum, taxa.spe$Class, '...', taxa.spe$Genus,  taxa.spe$Species, sep = ' - ')
    sum_by_zoo = aggregate( meta.spe[, spe_names ] , by=list(Category=meta.spe$Tierpark), FUN=sum)
    sum_by_zoo[1:8,1:4]
    rownames(sum_by_zoo) = sum_by_zoo$Category
    sum_by_zoo$Category = NULL
    
    mat_data <- data.matrix(sum_by_zoo)
    mat_data[1:4,1:4]
    library(gplots)
    heatmap(mat_data)
    
    mat_data[, grep("Firmicutes - Clostridia - ... - NA - NA",  colnames(mat_data))]
    
    mat_data[, "Firmicutes - Clostridia - ... - NA - NA"]
    
    # filter
    # only found in 1 zoo
    dim(mat_data)
    mat_data_sub = mat_data[, colSums(   mat_data > 0 ) < 2]
    dim(mat_data_sub)
    
    # evaluate
        mat_data_sub[1:8,1:4]
        rowSums(   mat_data_sub > 0 ) # 255 species are only found in neumunster
        
        sort(names(as.data.frame(mat_data_sub[, mat_data_sub[ 'Kiel', ] > 0 ])))
        
        sort(names(as.data.frame(mat_data_sub[, mat_data_sub[ 'Neumunster', ] > 0 ])))
        neum_names = (names(as.data.frame(mat_data_sub[, mat_data_sub[ 'Neumunster', ] > 0 ])))
        
        table(meta.spe$Tierpark, meta.spe$Order) # Neumünster only has Primates and Carnivora
        
        sum_by_zoo_2 = aggregate( meta.spe[, neum_names ] , by=list(Category=meta.spe$Order), FUN=sum)
        #sum_by_zoo_2[, 1:8]
        rownames(sum_by_zoo_2) = sum_by_zoo_2$Category; sum_by_zoo_2$Category = NULL
        rowSums(   sum_by_zoo_2 > 0 ) # they are spread across both order
        
        # in Nuemünster, which animal species has them
        meta.spe_neu = subset(meta.spe, Tierpark == 'Neumunster')
        sum_by_zoo_2 = aggregate( meta.spe_neu[, neum_names ] , by=list(Category=meta.spe_neu$Genus), FUN=sum)
        sum_by_zoo_2
        rownames(sum_by_zoo_2) = sum_by_zoo_2$Category; sum_by_zoo_2$Category = NULL
        rowSums(   sum_by_zoo_2 > 0 ) # they are spread across both order
        
    
## HEATMAP ALL CMM SPECIES, PRES/ABS
    species = as.data.frame( otu_table(ps.rowsum.uniqAnimal.cmm) )
    species[species > 0] <- 1
    species[1:4,1:4]
    
    taxa.spe = as.data.frame(tax_table(ps.rowsum.uniqAnimal.cmm))
    head(taxa.spe)
    
    length(names(species))
    length(taxa.spe$Species)
    names(species) = paste(taxa.spe$Phylum, taxa.spe$Class, '...', taxa.spe$Genus,  taxa.spe$Species, sep = ' - ')
    
    grep('leptum', names(species))
    grep('piger', names(species))
    length(names(species))
    
    meta = as.data.frame( sample_data(ps.rowsum.uniqAnimal.cmm) )
    meta[1:4,1:4]
    
    meta.spe = merge(meta, species, by=0)
    dim(meta.spe)    
    meta.spe[1:4,1:34]
    
    spe_names = paste(taxa.spe$Phylum, taxa.spe$Class, '...', taxa.spe$Genus,  taxa.spe$Species, sep = ' - ')
    sum_by_zoo = aggregate( meta.spe[, spe_names ] , by=list(Category=meta.spe$Tierpark), FUN=sum)
    sum_by_zoo[1:8,1:4]
    rownames(sum_by_zoo) = sum_by_zoo$Category
    sum_by_zoo$Category = NULL
    
    mat_data <- data.matrix(sum_by_zoo)
    
    mat_data[1:4,1:4]
    dim(mat_data)
    library(gplots)
    heatmap(mat_data)
    
    
    
    # creates a own color palette from red to green
    my_palette <- colorRampPalette(c("red", "yellow", "darkgreen"))(n = 299)
    
    # (optional) defines the color breaks manually for a "skewed" color transition
    col_breaks = c(seq(0, 0.1, length=100),  # for red
                   seq(0.011, 10 ,length=100),           # for yellow
                   seq(10.01, max(mat_data),length=100))             # for green
    
    
    # creates a 5 x 5 inch image
    setwd(path_illustrations)
    png("heatmap_Species_pres.count.in.zoo.png",    # create PNG for the heat map        
        width = 5000,        # 5 x 300 pixels
        height = 17000,
        res = 300,            # 300 pixels per inch
        pointsize = 18)        # smaller font size
    
    #mat_data[, 1:20]
    par(mar=c(1,1,1,1))
    heatmap.3(t(mat_data[, ]),
              #cellnote = mat_data,  # same data set for cell labels
              main = "", # heat map title
              notecol="black",      # change font color of cell labels to black
              density.info="none",  # turns off density plot inside color legend
              trace="none",         # turns off trace lines inside the heat map
              margins =c(8,19),     # widens margins around plot
              col=my_palette,       # use on color palette defined earlier
              breaks=col_breaks,    # enable color transition at specified limits
              dendrogram="both",  #  draw a row, column or both dendrogram
              lhei=c(0.1,2))     #  control the heiht ratio between legend and heatmap
              #Colv="Rowv")            # turn off column clustering
    
               
    dev.off()               # close the PNG device
    
    # alternative simple legend for heatmap.2:
    legend("topleft",legend=c("red, range 0-0.1","yellow, range 0-0.1","green, range 0-0.1"),
           fill=c("red","yellow","green"), 
           border=FALSE, bty="n", y.intersp = 0.7, cex=0.7)
    
    
    #Load latest version of heatmap.3 function -- to keep both legend and manual col breaks
    library("devtools")
    source_url("https://raw.githubusercontent.com/obigriffith/biostar-tutorials/master/Heatmaps/heatmap.3.R")
    #https://cran.r-project.org/web/packages/heatmap3/vignettes/vignette.pdf
