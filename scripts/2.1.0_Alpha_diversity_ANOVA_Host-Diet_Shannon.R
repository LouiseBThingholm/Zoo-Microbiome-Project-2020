
# ALPHA DIVERSITY

source(file.path(path_scripts, "/1_MASTERFILE.R"))

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
    
    res.across.groups = as.data.frame(matrix(NA, nrow=2, ncol=7 ))
    names(res.across.groups) = c('Alpha_div', 'Animal_level', 'Df', 'Sum Sq', 'Mean Sq', 'F value', 'Pr(>F)')
    res.across.groups$Alpha_div = 'Shannon'
    res.across.groups$Animal_level = c('Diet_Orientation', 'RuminantsNonRuminants')
    
    # plot(density(alpha.data$Shannon_div)) # check distribution
    obj.order = unlist(summary(aov(alpha.data$Shannon_div ~ alpha.data$Tierpark + alpha.data$Diet_Orientation)))
    res.across.groups[1,'Df'] = obj.order['Df2']
    res.across.groups[1,'Sum Sq'] = obj.order['Sum Sq2']
    res.across.groups[1,'Mean Sq'] = obj.order['Mean Sq2']
    res.across.groups[1,'F value'] = obj.order['F value2']
    res.across.groups[1,'Pr(>F)'] = obj.order['Pr(>F)2']
    
    obj.Family = unlist(summary(aov(alpha.data$Shannon_div ~ alpha.data$Tierpark + alpha.data$Digestion_RuminantsNonRuminants)))
    res.across.groups[2,'Df'] = obj.Family['Df2']
    res.across.groups[2,'Sum Sq'] = obj.Family['Sum Sq2']
    res.across.groups[2,'Mean Sq'] = obj.Family['Mean Sq2']
    res.across.groups[2,'F value'] = obj.Family['F value2']
    res.across.groups[2,'Pr(>F)'] = obj.Family['Pr(>F)2']
    
    # save table
    setwd( file.path( path_results, "/Alpha_diversity") )
    write.table(res.across.groups, "Shannon_ANOVA_DietOrientation.txt", col.names = T, row.names = F, quote = F, sep='\t')

# Then groupwise comparisons comparing Diet_Orientation
    
    res.across.groups = as.data.frame(matrix(NA, nrow=3, ncol=9 ))
    names(res.across.groups) = c('Alpha_div', 'Animal_level', 'group1', 'group2', 'Df', 'Sum Sq', 'Mean Sq', 'F value', 'Pr(>F)')
    res.across.groups$Alpha_div = 'Shannon'
    res.across.groups$Animal_level = c('Order')
    res.across.groups$group1 = c('Carnivore','Carnivore','Herbivores')
    res.across.groups$group2 = c('Herbivores','Omnivore','Omnivore')

    for (i in 1:3){
      alpha.data.sub = subset(alpha.data, Diet_Orientation == res.across.groups$group1[i] | Diet_Orientation == res.across.groups$group2[i])
      table(alpha.data.sub$Diet_Orientation)
      obj.order = unlist(summary(aov(alpha.data.sub$Shannon_div ~ alpha.data.sub$Tierpark + alpha.data.sub$Diet_Orientation)))
      
      res.across.groups[i,'Df'] = obj.order['Df2']
      res.across.groups[i,'Sum Sq'] = obj.order['Sum Sq2']
      res.across.groups[i,'Mean Sq'] = obj.order['Mean Sq2']
      res.across.groups[i,'F value'] = obj.order['F value2']
      res.across.groups[i,'Pr(>F)'] = obj.order['Pr(>F)2']
      
    }
    res.across.groups$Q_value = p.adjust( res.across.groups$`Pr(>F)`, method = 'BH')
    res.across.groups
    
    # save table
    setwd( file.path( path_results, "/Alpha_diversity") )
    write.table(res.across.groups, "Shannon_ANOVA_pairvise.Diet_Orientation.txt", col.names = T, row.names = F, quote = F, sep='\t')


