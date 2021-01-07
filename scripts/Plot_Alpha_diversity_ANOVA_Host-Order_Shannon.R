
# ALPHA DIVERSITY

# DATA

#  read table of alpha diversities
setwd(path_data)
alpha.div.matrix.meta = read.table("alpha.div.matrix.meta.txt", 
                                   header = T, sep='\t')
head(alpha.div.matrix.meta)


# we select the groups with 5 or more samples in for plotting and further analysis

table(alpha.div.matrix.meta$Animal_taxonomy_Order)
alpha.data = subset(alpha.div.matrix.meta, Animal_taxonomy_Order == 'Artiodactyla' |
                      Animal_taxonomy_Order == 'Carnivora' | 
                      #Animal_taxonomy_Order == 'Diprotodontia' |
                      Animal_taxonomy_Order == 'Perissodactyla' |
                      Animal_taxonomy_Order == 'Primates' )




## BOXPLOT
# GGPLOT
library(RColorBrewer)
display.brewer.all()
display.brewer.pal(5, 'Purples')
brewer.pal(3, 'Purples')
brewer.pal(4, 'Reds')
#brewer.pal(1, 'Greys')
"Grey"
brewer.pal(3, 'Blues')
brewer.pal(6, 'YlOrRd')

col17 = c("#EFEDF5", "#BCBDDC", "#756BB1",
          "#FEE5D9", "#FCAE91", "#FB6A4A", 
          "#DEEBF7", "#9ECAE1", "#3182BD", 
          "darkgoldenrod1", "#FFFFB2", "#FED976", "#FEB24C", "#FD8D3C", "#F03B20", "#BD0026") #"#BD0026"

col5 = c("#756BB1", "#FB6A4A",  "#9ECAE1", "#FED976")

Animal_taxonomy_Order_easyName= as.character( alpha.data$Animal_taxonomy_Order )


Animal_taxonomy_Order_easyName[Animal_taxonomy_Order_easyName=='Artiodactyla']<- 'Artiodactyla \n (even-toed ungulates)'
#Animal_taxonomy_Order_easyName[Animal_taxonomy_Order_easyName=='Diprotodontia']<- 'Diprotodontia \n (two first teeth)'
Animal_taxonomy_Order_easyName[Animal_taxonomy_Order_easyName=='Perissodactyla']<- 'Perissodactyla \n (odd-toed ungulates)'
#Animal_taxonomy_Order_easyName[Animal_taxonomy_Order_easyName=='Artiodactyla']<- 'Artiodactyla \n (cloven-hooved)'

alpha.div.matrix.meta$Animal_taxonomy_Order_easyName = Animal_taxonomy_Order_easyName


Shannon_div <- ggplot(alpha.data, aes(x=Animal_taxonomy_Order_easyName, y=Shannon_div)) +           
  geom_boxplot(fill = col5, colour = 'black') + # colour sets lines
  geom_jitter(width = 0.1, colour="grey60", shape=1, size=0.5)   +# add dots
  theme_bw(base_size=12) +                 # theme_bw: get rid of the background colour
  theme(panel.border = element_blank()) +  # remove ourther box
  #scale_x_discrete(labels=c("Shallow","Deep"))  +       # boxes-labels
  labs(title="", x="", y = "Shannon") + # Title and labels
  theme(axis.text.x = element_text(angle = 40, hjust = 1))
Shannon_div


Shannon_div_signif = Shannon_div + 
  geom_signif(comparisons=list(c("Carnivora", "Perissodactyla \n (odd-toed ungulates)")), #
              annotations="***", y_position = 6.6, tip_length = 0.01, vjust=0.4) +
  geom_signif(comparisons=list(c("Artiodactyla \n (even-toed ungulates)", "Carnivora")), #
              annotations="***",y_position = 6.5, tip_length = 0.01, vjust=0.4) +
  geom_signif(comparisons=list(c("Perissodactyla \n (odd-toed ungulates)", "Primates")), 
              annotations="***",y_position = 6.8, tip_length = 0.01, vjust=0.4) +
  geom_signif(comparisons=list(c("Artiodactyla \n (even-toed ungulates)", "Primates")), #
              annotations="***",y_position = 7.0, tip_length = 0.01, vjust=0.4)  +
  geom_signif(comparisons=list(c("Carnivora", "Primates")), #
              annotations="***",y_position = 7.3, tip_length = 0.01, vjust=0.4) 


