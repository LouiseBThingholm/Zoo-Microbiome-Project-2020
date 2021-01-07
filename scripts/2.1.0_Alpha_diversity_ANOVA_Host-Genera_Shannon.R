
# ALPHA DIVERSITY
# analysis of animal grouped at genus level
# anova analysis and boxplots

# DATA

#  read table of alpha diversities
setwd(path_data)

alpha.div.matrix.meta = read.table("alpha.div.matrix.meta.txt", 
                                   header = T, sep='\t')
head(alpha.div.matrix.meta)


# we select the groups with 5 or more samples in for plotting and further analysis

# n>4
table(alpha.div.matrix.meta$Genus)
names(table(alpha.div.matrix.meta$Genus)[ table(alpha.div.matrix.meta$Genus) > 4 ])

alpha.data = subset(alpha.div.matrix.meta, Genus == 'Bos' |
                      Genus == 'Callithrix' | 
                      Genus == "Capra" | 
                      Genus == "Equus" | 
                      Genus == "Homo" | 
                      Genus == "Hylobates" | 
                      Genus == "Lemur" | 
                      Genus == "Macaca" | 
                      Genus == "Macropus" | 
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

table(as.character( alpha.data$Genus) ) # n=21 groups
length(table(as.character( alpha.data$Genus) ))
fam.names = names(table(as.character( alpha.data$Genus) ))

## SIFNIF using anova

# generate a table for results

# First the overall ANOVA across all grouos at all animal-levels
# This is done in the animal-order file

# Then groupwise comparisons comparing groups with >4 samples per group

# ANIMAL-ORDER LEVEL 
all.unique.comb = t(data.frame(combn(fam.names, 2)))

res.across.groups = as.data.frame(matrix(NA, nrow=nrow(all.unique.comb), ncol=9 ))
names(res.across.groups) = c('Alpha_div', 'Animal_level', 'group1', 'group2', 'Df', 'Sum Sq', 'Mean Sq', 'F value', 'Pr(>F)')
res.across.groups$Alpha_div = 'Shannon'
res.across.groups$Animal_level = c('Genus')

res.across.groups$group1 = all.unique.comb[,1]
res.across.groups$group2 = all.unique.comb[,2]

lm.obj=lm(alpha.data$Shannon_div ~ alpha.data$Tierpark)
alpha.data$Shannon_div_res = residuals(lm.obj)


i=1
for (i in 1:(nrow(all.unique.comb))){
  print(i)
  alpha.data.sub = subset(alpha.data, Genus == res.across.groups$group1[i] | Genus == res.across.groups$group2[i])
  table(as.character( alpha.data.sub$Genus) )
  n.Tierpark = length(names(table(as.character(alpha.data.sub$Tierpark))))


    obj.order = unlist(summary(aov(alpha.data.sub$Shannon_div_res ~ as.factor(alpha.data.sub$Genus))))
    print(summary(aov(alpha.data.sub$Shannon_div_res ~  as.factor(alpha.data.sub$Genus))))
    res.across.groups[i,'Df'] = obj.order['Df1']
    res.across.groups[i,'Sum Sq'] = obj.order['Sum Sq1']
    res.across.groups[i,'Mean Sq'] = obj.order['Mean Sq1']
    res.across.groups[i,'F value'] = obj.order['F value1']
    res.across.groups[i,'Pr(>F)'] = obj.order['Pr(>F)1']

}



res.across.groups$Q_value = p.adjust( res.across.groups$`Pr(>F)`, method = 'BH')
head(res.across.groups)

# save table
setwd( file.path(path_results, "Alpha_diversity") )
write.table(res.across.groups, "Shannon_ANOVA_pairvise.groups_Genus.txt", col.names = T, row.names = F, quote = F, sep='\t')








