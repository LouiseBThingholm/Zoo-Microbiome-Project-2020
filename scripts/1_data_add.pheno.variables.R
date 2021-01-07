

# name of phyloObject that will be added variables to : metadata object 

# How to call :
# ps = ps.count.uniqAnimal
# source(file.path(project_path '/scripts/1_data_add.pheno.variables.R') )
# ps.count.uniqAnimal = ps
# head(sample_data(ps.count.uniqAnimal))


# ## MAKE VARIABLE OF DIET PREFERENCES

# information is maninly taken from 
# https://animaldiversity.org/search/?q=Pan+troglodytes&feature=INFORMATION

metadata = sample_data(ps)


names(table( as.character(metadata$Species..englisch. )))
Species.englisch = as.factor(metadata$Species..englisch. )
Diet_Orientation = as.character(Species.englisch)
Digestion_RuminantsNonRuminants = as.character(Species.englisch) #  
Fermentation_ForegutHindgut = as.character(Species.englisch) #
Behavior = as.character(Species.englisch) #

n=1 # "Bactrian camel"
engish.name=names(table( as.character(metadata$Species..englisch. )))[n]; engish.name
as.character( metadata$Species..latein.[as.character(metadata$Species..englisch. ) == names(table( as.character(metadata$Species..englisch. )))[n]])[1]
engish.name="Bactrian camel"
Diet_Orientation[Diet_Orientation == engish.name] = 'Herbivores' # Primary Diet: herbivore, frugivore, omnivore
Digestion_RuminantsNonRuminants[Digestion_RuminantsNonRuminants == engish.name] = 'Ruminants'
Fermentation_ForegutHindgut[Fermentation_ForegutHindgut == engish.name] = 'Foregut'
Behavior[Behavior == engish.name] = 'Social' # 
n=2 # Barbary macaque
engish.name=names(table( as.character(metadata$Species..englisch. )))[n]; engish.name
as.character( metadata$Species..latein.[as.character(metadata$Species..englisch. ) == names(table( as.character(metadata$Species..englisch. )))[n]])[1]
engish.name="Barbary macaque"
Diet_Orientation[Diet_Orientation == engish.name] = 'Omnivore' # Primary Diet: herbivore, frugivore, omnivore
Digestion_RuminantsNonRuminants[Digestion_RuminantsNonRuminants == engish.name] = 'NonRuminants'
Fermentation_ForegutHindgut[Fermentation_ForegutHindgut == engish.name] = 'None'
Behavior[Behavior == engish.name] = 'Social' #
n=3 # Black bear
engish.name=names(table( as.character(metadata$Species..englisch. )))[n]; engish.name
as.character( metadata$Species..latein.[as.character(metadata$Species..englisch. ) == names(table( as.character(metadata$Species..englisch. )))[n]])[1]
engish.name="Black bear"
Diet_Orientation[Diet_Orientation == engish.name] = 'Omnivore' # 
Digestion_RuminantsNonRuminants[Digestion_RuminantsNonRuminants == engish.name] = 'NonRuminants'
Fermentation_ForegutHindgut[Fermentation_ForegutHindgut == engish.name] = 'None'
Behavior[Behavior == engish.name] = 'Solitary' # 
n=4 # Black crested mangabey
engish.name=names(table( as.character(metadata$Species..englisch. )))[n]; engish.name
as.character( metadata$Species..latein.[as.character(metadata$Species..englisch. ) == names(table( as.character(metadata$Species..englisch. )))[n]])[1]
engish.name="Black crested mangabey"
Diet_Orientation[Diet_Orientation == engish.name] = 'Omnivore' # 
Digestion_RuminantsNonRuminants[Digestion_RuminantsNonRuminants == engish.name] = 'NonRuminants'
Fermentation_ForegutHindgut[Fermentation_ForegutHindgut == engish.name] = 'None'
Behavior[Behavior == engish.name] = 'Social' # 
n=5 # Bonobo
engish.name=names(table( as.character(metadata$Species..englisch. )))[n]; engish.name
as.character( metadata$Species..latein.[as.character(metadata$Species..englisch. ) == names(table( as.character(metadata$Species..englisch. )))[n]])[1]
engish.name="Bonobo"
Diet_Orientation[Diet_Orientation == engish.name] = 'Omnivore' # 
Digestion_RuminantsNonRuminants[Digestion_RuminantsNonRuminants == engish.name] = 'NonRuminants'
Fermentation_ForegutHindgut[Fermentation_ForegutHindgut == engish.name] = 'None'
Behavior[Behavior == engish.name] = 'Social' # 
n=6 # Celebes crested macaque
engish.name=names(table( as.character(metadata$Species..englisch. )))[n]; engish.name
as.character( metadata$Species..latein.[as.character(metadata$Species..englisch. ) == names(table( as.character(metadata$Species..englisch. )))[n]])[1]
engish.name="Celebes crested macaque"
Diet_Orientation[Diet_Orientation == engish.name] = 'Omnivore' # Primary Diet: herbivore, frugivore, omnivore
Digestion_RuminantsNonRuminants[Digestion_RuminantsNonRuminants == engish.name] = 'NonRuminants'
Fermentation_ForegutHindgut[Fermentation_ForegutHindgut == engish.name] = 'None'
Behavior[Behavior == engish.name] = 'Social' # 
n=7 # Chimp
engish.name=names(table( as.character(metadata$Species..englisch. )))[n]; engish.name
as.character( metadata$Species..latein.[as.character(metadata$Species..englisch. ) == names(table( as.character(metadata$Species..englisch. )))[n]])[1]
engish.name="Chimp"
Diet_Orientation[Diet_Orientation == engish.name] = 'Omnivore' # Primary Diet: herbivore, frugivore, omnivore
Digestion_RuminantsNonRuminants[Digestion_RuminantsNonRuminants == engish.name] = 'NonRuminants'
Fermentation_ForegutHindgut[Fermentation_ForegutHindgut == engish.name] = 'None'
Behavior[Behavior == engish.name] = 'Social' # 
n=8 # Common eland
engish.name=names(table( as.character(metadata$Species..englisch. )))[n]; engish.name
as.character( metadata$Species..latein.[as.character(metadata$Species..englisch. ) == names(table( as.character(metadata$Species..englisch. )))[n]])[1]
engish.name="Common eland"
Diet_Orientation[Diet_Orientation == engish.name] = 'Herbivores' # Primary Diet: herbivore, frugivore, omnivore
Digestion_RuminantsNonRuminants[Digestion_RuminantsNonRuminants == engish.name] = 'NonRuminants'
Fermentation_ForegutHindgut[Fermentation_ForegutHindgut == engish.name] = 'None'
Behavior[Behavior == engish.name] = 'Solitary' # 
n=9 # Cotton-top tamarin
engish.name=names(table( as.character(metadata$Species..englisch. )))[n]; engish.name
as.character( metadata$Species..latein.[as.character(metadata$Species..englisch. ) == names(table( as.character(metadata$Species..englisch. )))[n]])[1]
engish.name="Cotton-top tamarin"
Diet_Orientation[Diet_Orientation == engish.name] = 'Omnivore' # Primary Diet: herbivore, frugivore, omnivore
Digestion_RuminantsNonRuminants[Digestion_RuminantsNonRuminants == engish.name] = 'NonRuminants'
Fermentation_ForegutHindgut[Fermentation_ForegutHindgut == engish.name] = 'None'
Behavior[Behavior == engish.name] = 'Social' # 
n=10 # Diana monkey
engish.name=names(table( as.character(metadata$Species..englisch. )))[n]; engish.name
as.character( metadata$Species..latein.[as.character(metadata$Species..englisch. ) == names(table( as.character(metadata$Species..englisch. )))[n]])[1]
engish.name="Diana monkey"
Diet_Orientation[Diet_Orientation == engish.name] = 'Omnivore' # Primary Diet: herbivore, frugivore, omnivore
Digestion_RuminantsNonRuminants[Digestion_RuminantsNonRuminants == engish.name] = 'NonRuminants'
Fermentation_ForegutHindgut[Fermentation_ForegutHindgut == engish.name] = 'None'
Behavior[Behavior == engish.name] = 'Social' # Diana monkeys are social, living in groups of 15 to 30 individuals 
n=11 # Domestic Cattle
engish.name=names(table( as.character(metadata$Species..englisch. )))[n]; engish.name
as.character( metadata$Species..latein.[as.character(metadata$Species..englisch. ) == names(table( as.character(metadata$Species..englisch. )))[n]])[1]
engish.name="Domestic Cattle"
Diet_Orientation[Diet_Orientation == engish.name] = 'Herbivores' # Primary Diet: herbivore, frugivore, omnivore
Digestion_RuminantsNonRuminants[Digestion_RuminantsNonRuminants == engish.name] = 'Ruminants'
Fermentation_ForegutHindgut[Fermentation_ForegutHindgut == engish.name] = 'Foregut'
Behavior[Behavior == engish.name] = 'Social' # 
n=12 # "Domestic sheep"
engish.name=names(table( as.character(metadata$Species..englisch. )))[n]; engish.name
as.character( metadata$Species..latein.[as.character(metadata$Species..englisch. ) == names(table( as.character(metadata$Species..englisch. )))[n]])[1]
engish.name="Domestic sheep"
Diet_Orientation[Diet_Orientation == engish.name] = 'Herbivores' # Primary Diet: herbivore, frugivore, omnivore
Digestion_RuminantsNonRuminants[Digestion_RuminantsNonRuminants == engish.name] = 'Ruminants'
Fermentation_ForegutHindgut[Fermentation_ForegutHindgut == engish.name] = 'Foregut'
Behavior[Behavior == engish.name] = 'Social' # 
n=13 # "Donkey"
engish.name=names(table( as.character(metadata$Species..englisch. )))[n]; engish.name
as.character( metadata$Species..latein.[as.character(metadata$Species..englisch. ) == names(table( as.character(metadata$Species..englisch. )))[n]])[1]
engish.name="Donkey"
Diet_Orientation[Diet_Orientation == engish.name] = 'Herbivores' # Primary Diet: herbivore, frugivore, omnivore
Digestion_RuminantsNonRuminants[Digestion_RuminantsNonRuminants == engish.name] = 'Ruminants'
Fermentation_ForegutHindgut[Fermentation_ForegutHindgut == engish.name] = 'Hindgut'
Behavior[Behavior == engish.name] = 'Social' # 
n=14 # Drill
engish.name=names(table( as.character(metadata$Species..englisch. )))[n]; engish.name
as.character( metadata$Species..latein.[as.character(metadata$Species..englisch. ) == names(table( as.character(metadata$Species..englisch. )))[n]])[1]
engish.name="Drill"
Diet_Orientation[Diet_Orientation == engish.name] = 'Omnivore' # Primary Diet: herbivore, frugivore, omnivore
Digestion_RuminantsNonRuminants[Digestion_RuminantsNonRuminants == engish.name] = 'NonRuminants'
Fermentation_ForegutHindgut[Fermentation_ForegutHindgut == engish.name] = 'None'
Behavior[Behavior == engish.name] = 'Social' # 
n=15 # "Elk"
engish.name=names(table( as.character(metadata$Species..englisch. )))[n]; engish.name
as.character( metadata$Species..latein.[as.character(metadata$Species..englisch. ) == names(table( as.character(metadata$Species..englisch. )))[n]])[1]
engish.name="Elk"
Diet_Orientation[Diet_Orientation == engish.name] = 'Herbivores' # Primary Diet: herbivore, frugivore, omnivore
Digestion_RuminantsNonRuminants[Digestion_RuminantsNonRuminants == engish.name] = 'Ruminants'
Fermentation_ForegutHindgut[Fermentation_ForegutHindgut == engish.name] = 'NA'
Behavior[Behavior == engish.name] = 'Solitary' # 
n=16 # "Saguinus imperator"
engish.name=names(table( as.character(metadata$Species..englisch. )))[n]; engish.name
as.character( metadata$Species..latein.[as.character(metadata$Species..englisch. ) == names(table( as.character(metadata$Species..englisch. )))[n]])[1]
engish.name="Emperor tamarin"
Diet_Orientation[Diet_Orientation == engish.name] = 'Omnivore' # Primary Diet: herbivore, frugivore, omnivore
Digestion_RuminantsNonRuminants[Digestion_RuminantsNonRuminants == engish.name] = 'NonRuminants'
Fermentation_ForegutHindgut[Fermentation_ForegutHindgut == engish.name] = 'NA'
Behavior[Behavior == engish.name] = 'Social' # 
n=17 # Goat
engish.name=names(table( as.character(metadata$Species..englisch. )))[n]; engish.name
as.character( metadata$Species..latein.[as.character(metadata$Species..englisch. ) == names(table( as.character(metadata$Species..englisch. )))[n]])[1]
engish.name="Goat"
Diet_Orientation[Diet_Orientation == engish.name] = 'Herbivores' # Primary Diet: herbivore, frugivore, omnivore
Digestion_RuminantsNonRuminants[Digestion_RuminantsNonRuminants == engish.name] = 'Ruminants'
Fermentation_ForegutHindgut[Fermentation_ForegutHindgut == engish.name] = 'NA'
Behavior[Behavior == engish.name] = 'Social' # 
n=18 # Hamadryas baboon
engish.name=names(table( as.character(metadata$Species..englisch. )))[n]; engish.name
as.character( metadata$Species..latein.[as.character(metadata$Species..englisch. ) == names(table( as.character(metadata$Species..englisch. )))[n]])[1]
engish.name="Hamadryas baboon"
Diet_Orientation[Diet_Orientation == engish.name] = 'Omnivore' # Primary Diet: herbivore, frugivore, omnivore
Digestion_RuminantsNonRuminants[Digestion_RuminantsNonRuminants == engish.name] = 'NonRuminants'
Fermentation_ForegutHindgut[Fermentation_ForegutHindgut == engish.name] = 'None'
Behavior[Behavior == engish.name] = 'Social' # 
n=19 # Horse
engish.name=names(table( as.character(metadata$Species..englisch. )))[n]; engish.name
as.character( metadata$Species..latein.[as.character(metadata$Species..englisch. ) == names(table( as.character(metadata$Species..englisch. )))[n]])[1]
engish.name="Horse"
Diet_Orientation[Diet_Orientation == engish.name] = 'Herbivores' # Primary Diet: herbivore, frugivore, omnivore
Digestion_RuminantsNonRuminants[Digestion_RuminantsNonRuminants == engish.name] = 'Ruminants'
Fermentation_ForegutHindgut[Fermentation_ForegutHindgut == engish.name] = 'Hindgut'
Behavior[Behavior == engish.name] = 'Social' # 
n=20 # Human
engish.name=names(table( as.character(metadata$Species..englisch. )))[n]; engish.name
as.character( metadata$Species..latein.[as.character(metadata$Species..englisch. ) == names(table( as.character(metadata$Species..englisch. )))[n]])[1]
engish.name="Human"
Diet_Orientation[Diet_Orientation == engish.name] = 'Omnivore' # Primary Diet: herbivore, frugivore, omnivore
Digestion_RuminantsNonRuminants[Digestion_RuminantsNonRuminants == engish.name] = 'NonRuminants'
Fermentation_ForegutHindgut[Fermentation_ForegutHindgut == engish.name] = 'None'
Behavior[Behavior == engish.name] = 'Social' # 
n=21 # Mandrill
engish.name=names(table( as.character(metadata$Species..englisch. )))[n]; engish.name
as.character( metadata$Species..latein.[as.character(metadata$Species..englisch. ) == names(table( as.character(metadata$Species..englisch. )))[n]])[1]
engish.name="Mandrill"
Diet_Orientation[Diet_Orientation == engish.name] = 'Omnivore' # 
Digestion_RuminantsNonRuminants[Digestion_RuminantsNonRuminants == engish.name] = 'NonRuminants'
Fermentation_ForegutHindgut[Fermentation_ForegutHindgut == engish.name] = 'None'
Behavior[Behavior == engish.name] = 'Social' # 
n=22 # Meerkat
engish.name=names(table( as.character(metadata$Species..englisch. )))[n]; engish.name
as.character( metadata$Species..latein.[as.character(metadata$Species..englisch. ) == names(table( as.character(metadata$Species..englisch. )))[n]])[1]
engish.name="Meerkat"
Diet_Orientation[Diet_Orientation == engish.name] = 'Carnivore' # carnivore, insectivore
Digestion_RuminantsNonRuminants[Digestion_RuminantsNonRuminants == engish.name] = 'NonRuminants'
Fermentation_ForegutHindgut[Fermentation_ForegutHindgut == engish.name] = 'None'
Behavior[Behavior == engish.name] = 'Social' # 
n=23 # "Plains zebra"
engish.name=names(table( as.character(metadata$Species..englisch. )))[n]; engish.name
as.character( metadata$Species..latein.[as.character(metadata$Species..englisch. ) == names(table( as.character(metadata$Species..englisch. )))[n]])[1]
engish.name="Plains zebra"
Diet_Orientation[Diet_Orientation == engish.name] = 'Herbivores' # carnivore, insectivore
Digestion_RuminantsNonRuminants[Digestion_RuminantsNonRuminants == engish.name] = 'NonRuminants'
Fermentation_ForegutHindgut[Fermentation_ForegutHindgut == engish.name] = 'None'
Behavior[Behavior == engish.name] = 'Social' # 