length( table(alpha.data$Animal_taxonomy_Order_zoo) )
length(col17)

Shannon_div_zoo <- ggplot(alpha.data, aes(x=Animal_taxonomy_Order_zoo, y=Shannon_div)) +           
  geom_boxplot(fill = col17, colour = 'black') + # colour sets lines
  geom_jitter(width = 0.1, colour="grey60", shape=1, size=0.5) + # add dots
  theme_bw(base_size=12) +                 # theme_bw: get rid of the background colour
  theme(panel.border = element_blank()) +  # remove ourther box
  #scale_x_discrete(labels=c("Shallow","Deep"))  +       # boxes-labels
  labs(title="", x="", y = "Shannon") + # Title and labels
  theme(axis.text.x = element_text(angle = 40, hjust = 1))
Shannon_div_zoo

Shannon_div_signif = Shannon_div_signif + theme(plot.margin = unit(c(0,2,1,4), "lines")) #  top, left, bottom, right,
Shannon_div_signif
Shannon_div_zoo = Shannon_div_zoo + theme(plot.margin = unit(c(0,2,0,4), "lines"))
Shannon_div_zoo

# arrange plots
library(ggpubr)
ggarrange(Shannon_div_signif, Shannon_div_zoo, 
          labels = c("A", "B"),
          ncol = 1, nrow = 2)

# save plots  
# TIFF
setwd( file.path(  path_illustrations, 'Alpha_div'))
tiff(paste('Boxplots_alpha.div_Shannon_Order.tiff', sep=''), width = 8, height = 10, res=100, units="in", family="Helvetica") # width and height are in inches, and res is in pixels/inch
ggarrange(Shannon_div_signif, Shannon_div_zoo, 
          labels = c("A", "B"),
          ncol = 1, nrow = 2)
dev.off()

# PNG
setwd( file.path(  path_illustrations, 'Alpha_div'))
png(paste('Boxplots_alpha.div_Shannon_Order.png', sep=''), width = 8, height = 10, res=300, units="in", family="Helvetica") # width and height are in inches, and res is in pixels/inch
ggarrange(Shannon_div_signif, Shannon_div_zoo, 
          labels = c("A", "B"),
          ncol = 1, nrow = 2)
dev.off()



## DIET


col5 = c("#756BB1", "#FB6A4A", "Grey", "#9ECAE1", "#FED976")
col3 = c("#FB6A4A", "#756BB1", "#FED976")
col3_rum = c("Grey",  '#238B45')

Shannon_div_Diet_Orientation <- ggplot(alpha.data, aes(x=Diet_Orientation, y=Shannon_div)) +           
  geom_boxplot(fill = col3, colour = 'black') + # colour sets lines
  geom_jitter(width = 0.1, colour="grey60", shape=1, size=0.5) + # add dots
  theme_bw(base_size=12) +                 # theme_bw: get rid of the background colour
  theme(panel.border = element_blank()) +  # remove ourther box
  #scale_x_discrete(labels=c("Shallow","Deep"))  +       # boxes-labels
  labs(title="", x="", y = "Shannon") + # Title and labels
  theme(axis.text.x = element_text(angle = 40, hjust = 1))
Shannon_div_Diet_Orientation


