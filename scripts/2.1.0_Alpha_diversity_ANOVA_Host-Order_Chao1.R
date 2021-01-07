
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
    plot(aov(alpha.data$Chao ~ alpha.data$Tierpark + alpha.data$Order))
    
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
    
    res.across.groups
    
    # save table
    setwd( file.path( path_results, "/Alpha_diversity") )
    write.table(res.across.groups, "Chao_ANOVA_across.groups.txt", col.names = T, row.names = F, quote = F, sep='\t')

# Then groupwise comparisons comparing groups with >4 samples per group
    
    res.across.groups = as.data.frame(matrix(NA, nrow=6, ncol=9 ))
    names(res.across.groups) = c('Alpha_div', 'Animal_level', 'group1', 'group2', 'Df', 'Sum Sq', 'Mean Sq', 'F value', 'Pr(>F)')
    res.across.groups$Alpha_div = 'Chao'
    res.across.groups$Animal_level = c('Order')
    
    order.names = names(table(as.character( alpha.data$Order) ))
    all.unique.comb = t(data.frame(combn(order.names, 2)))
    
    res.across.groups$group1 = all.unique.comb[,1]
    res.across.groups$group2 = all.unique.comb[,2]
    
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
    res.across.groups
    
    setwd( file.path( path_results, "/Alpha_diversity") )
    write.table(res.across.groups, "Chao_ANOVA_pairvise.groups_Order.txt", col.names = T, row.names = F, quote = F, sep='\t')








