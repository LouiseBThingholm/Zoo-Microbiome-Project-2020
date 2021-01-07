
# BETA DIVERSITET

# DATA

ps.rowsum = readRDS( file.path(path_data_processed, "Zoo.rowsum_spe.rds"))
ps.rowsum

#Remove taxa not seen with count more than x in at least y% of the samples. 
#This protects against an OTU with small mean & trivially large C.V.
ps.rowsum.gen.cmm = filter_taxa(ps.rowsum, function(x) sum(x > 0.00) > (0.01*length(x)), TRUE)
ps.rowsum.gen.cmm
# otu_table()   OTU Table:         [ 602 taxa and 417 samples ]
ps.rowsum = ps.rowsum.gen.cmm


# select one sample per animal

listIDs_onPerAnimal = c("TieG003", "TieG024", "TieG017", "TieG022", "TieG008", "TieG023", "TieG002", "TieG004", "TieG012", "TieG009", "TieG019", "TieG031", "TieG032", "TieG020", "TieG021", "TieG025", "TieG016", "TieG066", "TieG054", "TieG052", "TieG065", "TieG062", "TieG063", "TieG064", "TieG051", "TieG038", "TieG037", "TieG041", "TieG039", "TieG040", "TieG061", "TieG140", "TieG147", "TieG067", "TieG143", "TieG149", "TieG076", "TieG075", "TieG078", "TieG124", "TieG121", "TieG122", "TieG125", "TieG101", "TieG102", "TieG128", "TieG126", "TieG105", "TiH017", "TiH023", "TiH025", "TiH010", "TiA033", "TiA018", "TiA045", "TiA038", "TiA029", "TiA016", "TiA034", "TiA044", "TiA021", "TiA013", "TiA024", "TiA031", "TiA032", "TiA026", "TiA025", "TiA039", "TiA030", "TiA022", "TiA040", "TiA006", "TiA035", "TiA007", "TiA015", "TiB002", "TiB022", "TieG119", "TiA046", "ZOL010", "ZOL011", "TieG034", "ZOL012", "Til017", "TiH001", "TiB037", "TieG013", "ZOL013", "TieG112", "TieG055", "TieG015", "TieG060", "ZOL002", "Til006", "TieG110", "ZOL003", "TieG097", "TieG096", "TiA010", "NecBac", "TieG070", "TieG085", "TieG086", "TieG082", "TieG077", "TieG050", "Til033", "TiA011", "Til004", "TieG104", "TieG106", "ZOL004", "Til038", "ZOL005", "TiB029", "Til031", "Til039", "Til025", "Til020", "TiA001", "TiB080", "TiA023", "TieG092", "TieG036", "Til014", "TiA003", "ZOL014", "TieG111", "TiB079", "TiB063", "TieG088", "TieG069", "TieG079", "TieG093", "TieG071", "TieG074", "TieG115", "TieG089", "TieG027", "Til009", "TiN011", "Til019", "Til016", "TieG053", "TiB052", "Til007", "Til022", "TiH019", "TieG095", "TieG099", "Til005", "TieG057", "TieG058", "TieG030", "TieG118", "Til013", "TiH012", "Til029", "TiA017", "Til018", "TieG109", "TieG098", "TieG107", "Til012", "ZOL006", "Til001", "TiA012", "TiB044", "TieG114", "TieG006", "TieG113", "TieG127", "Til032", "Til044", "Til011", "Til030", "Til034", "Til015", "TiA019", "TieG090", "ZOL007", "TiB075", "ZOL008St", "TiA008", "TieG035", "Til008", "TiN086", "TiN036", "TiN071", "TiN055", "TiN087", "TiN056", "TiN031", "TiN079", "TiN083", "TiN053", "TiN080", "TiN058", "TiN078", "TiN093", "TiN023", "TiN091", "TiN049", "TiN067", "TiN096", "TiN029", "TiN066", "TiN050", "TiN048", "TiN024", "TiN094", "TiN097", "TiN068", "TiN022", "TiN064", "TiN075", "TiN041", "TiN044", "TiN046", "TiN072", "TiN051", "TiN054", "TiN052", "TiN035", "TiN033", "TiN085", "TiN084", "TiN081", "TiN082", "TiN099", "TiN090", "TiN028", "TiN095", "TiN040", "TiN069", "TiN100", "TiN074", "TiN061", "TiN062", "TiN030", "TiN098", "TiN047", "TiN073", "TiN043", "TiN092", "TiN042", "TiN063", "TiN045", "TiN027", "TiN088", "TiN026", "TiN060", "TiN039", "TiN038", "TiN021", "TiN065", "TiN059", "TiN057", "TiN025", "TiN076", "TiN037", "TiN089", "TiB058", "TiB077", "TiB007", "TiB071", "TiB018", "TiB042", "TiB053", "TiB047", "TiB011", "TiB026", "TiB040", "TiB060", "TiB054", "TiB059", "TiB061", "TiB027", "TiB051", "TiB064", "TiB038", "TiB028", "TiB045", "TiB001", "TiB009", "TiB010", "TiB024", "TiB015", "TiB025", "TiB030", "TiB076", "TiB003", "TiB008", "TiB073", "TiB004", "TiB017", "TiB062", "TiB013", "TiB014", "TiB019", "TiB012", "TiH006", "Til040", "Til002", "Til027", "Til041", "TiH004", "TieG116", "Til010", "TiH007", "Til043", "TieG056", "Til026", "TieG026", "Til023", "TieG028", "TieG103", "TiH016", "TiB020", "Til036", "TiH008", "ZOL009", "TiA041", "TiA005", "TiA004", "TiN001", "TieG123", "Til035", "TieG029", "TieG080", "TiA009", "ZOL001", "TieG108", "Til024", "Til042", "Til021")
length(listIDs_onPerAnimal)
# add humans
listID_human = c("EMGE001", "EMGE002", "EMGE004", "EMGE005", "EMGE006", "EMGE007", "EMGE012", "EMGE015", "EMGE017", "EMGE020", "EMGE024", "EMGE027", "EMGE028", "EMGE041", "EMGE042", "EMGE045", "EMGE049", "EMGE050", "EMGE051", "EMGE056", "EMGE068", "EMGE072", "EMGE088", "EMGE094", "EMGE098", "EMGE103", "EMGE108", "EMGE110", "EMGE112", "EMGE121", "EMGE127", "EMGE129", "EMGE140", "EMGE143", "EMGE144", "EMGE145", "EMGE147", "EMGE149", "EMGE151", "EMGE154", "EMGE159", "EMGE160", "EMGE162", "EMGE165")
listIDs_onPerAnimal_and_human = c(listIDs_onPerAnimal, listID_human)

