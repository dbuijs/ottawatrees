#June 23, 2014
#Daniel Buijs (dbuijs@gmail.com)
#CC BY-NC 2.5 CA (http://creativecommons.org/licenses/by-nc/2.5/ca/)
#Helper functions
# require(sp, rgdal, XML, plyr, ggmap, R.utils) already loaded by ProjectTemplate

treepdf <- function(location, zoom = 16, source = "google"){
                                        maploc <- geocode(location)
                                        treemap <- get_map(c(lon= maploc[,"lon"], lat = maploc[,"lat"]), zoom = zoom, source = source)
                                        treeselect <- which((alltrees@coords[,1] > attributes(treemap)$bb$ll.lon) & 
                                                      (alltrees@coords[,1] < attributes(treemap)$bb$ur.lon) & 
                                                      (alltrees@coords[,2] > attributes(treemap)$bb$ll.lat) & 
                                                      (alltrees@coords[,2] < attributes(treemap)$bb$ur.lat))
                                        sometrees <- as.data.frame(alltrees[treeselect,], stringsAsFactors = FALSE)
                                        ifelse(length(summary(droplevels(sometrees$SPECIES))) > 36, legcol <- 3, legcol <- 2)

                                        
                                        map <- ggmap(treemap, extent = "device") + 
                                                geom_point(data = sometrees, aes(x=coords.x1, y = coords.x2, colour = SPECIES, size = DBH)) +
                                                guides(size = FALSE, col=guide_legend(ncol=legcol)) + 
                                                ggtitle(paste("Trees of", location, sep = " ")) + 
                                                theme(plot.title = element_text(lineheight=.8, face="bold"), legend.text=element_text(size=7))
                                        if(!empty(sometrees[sometrees$TREATMENT == "EAB",])) map <- map + geom_point(data = sometrees[sometrees$TREATMENT == "EAB",], aes(x=coords.x1, y = coords.x2), pch = 4)

                                       return(map)}