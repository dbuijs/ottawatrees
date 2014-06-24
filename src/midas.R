kmlfile <- "midas_stations_by_area.kml"
ogrListLayers(k)
midascanada <- readOGR(k, "CANADA")
midasmeta <- matrix(xpathSApply(htmlParse(as.character(midascanada@data$Description)), "//table//tr/td[2]", xmlValue), nrow = nrow(midascanada@data), byrow = TRUE)
midasmetanames <- xpathSApply(htmlParse(as.character(midascanada@data$Description[1])), "//table//tr/td[1]", xmlValue)
midasmetanames <- str_sub(midasmetanames, end = -2L)
midascanada@data <- cbind(midascanada@data, midasmeta)
names(midascanada@data)[3:7] <- midasmetanames
