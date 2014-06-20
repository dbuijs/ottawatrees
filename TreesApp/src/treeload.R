#June 10, 2014
#Daniel Buijs (dbuijs@gmail.com)
#CC BY-NC 2.5 CA (http://creativecommons.org/licenses/by-nc/2.5/ca/)
#Ottawa Tree Inventory is available as Open Data from http://data.ottawa.ca/dataset/tree-inventory-street-trees

treefile <- ("Tree-Inventory-Apr162013.kml")
print("Reading datafile...");alltrees <- readOGR(treefile, layer = "Tree_Inventory_Submitted_April")

treemeta <- matrix(xpathSApply(htmlParse(as.character(alltrees$Description)), "//table//td", xmlValue), ncol = 11, byrow = TRUE)
#test3 <- laply(readHTMLTable(sometrees$Description, stringsAsFactors = FALSE), function(x) with(x, V2))
#sometrees <- cbind(sometrees, laply(readHTMLTable(sometrees$Description, stringsAsFactors = FALSE), function(x) with(x, V2)), stringsAsFactors = FALSE) 
alltrees <- cbind(alltrees, treemeta)
treemetanames <- xpathSApply(htmlParse(as.character(alltrees$Description[1])), "//table//th", xmlValue)[-1]
names(sometrees)[6:16] <- treemetanames
#names(sometrees)[6:16] <- as.vector(laply(readHTMLTable(sometrees$Description[1], stringsAsFactors = FALSE), function(x) with(x, V1)))
sometrees <- data.frame(mapply(function(sometrees, class) match.fun(paste("as", class, sep="."))(sometrees), sometrees, colClasses("ccnnnnfcffffnfcc"), SIMPLIFY=FALSE), stringsAsFactors=FALSE)
