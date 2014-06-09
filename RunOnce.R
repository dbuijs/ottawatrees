#May 24, 2014
#Daniel Buijs (dbuijs@gmail.com)
#CC BY-NC 2.5 CA (http://creativecommons.org/licenses/by-nc/2.5/ca/)
#Run-once to grab the data and convert

library(rgal, XML, R.utils, data.table)
#Insert download script for data.ottawa.ca

treefile <- file.path("/Users/dbuijs/Downloads", "Tree-Inventory-Apr162013.kml")
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

#save(alltrees, file = "alltree.RData)