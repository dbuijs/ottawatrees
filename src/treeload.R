#June 19, 2014
#Daniel Buijs (dbuijs@gmail.com)
#CC BY-NC 2.5 CA (http://creativecommons.org/licenses/by-nc/2.5/ca/)
#Ottawa Tree Inventory is available as Open Data from http://data.ottawa.ca/dataset/tree-inventory-street-trees
#Neighbourhood shapefiles kindly provided by the Ottawa Neighbourhood Study under terms of use available here: http://neighbourhoodstudy.ca/ons-terms-of-use/
require(sp, rgdal, XML)
treefile <- ("Tree-Inventory-Apr162013.kml")
#This may take some time
print("Reading datafile...");alltrees <- readOGR(treefile, layer = "Tree_Inventory_Submitted_April")

treemeta <- matrix(xpathSApply(htmlParse(as.character(alltrees@data$Description)), "//table//td", xmlValue), ncol = 11, byrow = TRUE)
alltrees@data <- cbind(alltrees@data, treemeta, stringsAsFactors = FALSE)
treemetanames <- xpathSApply(htmlParse(as.character(alltrees@data$Description[1])), "//table//th", xmlValue)[-1]
names(alltrees@data)[3:13] <- treemetanames

alltrees@data <- alltrees@data[,-2]
alltrees@data[,1] <- as.character(alltrees@data[,1])
alltrees@data[,c(2:3,9, 11:12)] <- lapply(alltrees@data[,c(2:3,9, 11:12)], as.numeric)
alltrees@data[,c(5:8, 10)] <-lapply(alltrees@data[,c(5:8, 10)], as.factor)

ottn <- readOGR(dsn = ".", layer = "ONSNeighbourhoods2012_SmallFile")
ottn <-spTransform(ottn, CRS("+proj=longlat +ellps=WGS84 +towgs84=0,0,0,0,0,0,0 +no_defs"))

alltrees@data$neighbourhood <- over(alltrees, ottn)$names