n=24 # Polar bear
engish.name=names(table( as.character(metadata$Species..englisch. )))[n]; engish.name
as.character( metadata$Species..latein.[as.character(metadata$Species..englisch. ) == names(table( as.character(metadata$Species..englisch. )))[n]])[1]
engish.name="Polar bear"
Diet_Orientation[Diet_Orientation == engish.name] = 'Carnivore' # Polar bears are carnivores. In the summer, they may consume some vegetation but gain little nutrition from it.
Digestion_RuminantsNonRuminants[Digestion_RuminantsNonRuminants == engish.name] = 'NonRuminants'
Fermentation_ForegutHindgut[Fermentation_ForegutHindgut == engish.name] = 'None'
Behavior[Behavior == engish.name] = 'Solitary' # Solitary, Social
n=25 # Racoon
engish.name=names(table( as.character(metadata$Species..englisch. )))[n]; engish.name
as.character( metadata$Species..latein.[as.character(metadata$Species..englisch. ) == names(table( as.character(metadata$Species..englisch. )))[n]])[1]
engish.name="Racoon"
Diet_Orientation[Diet_Orientation == engish.name] = 'Omnivore' # Polar bears are carnivores. In the summer, they may consume some vegetation but gain little nutrition from it.
Digestion_RuminantsNonRuminants[Digestion_RuminantsNonRuminants == engish.name] = 'NonRuminants'
Fermentation_ForegutHindgut[Fermentation_ForegutHindgut == engish.name] = 'None'
Behavior[Behavior == engish.name] = 'Solitary' # Solitary, Social
n=26 # Red ruffed lemur
engish.name=names(table( as.character(metadata$Species..englisch. )))[n]; engish.name
as.character( metadata$Species..latein.[as.character(metadata$Species..englisch. ) == names(table( as.character(metadata$Species..englisch. )))[n]])[1]
engish.name="Red ruffed lemur"
Diet_Orientation[Diet_Orientation == engish.name] = 'Herbivores' # Polar bears are carnivores. In the summer, they may consume some vegetation but gain little nutrition from it.
Digestion_RuminantsNonRuminants[Digestion_RuminantsNonRuminants == engish.name] = 'NonRuminants'
Fermentation_ForegutHindgut[Fermentation_ForegutHindgut == engish.name] = 'None'
Behavior[Behavior == engish.name] = 'Social' # Solitary, Social