ps.rowsum.uniqAnimal = subset_samples(ps.rowsum, Verschickungscode %in% listIDs_onPerAnimal_and_human)
ps.rowsum.uniqAnimal

# ORDER ANIMAL LEVEL
# we select the groups with 5 or more samples in for plotting and further analysis

# ORDER
table(sample_data(ps.rowsum.uniqAnimal)$Order)
ps.rowsum.uniqAnimal.ord = subset_samples(ps.rowsum.uniqAnimal, Order == 'Artiodactyla' |
                                            Order == 'Carnivora' | 
                                            Order == 'Perissodactyla' |
                                            Order == 'Primates')
ps.rowsum.uniqAnimal.ord
table(sample_data(ps.rowsum.uniqAnimal.ord)$Order)

# FAMILY
table(sample_data(ps.rowsum.uniqAnimal)$Family)[ 
  table(sample_data(ps.rowsum.uniqAnimal)$Family) > 4 ]

ps.rowsum.uniqAnimal.fam = subset_samples(ps.rowsum.uniqAnimal,Family == 'Bovidae' |
                                            Family == 'Callitrichidae' | 
                                            Family == 'Camelidae' |
                                            Family == 'Cebidae' |
                                            Family == 'Cercopithecidae' |
                                            Family == 'Cervidae' | 
                                            Family == 'Equidae' |
                                            Family == 'Hominidae' |
                                            Family == 'Hylobatidae' |
                                            Family == 'Lemuridae' |
                                            Family == 'Macropodidae' |
                                            Family == 'Procyonidae' |
                                            Family == 'Suidae' |Family == 'Ursidae')


ps.rowsum.uniqAnimal.fam
table(sample_data(ps.rowsum.uniqAnimal.fam)$Family)

# GENUS
(table(sample_data(ps.rowsum.uniqAnimal)$Genus)[ 
  table(sample_data(ps.rowsum.uniqAnimal)$Genus) > 4 ])

