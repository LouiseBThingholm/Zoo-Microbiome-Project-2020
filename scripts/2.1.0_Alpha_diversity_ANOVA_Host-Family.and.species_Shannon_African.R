
# ALPHA DIVERSITY
# analysis of animal grouped at family level
# anova analysis and boxplots

# DATA

#  read table of alpha diversities
setwd(path_data)

alpha.div.matrix.meta = read.table("alpha.div.matrix.meta_Africa.txt", 
                                   header = T, sep='\t')
head(alpha.div.matrix.meta)


# we select the groups with 5 or more samples in for plotting and further analysis

table(alpha.div.matrix.meta$Family)
alpha.data = subset(alpha.div.matrix.meta, 
                      Family == 'Hominidae')

table(as.character( alpha.data$Genus) ) # n=3 groups
# Homo   Pan Pongo 
# 207    57     6 

## SIFNIF using anova

# generate a table for results

# First the overall ANOVA across all grouos at all animal-levels
# This is done in the animal-order file

# Then groupwise comparisons comparing groups with >4 samples per group

# make new variable that seperates the humans into african and european

new_genus_var =  as.character( alpha.data$Genus) 
new_genus_var[as.character( alpha.data$Genus) == 'Homo' & as.character( alpha.data$Tierpark) == 'Kiel' ] = 'Homo - Kiel'
new_genus_var[as.character( alpha.data$Genus) == 'Homo' & as.character( alpha.data$Tierpark) == 'Africa' ] = 'Homo - Africa'
new_genus_var[new_genus_var == "Homo"] = 'Homo - Zoo keeper'
table(new_genus_var)
alpha.data$new_genus_var = new_genus_var

gen.names = names(table(as.character( alpha.data$new_genus_var) ))

# ANIMAL-ORDER LEVEL - 14 GROUPS WITH n>4
all.unique.comb = t(data.frame(combn(gen.names, 2)))

res.across.groups = as.data.frame(matrix(NA, nrow=nrow(all.unique.comb), ncol=9 ))
names(res.across.groups) = c('Alpha_div', 'Animal_level', 'group1', 'group2', 'Df', 'Sum Sq', 'Mean Sq', 'F value', 'Pr(>F)')
res.across.groups$Alpha_div = 'Shannon'
res.across.groups$Animal_level = c('Genus')

res.across.groups$group1 = all.unique.comb[,1]
res.across.groups$group2 = all.unique.comb[,2]
i=1

# No location correction as it correlates 100% with host for key groups e.g. Kiel vs Africa humans
#lm.obj=lm(alpha.data$Shannon_div ~ alpha.data$Tierpark)
#alpha.data$Shannon_div_res = residuals(lm.obj)


for (i in 1:(nrow(all.unique.comb))){
  print(i)
  alpha.data.sub = subset(alpha.data, new_genus_var == res.across.groups$group1[i] | new_genus_var == res.across.groups$group2[i])
  
  print(paste(table(as.character( alpha.data.sub$new_genus_var) )[1], '/', table(as.character( alpha.data.sub$new_genus_var) )[2]))
  
    obj.order = unlist(summary(aov(alpha.data.sub$Shannon_div ~  as.factor(alpha.data.sub$new_genus_var))))
    print(summary(aov(alpha.data.sub$Shannon_div ~ as.factor(alpha.data.sub$new_genus_var))))
    res.across.groups[i,'Df'] = obj.order['Df1']
    res.across.groups[i,'Sum Sq'] = obj.order['Sum Sq1']
    res.across.groups[i,'Mean Sq'] = obj.order['Mean Sq1']
    res.across.groups[i,'F value'] = obj.order['F value1']
    res.across.groups[i,'Pr(>F)'] = obj.order['Pr(>F)1']
    
}


res.across.groups$Q_value = p.adjust( res.across.groups$`Pr(>F)`, method = 'BH')
head(res.across.groups, n=10)
# save table
setwd( file.path(path_results, "Alpha_diversity") )
write.table(res.across.groups, "Shannon_ANOVA_pairvise.groups_Host.Genus__not.location.adjusted_Africa.txt", col.names = T, row.names = F, quote = F, sep='\t')


## BOXPLOT
# GGPLOT
library(RColorBrewer)
display.brewer.all()

