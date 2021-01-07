
# ALPHA DIVERSITY

# DATA

#  read table of alpha diversities
setwd(path_data)

alpha.div.matrix.meta = read.table("alpha.div.matrix.meta.txt", 
                                   header = T, sep='\t')
head(alpha.div.matrix.meta)


# HOST FAMILY
  
  # we select the groups with 5 or more samples in for plotting and further analysis
  
  table(alpha.div.matrix.meta$Family)
  alpha.data_FAM = subset(alpha.div.matrix.meta, Family == 'Bovidae' |
                        Family == 'Callitrichidae' | 
                        Family == 'Camelidae' |
                        Family == 'Cebidae' |
                        Family == 'Cercopithecidae' |
                        Family == 'Cervidae' | 
                        Family == 'Equidae' |
                        Family == 'Hominidae' |
                        Family == 'Hylobatidae' |
                        Family == 'Lemuridae' |
                        #Family == 'Macropodidae' |
                        Family == 'Procyonidae' |
                        Family == 'Suidae' |Family == 'Ursidae' )
  
  table(as.character( alpha.data_FAM$Family) ) # n=13 groups
  fam.names = names(table(as.character( alpha.data_FAM$Family) ))
  


## BOXPLOT - SHANNON
# GGPLOT

display.brewer.all()

brewer.pal(9, 'YlOrRd')[c(7,9)]
brewer.pal(9, 'YlGnBu')[c(7,9)]
brewer.pal(9, 'YlGn')[c(7,9)]
brewer.pal(9, 'PuRd')[c(7,9)]
brewer.pal(9, 'Purples')[c(7,9)]
brewer.pal(9, 'Greys')[c(7,9)]
brewer.pal(9, 'BrBG')[c(7,9)]
brewer.pal(9, 'Spectral')[c(7,9)]

col13 = c("#CBC9E2", "#9E9AC8", "#756BB1", "#54278F",
          #"#FCAE91", "#FB6A4A", "#CB181D", "Grey",
          "#DEEBF7", "#9ECAE1", 
           "#004529", 
          "#FFFFB2", "#FED976", "#FEB24C", "#FD8D3C", "#F03B20", "#BD0026") #"#BD0026"

length(col13)
col5 = c("#756BB1", "#FB6A4A", "Grey", "#9ECAE1", "#FED976")


head(alpha.data_FAM)
alpha.data_FAM$x_var = paste(alpha.data_FAM$Order, alpha.data_FAM$Family, sep = ' - ')

Shannon_div_FAM <- ggplot(alpha.data_FAM, aes(x=x_var, y=Shannon_div)) +           
  geom_boxplot(fill = col13, colour = 'black') + # colour sets lines
  geom_jitter(width = 0.1, colour="grey60", shape=1, size=0.5) + # add dots
  theme_bw(base_size=10) +                 # theme_bw: get rid of the background colour
  theme(panel.border = element_blank()) +  # remove ourther box
  #scale_x_discrete(labels=c("Shallow","Deep"))  +       # boxes-labels
  labs(title="", x="", y = "Shannon") +# Title and labels
  theme(axis.text.x = element_text(angle = 40, hjust = 1))
Shannon_div_FAM

Chao_div_FAM <- ggplot(alpha.data_FAM, aes(x=x_var, y=Chao)) +           
  geom_boxplot(fill = col13, colour = 'black') + # colour sets lines
  geom_jitter(width = 0.1, colour="grey60", shape=1, size=0.5) + # add dots
  theme_bw(base_size=10) +                 # theme_bw: get rid of the background colour
  theme(panel.border = element_blank()) +  # remove ourther box
  #scale_x_discrete(labels=c("Shallow","Deep"))  +       # boxes-labels
  labs(title="", x="", y = "Chao") +# Title and labels
  theme(axis.text.x = element_text(angle = 40, hjust = 1))
Chao_div_FAM

# HOST GENERA


# we select the groups with 5 or more samples in for plotting and further analysis

# n>4
table(alpha.div.matrix.meta$Genus)
names(table(alpha.div.matrix.meta$Genus)[ table(alpha.div.matrix.meta$Genus) > 4 ])

