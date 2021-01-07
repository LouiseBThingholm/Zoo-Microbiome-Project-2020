
# microbiome at species level

# PREP DATA FOR BETADISPER ANALYSIS



# DATA
# use the subsampled -lowest-level- and rarefyed data. In DADA2, that is the ASV table.
ps.rowsum_glom_biom.spe = readRDS(file.path(path_data, "/16S_DADA2_processed_African/Zoo.rowsum_spe.rds"))
ps.rowsum_glom_biom.spe

# otu_table()   OTU Table:         [ 1564 taxa and 576 samples ]


#Remove 
#This protects against an OTU with small mean & trivially large C.V.
ps.rowsum.gen_biom.spe.cmm = filter_taxa(ps.rowsum_glom_biom.spe, function(x) sum(x > 0.00) > (0.005*length(x)), TRUE) # note change from 1% to 0.5% of samples 
ps.rowsum.gen_biom.spe.cmm
#otu_table()   OTU Table:         [ 843 taxa and 576 samples ]
ps.rowsum_biom.spe = ps.rowsum.gen_biom.spe.cmm


# select one sample per animal

listIDs_onPerAnimal = c("TieG003", "TieG024", "TieG017", "TieG022", "TieG008", "TieG023", "TieG002", "TieG004", "TieG012", "TieG009", "TieG019", "TieG031", "TieG032", "TieG020", "TieG021", "TieG025", "TieG016", "TieG066", "TieG054", "TieG052", "TieG065", "TieG062", "TieG063", "TieG064", "TieG051", "TieG038", "TieG037", "TieG041", "TieG039", "TieG040", "TieG061", "TieG140", "TieG147", "TieG067", "TieG143", "TieG149", "TieG076", "TieG075", "TieG078", "TieG124", "TieG121", "TieG122", "TieG125", "TieG101", "TieG102", "TieG128", "TieG126", "TieG105", "TiH017", "TiH023", "TiH025", "TiH010", "TiA033", "TiA018", "TiA045", "TiA038", "TiA029", "TiA016", "TiA034", "TiA044", "TiA021", "TiA013", "TiA024", "TiA031", "TiA032", "TiA026", "TiA025", "TiA039", "TiA030", "TiA022", "TiA040", "TiA006", "TiA035", "TiA007", "TiA015", "TiB002", "TiB022", "TieG119", "TiA046", "ZOL010", "ZOL011", "TieG034", "ZOL012", "Til017", "TiH001", "TiB037", "TieG013", "ZOL013", "TieG112", "TieG055", "TieG015", "TieG060", "ZOL002", "Til006", "TieG110", "ZOL003", "TieG097", "TieG096", "TiA010", "NecBac", "TieG070", "TieG085", "TieG086", "TieG082", "TieG077", "TieG050", "Til033", "TiA011", "Til004", "TieG104", "TieG106", "ZOL004", "Til038", "ZOL005", "TiB029", "Til031", "Til039", "Til025", "Til020", "TiA001", "TiB080", "TiA023", "TieG092", "TieG036", "Til014", "TiA003", "ZOL014", "TieG111", "TiB079", "TiB063", "TieG088", "TieG069", "TieG079", "TieG093", "TieG071", "TieG074", "TieG115", "TieG089", "TieG027", "Til009", "TiN011", "Til019", "Til016", "TieG053", "TiB052", "Til007", "Til022", "TiH019", "TieG095", "TieG099", "Til005", "TieG057", "TieG058", "TieG030", "TieG118", "Til013", "TiH012", "Til029", "TiA017", "Til018", "TieG109", "TieG098", "TieG107", "Til012", "ZOL006", "Til001", "TiA012", "TiB044", "TieG114", "TieG006", "TieG113", "TieG127", "Til032", "Til044", "Til011", "Til030", "Til034", "Til015", "TiA019", "TieG090", "ZOL007", "TiB075", "ZOL008St", "TiA008", "TieG035", "Til008", "TiN086", "TiN036", "TiN071", "TiN055", "TiN087", "TiN056", "TiN031", "TiN079", "TiN083", "TiN053", "TiN080", "TiN058", "TiN078", "TiN093", "TiN023", "TiN091", "TiN049", "TiN067", "TiN096", "TiN029", "TiN066", "TiN050", "TiN048", "TiN024", "TiN094", "TiN097", "TiN068", "TiN022", "TiN064", "TiN075", "TiN041", "TiN044", "TiN046", "TiN072", "TiN051", "TiN054", "TiN052", "TiN035", "TiN033", "TiN085", "TiN084", "TiN081", "TiN082", "TiN099", "TiN090", "TiN028", "TiN095", "TiN040", "TiN069", "TiN100", "TiN074", "TiN061", "TiN062", "TiN030", "TiN098", "TiN047", "TiN073", "TiN043", "TiN092", "TiN042", "TiN063", "TiN045", "TiN027", "TiN088", "TiN026", "TiN060", "TiN039", "TiN038", "TiN021", "TiN065", "TiN059", "TiN057", "TiN025", "TiN076", "TiN037", "TiN089", "TiB058", "TiB077", "TiB007", "TiB071", "TiB018", "TiB042", "TiB053", "TiB047", "TiB011", "TiB026", "TiB040", "TiB060", "TiB054", "TiB059", "TiB061", "TiB027", "TiB051", "TiB064", "TiB038", "TiB028", "TiB045", "TiB001", "TiB009", "TiB010", "TiB024", "TiB015", "TiB025", "TiB030", "TiB076", "TiB003", "TiB008", "TiB073", "TiB004", "TiB017", "TiB062", "TiB013", "TiB014", "TiB019", "TiB012", "TiH006", "Til040", "Til002", "Til027", "Til041", "TiH004", "TieG116", "Til010", "TiH007", "Til043", "TieG056", "Til026", "TieG026", "Til023", "TieG028", "TieG103", "TiH016", "TiB020", "Til036", "TiH008", "ZOL009", "TiA041", "TiA005", "TiA004", "TiN001", "TieG123", "Til035", "TieG029", "TieG080", "TiA009", "ZOL001", "TieG108", "Til024", "Til042", "Til021")
length(listIDs_onPerAnimal)
# add humans
listID_human = c("EMGE001", "EMGE002", "EMGE004", "EMGE005", "EMGE006", "EMGE007", "EMGE012", "EMGE015", "EMGE017", "EMGE020", "EMGE024", "EMGE027", "EMGE028", "EMGE041", "EMGE042", "EMGE045", "EMGE049", "EMGE050", "EMGE051", "EMGE056", "EMGE068", "EMGE072", "EMGE088", "EMGE094", "EMGE098", "EMGE103", "EMGE108", "EMGE110", "EMGE112", "EMGE121", "EMGE127", "EMGE129", "EMGE140", "EMGE143", "EMGE144", "EMGE145", "EMGE147", "EMGE149", "EMGE151", "EMGE154", "EMGE159", "EMGE160", "EMGE162", "EMGE165")
listID_human_Africa = c("H11690", "H11691", "H11710", "H11715", "H11717", "H11721", "H11733", "H11734", "H11735", "H11739", "H11740", "H11743", "H11744", "H11745", "H11750", "H11751", "H11752", "H11753", "H11754", "H11755", "H11760", "H11765", "H11766", "H11770", "H11771", "H11778", "H11802", "H11804", "H03479", "H03485", "H03491", "H03496", "H03509", "H03512", "H03513", "H03522", "H03525", "H03529", "H03542", "H03553", "H03555", "H03556", "H03558", "H03566", "H03580", "H03582", "H03587", "H03592", "H03599", "H03600", "H03601", "H03603", "H03606", "H03608", "H03611", "H03612", "H03617", "H03619", "H03626", "H03627", "H03631", "H03632", "H03640", "H03641", "H03642", "H03643", "H03658", "H03676", "H03691", "H03692", "H03694", "H03700", "H03701", "H03711", "H03719", "H03721", "H03723", "H03726", "H03729", "H03730", "H03731", "H03732", "H03734", "H03735", "H03736", "H03742", "H03743", "H03746", "H03747", "H03748", "H03752", "H03753", "H03758", "H03759", "H03760", "H03764", "H03790", "H03791", "H03798", "H03809", "H03810", "H03812", "H03824", "H03828", "H03840", "H03844", "H03845", "H03846", "H03848", "H03850", "H03859", "H08814", "H08816", "H08832", "H08840", "H08850", "H08860", "H08862", "H08864", "H08873", "H08876", "H08880", "H08882", "H08888", "H08892", "H08893", "H08904", "H08907", "H08910", "H08914", "H08915", "H08916", "H08917", "H08924", "H08929", "H08941", "H08947", "H08953", "H08955", "H08956", "H08961", "H08963", "H08965", "H08967", "H08971", "H08972", "H08978", "H08987", "H08996", "H08998", "H09187", "H09382", "H09384", "H09386", "H09387", "H09388", "H09394", "H09395", "H09396")
listIDs_onPerAnimal_and_human = c(listIDs_onPerAnimal, listID_human, listID_human_Africa)


