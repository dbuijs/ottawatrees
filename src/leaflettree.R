#Leaflet Map
library(rCharts)

ltrees <- as.data.frame(alltrees[alltrees@data$neighbourhood == "Qualicum - Redwood Park",])


ttypes <- unique(ltrees$treetype)
colors <- rainbow(length(ttypes))
#colors <- tolower(colors)
ltrees$color <- colors[match(ltrees$treetype, ttypes)]
ltrees$popup <- paste0("<p>Species:  ", ltrees$species, 
                    "<br>Street Address:  ", ltrees$addnum, " ", ltrees$street, 
                    "<br>Diameter:   ", ltrees$dbh, "</p>")
tmp.data <- apply(ltrees, 1, as.list)

tree.map <- Leaflet$new()
tree.map$setView(c(45.34,-75.79), zoom = 16)
tree.map$tileLayer(provider = 'Stamen.TonerHybrid')
# Add Data as GeoJSON Layer and Specify Popup and FillColor
tree.map$geoJson(toGeoJSON(tmp.data, lat = 'coords.x2', lon = 'coords.x1'),
                onEachFeature = '#! function(feature, layer){
                layer.bindPopup(feature.properties.popup)
                } !#',
                pointToLayer =  "#! function(feature, latlng){
                return L.circleMarker(latlng, {
                radius: feature.properties.dbh/15 + 5,
                fillColor: feature.properties.color || 'red', 
                color: '#000',
                weight: 1,
                fillOpacity: 0.8
                })
                } !#"           
                )
tree.map$set(width = 1600, height = 800)
tree.map$enablePopover(TRUE)


tree.map$save("~/Dropbox/Public/LiveTrees3.html", cdn=T)