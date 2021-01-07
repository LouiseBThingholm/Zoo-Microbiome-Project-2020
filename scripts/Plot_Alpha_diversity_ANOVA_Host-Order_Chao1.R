
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


## SIFNIF using anova

# generate a table for results

# First the overall ANOVA across all grouos at all animal-levels

res.across.groups = as.data.frame(matrix(NA, nrow=4, ncol=7 ))
names(res.across.groups) = c('Alpha_div', 'Animal_level', 'Df', 'Sum Sq', 'Mean Sq', 'F value', 'Pr(>F)')
res.across.groups$Alpha_div = 'Chao'
res.across.groups$Animal_level = c('Order', 'Family', 'Genus', 'Species')

plot(density(alpha.data$Chao))
obj.order = unlist(summary(aov(alpha.data$Chao ~ alpha.data$Tierpark + alpha.data$Order)))
res.across.groups[1,'Df'] = obj.order['Df2']
res.across.groups[1,'Sum Sq'] = obj.order['Sum Sq2']
res.across.groups[1,'Mean Sq'] = obj.order['Mean Sq2']
res.across.groups[1,'F value'] = obj.order['F value2']
res.across.groups[1,'Pr(>F)'] = obj.order['Pr(>F)2']

obj.Family = unlist(summary(aov(alpha.data$Chao ~ alpha.data$Tierpark + alpha.data$Family)))
res.across.groups[2,'Df'] = obj.Family['Df2']
res.across.groups[2,'Sum Sq'] = obj.Family['Sum Sq2']
res.across.groups[2,'Mean Sq'] = obj.Family['Mean Sq2']
res.across.groups[2,'F value'] = obj.Family['F value2']
res.across.groups[2,'Pr(>F)'] = obj.Family['Pr(>F)2']

obj.Genus = unlist(summary(aov(alpha.data$Chao ~ alpha.data$Tierpark + alpha.data$Genus)))
res.across.groups[3,'Df'] = obj.Genus['Df2']
res.across.groups[3,'Sum Sq'] = obj.Genus['Sum Sq2']
res.across.groups[3,'Mean Sq'] = obj.Genus['Mean Sq2']
res.across.groups[3,'F value'] = obj.Genus['F value2']
res.across.groups[3,'Pr(>F)'] = obj.Genus['Pr(>F)2']

obj.Species = unlist(summary(aov(alpha.data$Chao ~ alpha.data$Tierpark + alpha.data$Species)))
res.across.groups[4,'Df'] = obj.Species['Df2']
res.across.groups[4,'Sum Sq'] = obj.Species['Sum Sq2']
res.across.groups[4,'Mean Sq'] = obj.Species['Mean Sq2']
res.across.groups[4,'F value'] = obj.Species['F value2']
res.across.groups[4,'Pr(>F)'] = obj.Species['Pr(>F)2']

# save table
#setwd( file.path( path_results, "/Alpha_diversity") )
#write.table(res.across.groups, "Chao_ANOVA_across.groups.txt", col.names = T, row.names = F, quote = F, sep='\t')

# Then groupwise comparisons comparing groups with >4 samples per group

# ANIMAL-ORDER LEVEL - 4 GROUPS WITH n>4

res.across.groups = as.data.frame(matrix(NA, nrow=6, ncol=9 ))
names(res.across.groups) = c('Alpha_div', 'Animal_level', 'group1', 'group2', 'Df', 'Sum Sq', 'Mean Sq', 'F value', 'Pr(>F)')
res.across.groups$Alpha_div = 'Chao'
res.across.groups$Animal_level = c('Order')
res.across.groups$group1 = c('Artiodactyla','Artiodactyla','Artiodactyla',
                             'Carnivora','Carnivora','Perissodactyla')
res.across.groups$group2 = c('Carnivora', 'Perissodactyla','Primates',
                             'Perissodactyla','Primates','Primates')
i=1
for (i in 1:6){
  alpha.data.sub = subset(alpha.data, Order == res.across.groups$group1[i] | Order == res.across.groups$group2[i])
  table(alpha.data.sub$Order)
  obj.order = unlist(summary(aov(alpha.data.sub$Chao ~ alpha.data.sub$Tierpark + alpha.data.sub$Order)))
  
  res.across.groups[i,'Df'] = obj.order['Df2']
  res.across.groups[i,'Sum Sq'] = obj.order['Sum Sq2']
  res.across.groups[i,'Mean Sq'] = obj.order['Mean Sq2']
  res.across.groups[i,'F value'] = obj.order['F value2']
  res.across.groups[i,'Pr(>F)'] = obj.order['Pr(>F)2']
  
}
res.across.groups$Q_value = p.adjust( res.across.groups$`Pr(>F)`, method = 'BH')

# save table
setwd( file.path( path_results, "/Alpha_diversity") )
write.table(res.across.groups, "Chao_ANOVA_pairvise.groups_Order.txt", col.names = T, row.names = F, quote = F, sep='\t')