# Then groupwise comparisons comparing Digestion_RuminantsNonRuminants
    
    table(alpha.data.sub$Digestion_RuminantsNonRuminants)
    
    res.across.groups = as.data.frame(matrix(NA, nrow=1, ncol=9 ))
    names(res.across.groups) = c('Alpha_div', 'Animal_level', 'group1', 'group2', 'Df', 'Sum Sq', 'Mean Sq', 'F value', 'Pr(>F)')
    res.across.groups$Alpha_div = 'Shannon'
    res.across.groups$Animal_level = c('Ruminant_status')
    res.across.groups$group1 = c('NonRuminants')
    res.across.groups$group2 = c('Ruminants')
    res.across.groups
    i=1
    for (i in 1:1){
      alpha.data.sub = subset(alpha.data, Digestion_RuminantsNonRuminants == res.across.groups$group1[i] | Digestion_RuminantsNonRuminants == res.across.groups$group2[i])
      table(alpha.data.sub$Digestion_RuminantsNonRuminants)
      obj.order = unlist(summary(aov(alpha.data.sub$Shannon_div ~ alpha.data.sub$Tierpark + alpha.data.sub$Digestion_RuminantsNonRuminants)))
      
      res.across.groups[i,'Df'] = obj.order['Df2']
      res.across.groups[i,'Sum Sq'] = obj.order['Sum Sq2']
      res.across.groups[i,'Mean Sq'] = obj.order['Mean Sq2']
      res.across.groups[i,'F value'] = obj.order['F value2']
      res.across.groups[i,'Pr(>F)'] = obj.order['Pr(>F)2']
      
    }
    #res.across.groups$Q_value = p.adjust( res.across.groups$`Pr(>F)`, method = 'BH')
    res.across.groups
    
    # save table
    setwd( file.path( path_results, "/Alpha_diversity") )
    write.table(res.across.groups, "Shannon_ANOVA_pairvise.RuminantsNonRuminants.txt", col.names = T, row.names = F, quote = F, sep='\t')
    
    
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
    brewer.pal(4, 'Greens')
    
    col17 = c("#EFEDF5", "#BCBDDC", "#756BB1","#FEE5D9", "#FCAE91", "#FB6A4A", "#CB181D", "Grey",
              "#DEEBF7", "#9ECAE1", 
              "#3182BD", "#FFFFB2", "#FED976", "#FEB24C", "#FD8D3C", "#F03B20", "#BD0026") #"#BD0026"
    
    col5 = c("#756BB1", "#FB6A4A", "Grey", "#9ECAE1", "#FED976")
    col3 = c("#FB6A4A", "#756BB1", "#FED976")
    col3_rum = c("Grey", "#9ECAE1", '#238B45')
    
    Shannon_div_Diet_Orientation <- ggplot(alpha.data, aes(x=Diet_Orientation, y=Shannon_div)) +           
      geom_boxplot(fill = col3, colour = 'black') + # colour sets lines
      geom_jitter(width = 0.1, colour="black") + # add dots
      theme_bw(base_size=12) +                 # theme_bw: get rid of the background colour
      theme(panel.border = element_blank()) +  # remove ourther box
      #scale_x_discrete(labels=c("Shallow","Deep"))  +       # boxes-labels
      labs(title="Shannon", x="", y = "") # Title and labels
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
      geom_boxplot(fill = col3_rum[c(2,3)], colour = 'black') + # colour sets lines
      geom_jitter(width = 0.1, colour="black") + # add dots
      theme_bw(base_size=12) +                 # theme_bw: get rid of the background colour
      theme(panel.border = element_blank()) +  # remove ourther box
      #scale_x_discrete(labels=c("Shallow","Deep"))  +       # boxes-labels
      labs(title="Shannon", x="", y = "") + # Title and labels
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
    
    # save plots  
    
    # PNG
    setwd( file.path(  path_illustrations, 'Alpha_div'))
    png(paste('Boxplots_alpha.div_Shannon_Diet.png', sep=''), width = 7, height = 12, res=300, units="in", family="Helvetica") # width and height are in inches, and res is in pixels/inch
    ggarrange(Shannon_div_Diet_Orientation_signif, Shannon_Ruminants_signif, 
              labels = c("A", "B"),
              ncol = 1, nrow = 2)
    dev.off()
    

    





