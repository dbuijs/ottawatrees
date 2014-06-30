#Extract and parse description XML from Tree_Inventory
alltrees <- Tree_Inventory_Submitted_April; rm(Tree_Inventory_Submitted_April)
print("Parsing metadata, this may take some time ...")
treemeta <- matrix(xpathSApply(htmlParse(as.character(alltrees@data$Description)), "//table//td", xmlValue), ncol = 11, byrow = TRUE)
alltrees@data <- cbind(alltrees@data, treemeta, stringsAsFactors = FALSE)
treemetanames <- xpathSApply(htmlParse(as.character(alltrees@data$Description[1])), "//table//th", xmlValue)[-1]
names(alltrees@data)[3:13] <- treemetanames
print("Metadata parsed!")
alltrees@data <- alltrees@data[,-2]
alltrees@data[,1] <- as.character(alltrees@data[,1])
alltrees@data[,c(2:3,9, 11:12)] <- lapply(alltrees@data[,c(2:3,9, 11:12)], as.numeric)
alltrees@data[,c(5:8, 10)] <-lapply(alltrees@data[,c(5:8, 10)], as.factor)
print("Data types done!")
alltrees@data$neighbourhood <- over(alltrees, ottn)$names
#special tree fix
alltrees@data[is.na(alltrees@data$neighbourhood), "neighbourhood"] <- "Munster"

print("Added neighbourhoods!")

alltrees@data <- select(alltrees@data, 
                        name = Name, 
                        objectid = OBJECTID, 
                        ward = WARD, 
                        addnum = ADDNUM, 
                        street = ADDSTR, 
                        ltlocation = LTLOCATION, 
                        roadlocation = RDLOCATION, 
                        species = SPECIES, 
                        dbh = DBH, 
                        treatment = TREATMENT, 
                        eabtagnum = EABTAGNUMB, 
                        dedtagnum = DEDTAGNUMB, 
                        neighbourhood)
alltrees@data <- join(alltrees@data, treetypes[,1:2], by = "species") 
print("Added tree types!")
cache('alltrees')