ps.rowsum.uniqAnimal.gen = subset_samples(ps.rowsum.uniqAnimal, Genus == 'Bos' |
                                            Genus == 'Callithrix' | Genus == "Capra" | 
                                            Genus == "Equus" | Genus == "Homo" | Genus == "Hylobates" | Genus == "Lemur" | 
                                            Genus == "Macaca" | Genus == "Macropus" | Genus == "Nasua" | 
                                            Genus == "Ovis" | Genus == "Pan" | Genus == "Pongo" | 
                                            Genus == "Procyon" | Genus == "Rangifer" | Genus == "Saguinus" | Genus == "Saimiri" | 
                                            Genus == "Sus" | Genus == "Ursus" | Genus == "Varecia" | Genus == "Vicugna")


ps.rowsum.uniqAnimal.gen
table(sample_data(ps.rowsum.uniqAnimal.gen)$Genus)

# SPECIES

sample_data(ps.rowsum.uniqAnimal)$Species = sample_data(ps.rowsum.uniqAnimal)$Species..englisch.

length(table(sample_data(ps.rowsum.uniqAnimal)$Species)[ 
  table(sample_data(ps.rowsum.uniqAnimal)$Species) > 4 ])
names(table(sample_data(ps.rowsum.uniqAnimal)$Species)[ 
  table(sample_data(ps.rowsum.uniqAnimal)$Species) > 4 ])

ps.rowsum.uniqAnimal.spe = subset_samples(ps.rowsum.uniqAnimal, Species == 'Barbary macaque' |
                                            Species == 'Celebes crested macaque' | 
                                            Species == "Chimp" | 
                                            Species == "Domestic Cattle" | 
                                            Species == "Domestic sheep" | 
                                            Species == "Donkey" | 
                                            Species == "Goat" | 
                                            Species == "Horse" | 
                                            Species == "Human" | 
                                            Species == "Miniature donkey" | 
                                            
                                            Species == "Racoon" | 
                                            Species == "Red ruffed lemur" | 
                                            Species == "Reindeer" | 
                                            Species == "Ring-tailed coati" | 
                                            Species == "Ring-tailed lemur" | 
                                            Species == "Squirrel monkey" | 
                                            Species == "Sumatran orangutan" | 
                                            Species == "Tammar or red-necked wallaby" | 
                                            Species == "Vicuna" | 
                                            Species == "White-handed gibbon" | 
                                            Species == "White-tufted-ear marmoset" | 
                                            Species == "Wild boar")
ps.rowsum.uniqAnimal.spe
table(sample_data(ps.rowsum.uniqAnimal.spe)$Species)




# SIGNIF USING ADONIS

# First  across all groups at all animal-levels
# This is saved in a log file 


res= data.frame(matrix(NA, ncol=5, nrow=4))
names(res) = c('Level', 'Zoo R2', 'Zoo P', 'Phylogeny R2', 'Phylogeny P')
res$Level = c("Order", "Family", "Genus", "Species")
rownames(res) = c("Order", "Family", "Genus", "Species")
res


setwd( file.path(path_results, "Beta_diversity"))
logfile = "Beta-diversity_ADONIS_Across.all.animal-groups_min1samp.txt"
sink(logfile)

print(("ORDER")); cat("\n")

  print(("Taxonomy"))
  ord.1 = (adonis2(otu_table(ps.rowsum.uniqAnimal.ord) ~ sample_data(ps.rowsum.uniqAnimal.ord)$Tierpark +
            sample_data(ps.rowsum.uniqAnimal.ord)$Order, method = 'bray', perm=999))
  print(ord.1)
  res['Order', 'Phylogeny R2'] = ord.1$R2[2]
  res['Order', 'Phylogeny P']  = ord.1$`Pr(>F)`[2]
  
  cat("\n");print(("Zoo"))
  ord.2 = (adonis2(otu_table(ps.rowsum.uniqAnimal.ord) ~ sample_data(ps.rowsum.uniqAnimal.ord)$Order +
                  sample_data(ps.rowsum.uniqAnimal.ord)$Tierpark, method = 'bray', perm=999))
  print(ord.2)
  res['Order', 'Zoo R2'] = ord.2$R2[2]
  res['Order', 'Zoo P']  = ord.2$`Pr(>F)`[2]
  