n=27 # Red-handed tamarin
engish.name=names(table( as.character(metadata$Species..englisch. )))[n]; engish.name
as.character( metadata$Species..latein.[as.character(metadata$Species..englisch. ) == names(table( as.character(metadata$Species..englisch. )))[n]])[1]
engish.name="Red-handed tamarin"
Diet_Orientation[Diet_Orientation == engish.name] = 'Omnivore' # Polar bears are carnivores. In the summer, they may consume some vegetation but gain little nutrition from it.
Digestion_RuminantsNonRuminants[Digestion_RuminantsNonRuminants == engish.name] = 'NonRuminants'
Fermentation_ForegutHindgut[Fermentation_ForegutHindgut == engish.name] = 'None'
Behavior[Behavior == engish.name] = 'Social' # Solitary, Social

n=28 # Rangifer tarandus
engish.name=names(table( as.character(metadata$Species..englisch. )))[n]; engish.name
as.character( metadata$Species..latein.[as.character(metadata$Species..englisch. ) == names(table( as.character(metadata$Species..englisch. )))[n]])[1]
engish.name="Reindeer"
Diet_Orientation[Diet_Orientation == engish.name] = 'Herbivores' #
Digestion_RuminantsNonRuminants[Digestion_RuminantsNonRuminants == engish.name] = 'Ruminants'
Fermentation_ForegutHindgut[Fermentation_ForegutHindgut == engish.name] = 'NA'
Behavior[Behavior == engish.name] = 'Social' # Solitary, Social
n=29 # Ring-tailed coati
engish.name=names(table( as.character(metadata$Species..englisch. )))[n]; engish.name
as.character( metadata$Species..latein.[as.character(metadata$Species..englisch. ) == names(table( as.character(metadata$Species..englisch. )))[n]])[1]
engish.name="Ring-tailed coati"
Diet_Orientation[Diet_Orientation == engish.name] = 'Omnivore' #
Digestion_RuminantsNonRuminants[Digestion_RuminantsNonRuminants == engish.name] = 'NonRuminants'
Fermentation_ForegutHindgut[Fermentation_ForegutHindgut == engish.name] = 'None'
Behavior[Behavior == engish.name] = 'Social' # Solitary, Social
n=30 # Ring-tailed lemur
engish.name=names(table( as.character(metadata$Species..englisch. )))[n]; engish.name
as.character( metadata$Species..latein.[as.character(metadata$Species..englisch. ) == names(table( as.character(metadata$Species..englisch. )))[n]])[1]
engish.name="Ring-tailed lemur"
Diet_Orientation[Diet_Orientation == engish.name] = 'Omnivore' #
Digestion_RuminantsNonRuminants[Digestion_RuminantsNonRuminants == engish.name] = 'NonRuminants'
Fermentation_ForegutHindgut[Fermentation_ForegutHindgut == engish.name] = 'None'
Behavior[Behavior == engish.name] = 'Social' # Solitary, Social
n=31 # Squirrel monkey
engish.name=names(table( as.character(metadata$Species..englisch. )))[n]; engish.name
as.character( metadata$Species..latein.[as.character(metadata$Species..englisch. ) == names(table( as.character(metadata$Species..englisch. )))[n]])[1]
engish.name="Squirrel monkey"
Diet_Orientation[Diet_Orientation == engish.name] = 'Omnivore' # Omnivore based on text where it is said to spend much time searching for insects etc
Digestion_RuminantsNonRuminants[Digestion_RuminantsNonRuminants == engish.name] = 'NonRuminants'
Fermentation_ForegutHindgut[Fermentation_ForegutHindgut == engish.name] = 'None'
Behavior[Behavior == engish.name] = 'Social' # Solitary, Social
n=32 # Pongo
engish.name=names(table( as.character(metadata$Species..englisch. )))[n]; engish.name
as.character( metadata$Species..latein.[as.character(metadata$Species..englisch. ) == names(table( as.character(metadata$Species..englisch. )))[n]])[1]
engish.name="Sumatran orangutan"
Diet_Orientation[Diet_Orientation == engish.name] = 'Omnivore' # animaldiversity.org says herbivours – but also write ’ insects, mainly ants, termites, and crickets (~5%),’
Digestion_RuminantsNonRuminants[Digestion_RuminantsNonRuminants == engish.name] = 'NonRuminants'
Fermentation_ForegutHindgut[Fermentation_ForegutHindgut == engish.name] = 'None'
Behavior[Behavior == engish.name] = 'Solitary' # Solitary, Social