genus_col = c(brewer.pal(9, 'Reds')[c(4,6,8)],
              brewer.pal(9, 'YlGnBu')[c(7)],
              brewer.pal(9, 'YlGn')[c(7)])

brewer.pal(9, 'PuRd')[c(7,9)]
brewer.pal(9, 'Purples')[c(7,9)]
brewer.pal(9, 'Greys')[c(7,9)]
brewer.pal(9, 'BrBG')[c(7,9)]
brewer.pal(9, 'Spectral')[c(7,9)]

col14 = c("#CBC9E2", "#9E9AC8", "#756BB1", "#54278F",
          #"#FCAE91", "#FB6A4A", "#CB181D", "Grey",
          "#DEEBF7", "#9ECAE1", 
          "Grey", "#004529", 
          "#FFFFB2", "#FED976", "#FEB24C", "#FD8D3C", "#F03B20", "#BD0026") #"#BD0026"

#col14 = c("#E31A1C", "#800026", "#225EA8", "#081D58", "#238443", "#004529", "#CE1256", "#67001F", "#6A51A3", 
#          "#3F007D", "#525252", "#000000", "#80CDC1", "#01665E")#, "#ABDDA4", "#3288BD")
length(col14)
col5 = c("#756BB1", "#FB6A4A", "Grey", "#9ECAE1", "#FED976")


table(new_genus_var)
head(alpha.data)
alpha.data$x_var = paste(alpha.data$Order, alpha.data$Family, sep = ' - ')

Shannon_div <- ggplot(alpha.data, aes(x=new_genus_var, y=Shannon_div)) +           
  geom_boxplot(fill = genus_col, colour = 'black') + # colour sets lines
  geom_jitter(width = 0.1, colour="grey60", shape=1, size=0.5) + # add dots
  theme_bw(base_size=12) +                 # theme_bw: get rid of the background colour
  theme(panel.border = element_blank()) +  # remove ourther box
  #scale_x_discrete(labels=c("Shallow","Deep"))  +       # boxes-labels
  labs(title="Hosts (Humans seperated by location, Pan and Pongo by genus)", x="", y = "Shannon") +# Title and labels
  theme(axis.text.x = element_text(angle = 40, hjust = 1))
Shannon_div


Chao_div <- ggplot(alpha.data, aes(x=new_genus_var, y=Chao)) +           
  geom_boxplot(fill = genus_col, colour = 'black') + # colour sets lines
  geom_jitter(width = 0.1, colour="grey60", shape=1, size=0.5) + # add dots
  theme_bw(base_size=12) +                 # theme_bw: get rid of the background colour
  theme(panel.border = element_blank()) +  # remove ourther box
  #scale_x_discrete(labels=c("Shallow","Deep"))  +       # boxes-labels
  labs(title="Hosts (Humans seperated by location, Pan and Pongo by genus)", x="", y = "Chao") +# Title and labels
  theme(axis.text.x = element_text(angle = 40, hjust = 1))
Chao_div


Shannon_div = Shannon_div + theme(plot.margin = unit(c(2,2,2,2), "lines"))
Chao_div = Chao_div + theme(plot.margin = unit(c(2,2,2,2), "lines"))

# arrange plots
library(ggpubr)
ggarrange(Shannon_div,Chao_div, 
          labels = c("A", "B"),
          ncol = 1, nrow = 2)

# save plots  
# PNG
setwd( file.path(  path_illustrations, 'Alpha_div'))
png(paste('Boxplots_alpha.div_Shannon_Chao_host.Genera_Africa.png', sep=''), width = 8, height = 12, res=300, units="in", family="Helvetica") # width and height are in inches, and res is in pixels/inch
ggarrange(Shannon_div,Chao_div, 
          labels = c("A", "B"),
          ncol = 1, nrow = 2)
dev.off()

setwd( file.path(  path_illustrations, '0_Supplement_figures'))
png(paste('Boxplots_alpha.div_Shannon_Chao_host.Genera_Africa.png', sep=''), width = 8, height = 12, res=300, units="in", family="Helvetica") # width and height are in inches, and res is in pixels/inch
ggarrange(Shannon_div,Chao_div, 
          labels = c("A", "B"),
          ncol = 1, nrow = 2)
dev.off()









