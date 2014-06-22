#Tree types

maples <- grep("Maple", levels(alltrees@data$SPECIES), value = TRUE)
ashes <- grep("^Ash", levels(alltrees@data$SPECIES), value = TRUE)
evergreens <- grep("Pine|Spruce|Cedar|Fir|Pinus|Hemlock|Thuja", levels(alltrees@data$SPECIES), value = TRUE)
lilacs <- grep("Lilac", levels(alltrees@data$SPECIES), value = TRUE)
apples <- grep("apple", levels(alltrees@data$SPECIES), value = TRUE, ignore.case = TRUE)
oaks <- grep("^Oak", levels(alltrees@data$SPECIES), value = TRUE)
foodtrees <- c("Apple", "Pear", "Serviceberry", "Black walnut", "cherry", "crabapple", "ginkgo", "grape", "hazel")

htree$treetype <- "Other"
htree[mtree$SPECIES %in% maples, "treetype"] <- "Maple"
htree[mtree$SPECIES %in% ashes, "treetype"] <- "Ash"
htree[mtree$SPECIES %in% evergreens, "treetype"] <- "Evergreen"
htree[mtree$SPECIES %in% lilacs, "treetype"] <- "Lilac"
htree[mtree$SPECIES %in% apples, "treetype"] <- "Apple"
htree[mtree$SPECIES %in% oaks, "treetype"] <- "Oak"
htree[mtree$SPECIES == "Locust Honey" , "treetype"] <- "Honey Locust"
htree[mtree$SPECIES == "Linden Littleleaf", "treetype"] <- "Linden"
htree[mtree$SPECIES == "Hackberry" , "treetype"] <- "Hackberry"


'Apple Species' 
  'Cherry Choke' 
  'Crabapple Species' 
  'Hackberry'
    'Amelanchier species',
    'Cherry Black',
    'Cherry Pin',
    'Cranberry High Bush',
    'Elderberry Species',
    'Malus apple Species',
    'Malus crabapple Species',
    'Mulberry Species',
    'Olive Russian',
    'Pear Species'
'Butternut' 
  'Coffeetree Kentucky'
  'Ginkgo'
  'Hazel Turkish'
  'Hickory Shagbark'
  'Walnut Black'
    'Hazel American',
    'Juglans cinerea'