cat("\n"); print(("-----------------------")); cat("\n")
print(("FAMILY")); cat("\n")
    print(("Taxonomy"))
    fam.1=(adonis2(otu_table(ps.rowsum.uniqAnimal.fam) ~ sample_data(ps.rowsum.uniqAnimal.fam)$Tierpark +
                    sample_data(ps.rowsum.uniqAnimal.fam)$Family, method = 'bray', perm=999))
    print(fam.1)
    res['Family', 'Phylogeny R2'] = fam.1$R2[2]
    res['Family', 'Phylogeny P']  = fam.1$`Pr(>F)`[2]
    
    
    cat("\n");print(("Zoo"))
    fam.2 = (adonis2(otu_table(ps.rowsum.uniqAnimal.fam) ~ sample_data(ps.rowsum.uniqAnimal.fam)$Family +
                    sample_data(ps.rowsum.uniqAnimal.fam)$Tierpark, method = 'bray', perm=999))
    
    print(fam.2)
    res['Family', 'Zoo R2'] = fam.2$R2[2]
    res['Family', 'Zoo P']  = fam.2$`Pr(>F)`[2]
    
  
cat("\n"); print(("-----------------------")); cat("\n")
print(("GENUS")); cat("\n")
    print(("Taxonomy"))
    gen.1 = (adonis2(otu_table(ps.rowsum.uniqAnimal.gen) ~ sample_data(ps.rowsum.uniqAnimal.gen)$Tierpark +
                    sample_data(ps.rowsum.uniqAnimal.gen)$Genus, method = 'bray', perm=999))
    
    print(gen.1)
    res['Genus', 'Phylogeny R2'] = gen.1$R2[2]
    res['Genus', 'Phylogeny P']  = gen.1$`Pr(>F)`[2]
    
    cat("\n");print(("Zoo"))
    gen.2 = (adonis2(otu_table(ps.rowsum.uniqAnimal.gen) ~ sample_data(ps.rowsum.uniqAnimal.gen)$Genus +
                    sample_data(ps.rowsum.uniqAnimal.gen)$Tierpark, method = 'bray', perm=999))
    
    print(gen.2)
    res['Genus', 'Zoo R2'] = gen.2$R2[2]
    res['Genus', 'Zoo P']  = gen.2$`Pr(>F)`[2]
    

cat("\n"); print(("-----------------------")); cat("\n")
print(("SPECIES")); cat("\n")
    print(("Taxonomy"))
    spe.1 = (adonis2(otu_table(ps.rowsum.uniqAnimal.spe) ~ sample_data(ps.rowsum.uniqAnimal.spe)$Tierpark +
                    sample_data(ps.rowsum.uniqAnimal.spe)$Species, method = 'bray', perm=999))
    
    print(spe.1)
    res['Species', 'Phylogeny R2'] = spe.1$R2[2]
    res['Species', 'Phylogeny P']  = spe.1$`Pr(>F)`[2]
    
    cat("\n");print(("Zoo"))
    spe.2 = (adonis2(otu_table(ps.rowsum.uniqAnimal.spe) ~ sample_data(ps.rowsum.uniqAnimal.spe)$Species +
                    sample_data(ps.rowsum.uniqAnimal.spe)$Tierpark, method = 'bray', perm=999))
    print(spe.2)
    res['Species', 'Zoo R2'] = spe.2$R2[2]
    res['Species', 'Zoo P']  = spe.2$`Pr(>F)`[2]
    
sink()

res$Phylogeny_Q = p.adjust(res$`Phylogeny P`, method = 'BH')
res$Zoo_Q = p.adjust(res$`Zoo P`, method = 'BH')
res

setwd(path_table)
write.table(res, 'Summary_stats__adonis_Phylogeny_min1samp.txt', col.names = T, row.names = F, sep='\t', quote = F)

setwd( file.path(path_table, '0_Supplementary_tables'))
write.table(res, 'Table_S3__Summary_stats__adonis_Phylogeny_min1samp.txt', col.names = T, row.names = F, sep='\t', quote = F)

# turn into a grob table:
p.res=res
rownames(p.res) = NULL
p.res=p.res[, c(1,2,6,4,7)]
g <- tableGrob(p.res, theme = ttheme_minimal())
separators <- replicate(ncol(g) - 2,
                        segmentsGrob(x1 = unit(0, "npc"), gp=gpar(lty=2)),
                        simplify=FALSE)
## add vertical lines on the left side of columns (after 2nd)
g <- gtable::gtable_add_grob(g, grobs = separators,
                             t = 2, b = nrow(g), l = seq_len(ncol(g)-2)+2)

plot.new()
grid.draw(g)