Shannon_div_Diet_Orientation_signif = Shannon_div_Diet_Orientation + 
  geom_signif(comparisons=list(c("Carnivore", "Herbivores")), #
              annotations="**", y_position = 6.7, tip_length = 0.01, vjust=0.4) +
  geom_signif(comparisons=list(c("Carnivore", "Omnivore")), #
              annotations="**",y_position = 6.5, tip_length = 0.01, vjust=0.4) +
  geom_signif(comparisons=list(c("Herbivores", "Omnivore")), 
              annotations="***",y_position = 6.8, tip_length = 0.01, vjust=0.4) 

table(alpha.data$Digestion_RuminantsNonRuminants)

Shannon_Ruminants <- ggplot(alpha.data, aes(x=Digestion_RuminantsNonRuminants, y=Shannon_div)) +           
  geom_boxplot(fill = col3_rum, colour = 'black') + # colour sets lines
  geom_jitter(width = 0.1, colour="grey60", shape=1, size=0.5) + # add dots
  theme_bw(base_size=12) +                 # theme_bw: get rid of the background colour
  theme(panel.border = element_blank()) +  # remove ourther box
  #scale_x_discrete(labels=c("Shallow","Deep"))  +       # boxes-labels
  labs(title="", x="", y = "Shannon") + # Title and labels
  theme(axis.text.x = element_text(angle = 40, hjust = 1))
Shannon_Ruminants

Shannon_Ruminants_signif = Shannon_Ruminants + 
  geom_signif(comparisons=list(c("NonRuminants", "Ruminants")), #
              annotations="***",y_position = 6.5, tip_length = 0.01, vjust=0.4) 


Shannon_div_Diet_Orientation_signif = Shannon_div_Diet_Orientation_signif + theme(plot.margin = unit(c(0,2,1,4), "lines")) #bottom, right, top, left
Shannon_div_Diet_Orientation_signif
Shannon_Ruminants_signif = Shannon_Ruminants_signif + theme(plot.margin = unit(c(3,2,0,4), "lines"))
Shannon_Ruminants_signif

# arrange plots
library(ggpubr)
ggarrange(Shannon_div_Diet_Orientation_signif, Shannon_Ruminants_signif, 
          labels = c("A", "B"),
          ncol = 1, nrow = 2)


Shannon_div_signif = Shannon_div_signif + theme(plot.margin = unit(c(0,1,1,4), "lines")) #  top, right, bottom, left,
Shannon_div_signif
Shannon_div_zoo = Shannon_div_zoo + theme(plot.margin = unit(c(0,1,0,4), "lines"))
Shannon_div_zoo
Shannon_div_Diet_Orientation_signif = Shannon_div_Diet_Orientation_signif + theme(plot.margin = unit(c(0,2,1,1), "lines")) #bottom, right, top, left
Shannon_div_Diet_Orientation_signif
Shannon_Ruminants_signif = Shannon_Ruminants_signif + theme(plot.margin = unit(c(0,2,0,1), "lines"))
Shannon_Ruminants_signif


# PNG
setwd( file.path(  path_illustrations, 'Alpha_div'))
png(paste('Boxplots_alpha.div_Shannon_Order_and_Diet.png', sep=''), width = 8, height = 10, res=300, units="in", family="Helvetica") # width and height are in inches, and res is in pixels/inch
ggarrange(Shannon_div_signif, Shannon_div_Diet_Orientation_signif,
          Shannon_div_zoo, Shannon_Ruminants_signif, 
          labels = c("A", "B", "C", "D"),
          ncol = 2, nrow = 2, widths = c(1.5, 1))
dev.off()

setwd( file.path(  path_illustrations, '0_Main_figures'))
png(paste('Figure 2 - Boxplots_alpha.div_Shannon_Order_and_Diet.png', sep=''), width = 8, height = 10, res=300, units="in", family="Helvetica") # width and height are in inches, and res is in pixels/inch
ggarrange(Shannon_div_signif, Shannon_div_Diet_Orientation_signif,
          Shannon_div_zoo, Shannon_Ruminants_signif, 
          labels = c("A", "B", "C", "D"),
          ncol = 2, nrow = 2, widths = c(1.5, 1))
dev.off()


