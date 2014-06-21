#May 14, 2014
#Daniel Buijs (dbuijs@gmail.com)
#CC BY-NC 2.5 CA (http://creativecommons.org/licenses/by-nc/2.5/ca/)

require(sp, rgdal, XML, plyr, ggmap, R.utils)

treefile <- file.path("/Users/dbuijs/Downloads", "Tree-Inventory-Apr162013.kml")
if(!exists(alltrees)) print("Reading datafile...");alltrees <- readOGR(treefile, layer = "Tree_Inventory_Submitted_April")
maploc <- geocode("rockcliffe, ottawa")
treemap <- get_map(c(lon= maploc[,"lon"], lat = maploc[,"lat"]), zoom = 16, source = "google")
treeselect <- which((alltrees@coords[,1] > attributes(treemap)$bb$ll.lon) & 
                 (alltrees@coords[,1] < attributes(treemap)$bb$ur.lon) & 
                 (alltrees@coords[,2] > attributes(treemap)$bb$ll.lat) & 
                 (alltrees@coords[,2] < attributes(treemap)$bb$ur.lat))
sometrees <- as.data.frame(alltrees[treeselect,], stringsAsFactors = FALSE)
#sometrees$Description <- as.character(sometrees$Description)
treemeta <- matrix(xpathSApply(htmlParse(as.character(sometrees$Description)), "//table//td", xmlValue), ncol = 11, byrow = TRUE)
#test3 <- laply(readHTMLTable(sometrees$Description, stringsAsFactors = FALSE), function(x) with(x, V2))
#sometrees <- cbind(sometrees, laply(readHTMLTable(sometrees$Description, stringsAsFactors = FALSE), function(x) with(x, V2)), stringsAsFactors = FALSE) 
sometrees <- cbind(sometrees, treemeta)
treemetanames <- xpathSApply(htmlParse(as.character(sometrees$Description[1])), "//table//th", xmlValue)[-1]
names(sometrees)[6:16] <- treemetanames
#names(sometrees)[6:16] <- as.vector(laply(readHTMLTable(sometrees$Description[1], stringsAsFactors = FALSE), function(x) with(x, V1)))
sometrees <- data.frame(mapply(function(sometrees, class) match.fun(paste("as", class, sep="."))(sometrees), sometrees, colClasses("ccnnnnfcffffnfcc"), SIMPLIFY=FALSE), stringsAsFactors=FALSE)

mp <- ggmap(treemap, extent = "device") + 
  geom_point(data = sometrees, aes(x=coords.x1, y = coords.x2, colour = SPECIES, size = DBH)) +
  guides(size = FALSE, col=guide_legend(ncol=2)) + ggtitle("Trees of Rockcliffe") + 
  theme(plot.title = element_text(lineheight=.8, face="bold"))
if(!empty(sometrees[sometrees$TREATMENT == "EAB",]))mp <- mp + geom_point(data = sometrees[sometrees$TREATMENT == "EAB",], aes(x=coords.x1, y = coords.x2), pch = 4)

mp <- ggmap(qmap, extent = "device") + 
  geom_point(data = qtrees1, aes(x=coords.x1, y = coords.x2, colour = SPECIES, size = DBH)) +
  guides(size = FALSE, col=guide_legend(ncol=2)) + ggtitle("Trees of Qualicum") + 
  theme(plot.title = element_text(lineheight=.8, face="bold"))
if(!empty(qtrees1[qtrees1$TREATMENT == "EAB",]))mp <- mp + geom_point(data = qtrees1[qtrees1$TREATMENT == "EAB",], aes(x=coords.x1, y = coords.x2), pch = 4)


  