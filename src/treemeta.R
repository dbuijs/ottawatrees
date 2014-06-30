#Tree types

speciestable <- sort(table(alltrees@data$SPECIES), decreasing = TRUE)

maples <- grep("Maple|Acer", levels(alltrees@data$SPECIES), value = TRUE)
ashes <- grep("^Ash", levels(alltrees@data$SPECIES), value = TRUE)
evergreens <- grep("Pine|Spruce|Cedar|Fir|Pinus|Hemlock|Thuja|Picea", levels(alltrees@data$SPECIES), value = TRUE)
lilacs <- grep("Lilac", levels(alltrees@data$SPECIES), value = TRUE)
oaks <- grep("^Oak", levels(alltrees@data$SPECIES), value = TRUE)
elms <- grep("Elm", levels(alltrees@data$SPECIES), value = TRUE)
other <- grep("Various|Unknown|Other|See notes", levels(alltrees@data$SPECIES), ignore.case = TRUE, value = TRUE)
birch <- grep("birch", levels(alltrees@data$SPECIES), ignore.case = TRUE, value = TRUE)
willow <- grep("willow", levels(alltrees@data$SPECIES), ignore.case = TRUE, value = TRUE)
aspen <- grep("aspen", levels(alltrees@data$SPECIES), ignore.case = TRUE, value = TRUE)
poplar <- grep("poplar", levels(alltrees@data$SPECIES), ignore.case = TRUE, value = TRUE)

acer <- grep("acer", levels(alltrees@data$SPECIES), ignore.case = TRUE, value = TRUE)


ediblesearch <- c('Apple Species', 
                  'Cherry Choke', 
                  'Crabapple Species', 
                  'Hackberry',
                  'Amelanchier species',
                  'Cherry Black',
                  'Cherry Pin',
                  'Cranberry High Bush',
                  'Elderberry Species',
                  'Malus apple Species',
                  'Malus crabapple Species',
                  'Mulberry Species',
                  'Olive Russian',
                  'Pear Species',
                  'Butternut', 
                  'Coffeetree Kentucky',
                  'Ginkgo',
                  'Hazel Turkish',
                  'Hickory Shagbark',
                  'Walnut Black',
                  'Hazel American',
                  'Juglans cinerea',
                  'Serviceberry',
                  'Plum',
                  'Prunus virginiana',
                  'Cherry species')
ediblesearch2 <- paste(ediblesearch, collapse = "|")
edible <- grep(ediblesearch2, levels(alltrees@data$SPECIES), ignore.case = TRUE, value = TRUE)

treetypes <- data.frame(species = names(speciestable), treetype = names(speciestable), ntrees = speciestable, row.names = NULL)
treetypes[treetypes$species %in% maples, "treetype"] <- "Maple"
treetypes[treetypes$species %in% ashes, "treetype"] <- "Ash"
treetypes[treetypes$species %in% evergreens, "treetype"] <- "Evergreen"
treetypes[treetypes$species %in% lilacs, "treetype"] <- "Lilac"
treetypes[treetypes$species %in% oaks, "treetype"] <- "Oak"
treetypes[treetypes$species %in% elms, "treetype"] <- "Elm"
treetypes[treetypes$species %in% other, "treetype"] <- "Other"
treetypes[treetypes$species %in% edible, "treetype"] <- "Foodbearing"
treetypes[treetypes$species %in% birch, "treetype"] <- "Birch"
treetypes[treetypes$species %in% willow, "treetype"] <- "Willow"
treetypes[treetypes$species %in% aspen, "treetype"] <- "Aspen"
treetypes[treetypes$species %in% poplar, "treetype"] <- "Poplar"

rm(speciestable, maples, ashes, evergreens, lilacs, oaks, elms, other, edible, birch, willow, aspen, poplar)
cache('treetypes')
