#May 24, 2014
#Daniel Buijs (dbuijs@gmail.com)
#CC BY-NC 2.5 CA (http://creativecommons.org/licenses/by-nc/2.5/ca/)
#Run-once to grab the data and convert

library(rgal, XML, R.utils, data.table)
#Insert download script for data.ottawa.ca

treefile <- file.path("/Users/dbuijs/Dropbox/TreesApp", "Tree-Inventory-Apr162013.kml")
if(!exists(alltrees)) print("Reading datafile...");alltrees <- readOGR(treefile, layer = "Tree_Inventory_Submitted_April")
alltrees <- as.data.frame(alltrees, stringsAsFactors = FALSE)
treemeta <- matrix(xpathSApply(htmlParse(as.character(alltrees$Description)), "//table//td", xmlValue), ncol = 11, byrow = TRUE)
alltrees <- cbind(alltrees, treemeta)
treemetanames <- xpathSApply(htmlParse(as.character(alltrees$Description[1])), "//table//th", xmlValue)[-1]
names(alltrees)[6:16] <- treemetanames
alltrees <- data.frame(mapply(function(alltrees, class) match.fun(paste("as", class, sep="."))(alltrees), alltrees, colClasses("ccnnnnfcffffnfcc"), SIMPLIFY=FALSE), stringsAsFactors=FALSE)
alltrees <- alltrees[,-c(2,5)]
names(alltrees)[2:3] <- c("longitude", "latitude")
alltrees <- as.data.table(alltrees)
setkey(alltrees, longitude, latitude)

maples <- grep("Maple", levels(alltrees$SPECIES), value = TRUE)
ashes <- grep("^Ash", levels(alltrees$SPECIES), value = TRUE)
evergreens <- grep("Pine|Spruce|Cedar|Fir|Pinus|Hemlock|Thuja", levels(alltrees$SPECIES), value = TRUE)
lilacs <- grep("Lilac", levels(alltrees$SPECIES), value = TRUE)
apples <- grep("apple", levels(alltrees$SPECIES), value = TRUE, ignore.case = TRUE)
oaks <- grep("^Oak", levels(alltrees$SPECIES), value = TRUE)

alltrees$treetype <- "Other"
alltrees[alltrees$SPECIES %in% maples, "treetype"] <- "Maple"
alltrees[alltrees$SPECIES %in% ashes, "treetype"] <- "Ash"
alltrees[alltrees$SPECIES %in% evergreens, "treetype"] <- "Evergreen"
alltrees[alltrees$SPECIES %in% lilacs, "treetype"] <- "Lilac"
alltrees[alltrees$SPECIES %in% apples, "treetype"] <- "Apple"
alltrees[alltrees$SPECIES %in% oaks, "treetype"] <- "Oak"
alltrees[alltrees$SPECIES == "Locust Honey" , "treetype"] <- "Honey Locust"
alltrees[alltrees$SPECIES == "Linden Littleleaf", "treetype"] <- "Linden"
alltrees[alltrees$SPECIES == "Hackberry" , "treetype"] <- "Hackberry"

colors <- brewer.pal(10, "Paired")
treetypes <- unique(alltrees$treetype)
alltrees$color <- colors[match(mtree$treetype, treetypes)]
mtree$popup <- paste0("<p>Species:  ", mtree$SPECIES, 
                      "<br>Street Address:  ", mtree$ADDNUM, mtree$ADDSTR, 
                      "<br>Diameter:   ", mtree$DBH, "</p>")
tmp.data <- apply(mtree, 1, as.list)


#save(alltrees, file = "alltree.RData)