alpha.data_GEN = subset(alpha.div.matrix.meta, Genus == 'Bos' |
                      Genus == 'Callithrix' | 
                      Genus == "Capra" | 
                      Genus == "Equus" | 
                      Genus == "Homo" | 
                      Genus == "Hylobates" | 
                      Genus == "Lemur" | 
                      Genus == "Macaca" | 
                      #Genus == "Macropus" | 
                      Genus == "Nasua" | 
                      Genus == "Ovis" | 
                      Genus == "Pan" | 
                      Genus == "Pongo" | 
                      Genus == "Procyon" | 
                      Genus == "Rangifer" | 
                      Genus == "Saguinus" | 
                      Genus == "Saimiri" | 
                      Genus == "Sus" | 
                      Genus == "Ursus" | 
                      Genus == "Varecia" | 
                      Genus == "Vicugna" )

table(as.character( alpha.data_GEN$Genus) ) # n=20 groups
length(table(as.character( alpha.data_GEN$Genus) ))
fam.names = names(table(as.character( alpha.data_GEN$Genus) ))



col21 = c("#FED976", "#FEB24C", "#FD8D3C", "#FC4E2A", "#E31A1C", "#BD0026", # 6*
          "#1D91C0", "#225EA8", "#253494", # 3* car
          "#525252", 
          #"#000000", 
          "#F7FCF5", "#E5F5E0", "#C7E9C0", "#A1D99B", "#74C476", "#41AB5D", "#238B45", "#006D2C", "#00441B", "#80CDC1")

alpha.data_GEN$x_var = paste(alpha.data_GEN$Order, alpha.data_GEN$Genus, sep = ' - ')

Shannon_div_GEN <- ggplot(alpha.data_GEN, aes(x=x_var, y=Shannon_div)) +           
  geom_boxplot(fill = col21, colour = 'black') + # colour sets lines
  geom_jitter(width = 0.1, colour="grey60", shape=1, size=0.5) + # add dots
  theme_bw(base_size=10) +                 # theme_bw: get rid of the background colour
  theme(panel.border = element_blank()) +  # remove ourther box
  #scale_x_discrete(labels=c("Shallow","Deep"))  +       # boxes-labels
  labs(title="", x="", y = "Shannon") +# Title and labels
  theme(axis.text.x = element_text(angle = 40, hjust = 1))
Shannon_div_GEN

Chao_div_GEN <- ggplot(alpha.data_GEN, aes(x=x_var, y=Chao)) +           
  geom_boxplot(fill = col21, colour = 'black') + # colour sets lines
  geom_jitter(width = 0.1, colour="grey60", shape=1, size=0.5) + # add dots
  theme_bw(base_size=10) +                 # theme_bw: get rid of the background colour
  theme(panel.border = element_blank()) +  # remove ourther box
  #scale_x_discrete(labels=c("Shallow","Deep"))  +       # boxes-labels
  labs(title="", x="", y = "Chao") +# Title and labels
  theme(axis.text.x = element_text(angle = 40, hjust = 1))
Chao_div_GEN


###############
# arrange plots ***************
##############

Shannon_div_FAM = Shannon_div_FAM + theme(plot.margin = unit(c(0,0,0,2), "lines"))
Chao_div_FAM = Chao_div_FAM + theme(plot.margin = unit(c(0,1,0,2), "lines"))
Shannon_div_GEN = Shannon_div_GEN + theme(plot.margin = unit(c(0,0,0,2), "lines"))
Chao_div_GEN = Chao_div_GEN + theme(plot.margin = unit(c(0,1,0,2), "lines"))


ggarrange(Shannon_div_FAM, Chao_div_FAM,
          Shannon_div_GEN, Chao_div_GEN,
          labels = c("A", "B", "C", "D"),
          ncol = 2, nrow = 2)


# save plots  
# TIFF
setwd( file.path(  path_illustrations, '0_Supplement_figures'))
png(paste('Boxplots_alpha.div_Shannon_Chao_Family_Genera.png', sep=''), width = 8, height = 8, res=300, units="in", family="Helvetica") # width and height are in inches, and res is in pixels/inch
ggarrange(Shannon_div_FAM, Chao_div_FAM,
          Shannon_div_GEN, Chao_div_GEN,
          labels = c("A", "B", "C", "D"),
          ncol = 2, nrow = 2)
dev.off()