ps.rowsum.uniqAnimal_biom.spe = subset_samples(ps.rowsum_biom.spe, Verschickungscode %in% listIDs_onPerAnimal_and_human)
ps.rowsum.uniqAnimal_biom.spe
# otu_table()   OTU Table:         [ 843 taxa and 527 samples ]

## MAKE VARIABLE OF DIET PREFERENCES
# How to call :
ps = ps.rowsum.uniqAnimal_biom.spe
source(file.path(path_scripts, '1_data_add.pheno.variables.R'))
ps.rowsum.uniqAnimal_biom.spe = ps
head(sample_data(ps.rowsum.uniqAnimal_biom.spe))


# ORDER ANIMAL LEVEL
# we select the groups with 5 or more samples in for plotting and further analysis

# ORDER
table(sample_data(ps.rowsum.uniqAnimal_biom.spe)$Order)
ps.rowsum.uniqAnimal_biom.spe.ord = subset_samples(ps.rowsum.uniqAnimal_biom.spe, Order == 'Artiodactyla' |
                                                     Order == 'Carnivora' |
                                                     #Order == 'Diprotodontia' |
                                                     Order == 'Perissodactyla' |
                                                     Order == 'Primates')
ps.rowsum.uniqAnimal_biom.spe.ord
table(sample_data(ps.rowsum.uniqAnimal_biom.spe.ord)$Order)