n=33 # Tapir
engish.name=names(table( as.character(metadata$Species..englisch. )))[n]; engish.name
as.character( metadata$Species..latein.[as.character(metadata$Species..englisch. ) == names(table( as.character(metadata$Species..englisch. )))[n]])[1]
engish.name="Tapir"
Diet_Orientation[Diet_Orientation == engish.name] = 'Herbivores' #
Digestion_RuminantsNonRuminants[Digestion_RuminantsNonRuminants == engish.name] = 'NonRuminants'
Fermentation_ForegutHindgut[Fermentation_ForegutHindgut == engish.name] = 'None'
Behavior[Behavior == engish.name] = 'Solitary' # Solitary, Social
n=34 # Vicuna
engish.name=names(table( as.character(metadata$Species..englisch. )))[n]; engish.name
as.character( metadata$Species..latein.[as.character(metadata$Species..englisch. ) == names(table( as.character(metadata$Species..englisch. )))[n]])[1]
engish.name="Vicuna"
Diet_Orientation[Diet_Orientation == engish.name] = 'Herbivores' #
Digestion_RuminantsNonRuminants[Digestion_RuminantsNonRuminants == engish.name] = 'NonRuminants'
Fermentation_ForegutHindgut[Fermentation_ForegutHindgut == engish.name] = 'None'
Behavior[Behavior == engish.name] = 'Social' # Solitary, Social
n=35 # White-handed gibbon
engish.name=names(table( as.character(metadata$Species..englisch. )))[n]; engish.name
as.character( metadata$Species..latein.[as.character(metadata$Species..englisch. ) == names(table( as.character(metadata$Species..englisch. )))[n]])[1]
engish.name="White-handed gibbon"
Diet_Orientation[Diet_Orientation == engish.name] = 'Omnivore' #
Digestion_RuminantsNonRuminants[Digestion_RuminantsNonRuminants == engish.name] = 'NonRuminants'
Fermentation_ForegutHindgut[Fermentation_ForegutHindgut == engish.name] = 'NA'
Behavior[Behavior == engish.name] = 'Social' # Solitary, Social
n=36 # White-lipped tamarin
engish.name=names(table( as.character(metadata$Species..englisch. )))[n]; engish.name
as.character( metadata$Species..latein.[as.character(metadata$Species..englisch. ) == names(table( as.character(metadata$Species..englisch. )))[n]])[1]
engish.name="White-lipped tamarin"
Diet_Orientation[Diet_Orientation == engish.name] = 'Omnivore' #
Digestion_RuminantsNonRuminants[Digestion_RuminantsNonRuminants == engish.name] = 'NonRuminants'
Fermentation_ForegutHindgut[Fermentation_ForegutHindgut == engish.name] = 'None'
Behavior[Behavior == engish.name] = 'Social' # Solitary, Social
n=37 # White-tufted-ear marmoset
engish.name=names(table( as.character(metadata$Species..englisch. )))[n]; engish.name
as.character( metadata$Species..latein.[as.character(metadata$Species..englisch. ) == names(table( as.character(metadata$Species..englisch. )))[n]])[1]
engish.name="White-tufted-ear marmoset"
Diet_Orientation[Diet_Orientation == engish.name] = 'Omnivore' #
Digestion_RuminantsNonRuminants[Digestion_RuminantsNonRuminants == engish.name] = 'NonRuminants'
Fermentation_ForegutHindgut[Fermentation_ForegutHindgut == engish.name] = 'None'
Behavior[Behavior == engish.name] = 'Social' # Solitary, Social
n=38 # Wild boar
engish.name=names(table( as.character(metadata$Species..englisch. )))[n]; engish.name
as.character( metadata$Species..latein.[as.character(metadata$Species..englisch. ) == names(table( as.character(metadata$Species..englisch. )))[n]])[1]
engish.name="Wild boar"
Diet_Orientation[Diet_Orientation == engish.name] = 'Omnivore' #
Digestion_RuminantsNonRuminants[Digestion_RuminantsNonRuminants == engish.name] = 'NonRuminants'
Fermentation_ForegutHindgut[Fermentation_ForegutHindgut == engish.name] = 'None'
Behavior[Behavior == engish.name] = 'Social' # Solitary, Social


table(Diet_Orientation)
table(Digestion_RuminantsNonRuminants)
table(Fermentation_ForegutHindgut) # needs more googeling
table(Behavior)


table(Diet_Orientation, Digestion_RuminantsNonRuminants)
table(Diet_Orientation, sample_data(ps)$Order )
# Diet_Orientation Artiodactyla Carnivora Diprotodontia Perissodactyla Primates
# Carnivore             0         6             0              0        0
# Herbivores           43         0             6             30       11
# Omnivore             14        46             0              0      218

sample_data(ps)$Diet_Orientation = Diet_Orientation
sample_data(ps)$Digestion_RuminantsNonRuminants = Digestion_RuminantsNonRuminants
sample_data(ps)$Behavior = Behavior

# checking assignments:
res=data.frame('Species..englisch' = sample_data(ps)$Species..englisch., 'Diet_Orientation' = sample_data(ps)$Diet_Orientation, 'Order'=sample_data(ps)$Order )

as.character(unique(res$Species..englisch))
res[ match(unique(res$Species..englisch), res$Species..englisch),]