## BOXPLOT
# GGPLOT
library(RColorBrewer)
display.brewer.all()
display.brewer.pal(5, 'Purples')

brewer.pal(3, 'Purples') # 3 
brewer.pal(3, 'Reds') # 3
#brewer.pal(1, 'Greys')
"Grey" # 1
brewer.pal(3, 'Blues')
brewer.pal(7, 'YlOrRd')

col17 = c( "#EFEDF5", "#BCBDDC", "#756BB1",
           "#FEE0D2", "#FC9272", "#DE2D26",
           #"Grey",
           "#DEEBF7", "#9ECAE1", "#3182BD",
           "#FFFFB2", "#FED976", "#FEB24C", "#FD8D3C", "#FEB24C","#FFFFB2", "#FED976") #"#BD0026"

col5 = c("#756BB1", "#FB6A4A", "#9ECAE1", "#FED976")


Animal_taxonomy_Order_easyName= as.character( alpha.data$Animal_taxonomy_Order )

Animal_taxonomy_Order_easyName[Animal_taxonomy_Order_easyName=='Artiodactyla']<- 'Artiodactyla \n (even-toed ungulates)'
#Animal_taxonomy_Order_easyName[Animal_taxonomy_Order_easyName=='Diprotodontia']<- 'Diprotodontia \n (two first teeth)'
Animal_taxonomy_Order_easyName[Animal_taxonomy_Order_easyName=='Perissodactyla']<- 'Perissodactyla \n (odd-toed ungulates)'
#Animal_taxonomy_Order_easyName[Animal_taxonomy_Order_easyName=='Artiodactyla']<- 'Artiodactyla \n (cloven-hooved)'

alpha.div.matrix.meta$Animal_taxonomy_Order_easyName = Animal_taxonomy_Order_easyName



Chao <- ggplot(alpha.data, aes(x=Animal_taxonomy_Order_easyName, y=Chao)) +           
  geom_boxplot(fill = col5, colour = 'black') + # colour sets lines
  geom_jitter(width = 0.1, colour="grey60", shape=1, size=0.5) + # add dots
  theme_bw(base_size=12) +                 # theme_bw: get rid of the background colour
  theme(panel.border = element_blank()) +  # remove ourther box
  #scale_x_discrete(labels=c("Shallow","Deep"))  +       # boxes-labels
  labs(title="", x="", y = "Chao") # Title and labels
Chao

length( table(alpha.data$Animal_taxonomy_Order_zoo) )
length(col17)

Chao_zoo <- ggplot(alpha.data, aes(x=Animal_taxonomy_Order_zoo, y=Chao)) +           
  geom_boxplot(fill = col17, colour = 'black') + # colour sets lines
  geom_jitter(width = 0.1, colour="grey60", shape=1, size=0.5) + # add dots
  theme_bw(base_size=12) +                 # theme_bw: get rid of the background colour
  theme(panel.border = element_blank()) +  # remove ourther box
  #scale_x_discrete(labels=c("Shallow","Deep"))  +       # boxes-labels
  labs(title="", x="", y = "Chao") + # Title and labels
  theme(axis.text.x = element_text(angle = 40, hjust = 1))
Chao_zoo

#Chao_signif = Chao_signif + theme(plot.margin = unit(c(0,2,1,4), "lines")) # top, left,  bottom, right
Chao_signif = Chao + theme(plot.margin = unit(c(0,2,1,4), "lines")) # top, left,  bottom, right
Chao_signif
Chao_zoo = Chao_zoo + theme(plot.margin = unit(c(0,2,0,4), "lines"))
Chao_zoo

# arrange plots
library(ggpubr)
ggarrange(Chao_signif, Chao_zoo, 
          labels = c("A", "B"),
          ncol = 1, nrow = 2)

# save plots  
# TIFF
setwd( file.path(  path_illustrations, 'Alpha_div'))
tiff(paste('Boxplots_alpha.div_Chao_Order.tiff', sep=''), width = 8, height = 10, res=50, units="in", family="Helvetica") # width and height are in inches, and res is in pixels/inch
ggarrange(Chao_signif, Chao_zoo, 
          labels = c("A", "B"),
          ncol = 1, nrow = 2)
dev.off()

# png
setwd( file.path(  path_illustrations, '0_Supplement_figures'))
png(paste('Boxplots_alpha.div_Chao_Order.png', sep=''), width = 8, height = 10, res=300, units="in", family="Helvetica") # width and height are in inches, and res is in pixels/inch
ggarrange(Chao_signif, Chao_zoo, 
          labels = c("A", "B"),
          ncol = 1, nrow = 2)
dev.off()


#add_pval(Chao, pairs = list(c(1,2), c(2,3), c(1,4)),  annotation = c("***", "**","*"))