# FAMILY
table(sample_data(ps.rowsum.uniqAnimal_biom.spe)$Family)

table(sample_data(ps.rowsum.uniqAnimal_biom.spe)$Family)[
  table(sample_data(ps.rowsum.uniqAnimal_biom.spe)$Family) > 4 ]

ps.rowsum.uniqAnimal_biom.spe.fam = subset_samples(ps.rowsum.uniqAnimal_biom.spe, 
                                                     Family == 'Hominidae' )


ps.rowsum.uniqAnimal_biom.spe.fam
table(sample_data(ps.rowsum.uniqAnimal_biom.spe.fam)$Family)

# GENUS
(table(sample_data(ps.rowsum.uniqAnimal_biom.spe.fam)$Genus))

ps.rowsum.uniqAnimal_biom.spe.gen = ps.rowsum.uniqAnimal_biom.spe.fam

# SPECIES
head(sample_data(ps.rowsum.uniqAnimal_biom.spe.fam))
(table(sample_data(ps.rowsum.uniqAnimal_biom.spe.fam)$Species..latein.))

ps.rowsum.uniqAnimal_biom.spe.spe = subset_samples(ps.rowsum.uniqAnimal_biom.spe, Species..latein. == 'Homo sapiens' |
                                                     Species..latein. == 'Pan troglodytes' |
                                                     #Species..latein. == 'Pan troglodytes verus' |
                                                     Species..latein. == 'Pongo abelii' )








