#Leaflet Map
#library(leafletR)
maples <- grep("Maple", levels(alltrees$SPECIES), value = TRUE)
ashes <- grep("^Ash", levels(alltrees$SPECIES), value = TRUE)
evergreens <- grep("Pine|Spruce|Cedar|Fir|Pinus|Hemlock|Thuja", levels(alltrees$SPECIES), value = TRUE)
lilacs <- grep("Lilac", levels(alltrees$SPECIES), value = TRUE)
apples <- grep("apple", levels(alltrees$SPECIES), value = TRUE, ignore.case = TRUE)
oaks <- grep("^Oak", levels(alltrees$SPECIES), value = TRUE)

treetyper <- function(species){
                                switch(species,
                                       )
}
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

colors <- brewer.pal(10, "Paired")
treetypes <- unique(mtree$treetype)
mtree$color <- colors[match(mtree$treetype, treetypes)]
mtree$popup <- paste0("<p>Species:  ", mtree$SPECIES, 
                    "<br>Street Address:  ", mtree$ADDNUM, mtree$ADDSTR, 
                    "<br>Diameter:   ", mtree$DBH, "</p>")
tmp.data <- apply(mtree, 1, as.list)

tree.map <- Leaflet$new()
tree.map$setView(c(45.34,-75.80), zoom = 16)
tree.map$tileLayer(provider = 'Stamen.TonerLite')
# Add Data as GeoJSON Layer and Specify Popup and FillColor
tree.map$geoJson(toGeoJSON(tmp.data, lat = 'latitude', lon = 'longitude'),
                onEachFeature = '#! function(feature, layer){
                layer.bindPopup(feature.properties.popup)
                } !#',
                pointToLayer =  "#! function(feature, latlng){
                return L.circleMarker(latlng, {
                radius: feature.properties.DBH/15 + 5,
                fillColor: feature.properties.color || 'red', 
                color: '#000',
                weight: 1,
                fillOpacity: 0.8
                })
                } !#"           
                )
tree.map$set(width = 1600, height = 800)
tree.map$enablePopover(TRUE)
tree.map$save("LiveTrees2.html", cdn=T)

#bus.map$publish('Bloomington IL Bus Stops', host = 'gist')
#bus.map$save("index.html", cdn=T)

maple, honey locust, linden, ash, evergreen, lilac, apple, oak, hackberry, serviceberry
t.dat <- toGeoJSON(data=mtree, name="ward8", lat.lon=c(3,2))
t.popup <- c("SPECIES", "DBH", "ADDNUM", "ADDSTR")
t.col <- colors()[c(51:151, 450:551)]
t.style <- styleGrad(prop="DBH", breaks = seq(1:200), style.val = seq(1:200)*0.1, 
                     style.par="rad", leg="Diameter")
map <- leaflet(data=t.dat, 
               dest="~/Dropbox/Public", 
               style=t.style, title="Trees of Ward 8", 
               base.map="osm", popup=t.popup, incl.data=TRUE)
browseURL(map)

L1 <- Leaflet$new()
L1$tileLayer(provider = 'Stamen.TonerLite')
L1$set(width = 1600, height = 800)
L1$setView(c(45.3640, -75.7011), 12)
L1$geoJson(t.dat, 
           onEachFeature = '#! function(feature, layer){
          if (feature.properties && feature.properties.popupContent) {
          layer.bindPopup(feature.properties.popupContent);
          }
          } !#',
           pointToLayer =  "#! function(feature, latlng){
          return L.circleMarker(latlng, {
          radius: feature.properties.DBH,
          fillColor: feature.properties.SPECIES,
          weight: 1,
          fillOpacity: 0.8
          })
          }!#"
)
L1$enablePopover(TRUE)
L1$fullScreen(TRUE)

a <- rMaps:::Leaflet$new()
a$setView(c(59.34201, 18.09503), zoom = 13)
a$geoJson(data,
          onEachFeature = '#! function(feature, layer){
          if (feature.properties && feature.properties.popupContent) {
          layer.bindPopup(feature.properties.popupContent);
          }
          } !#',
          pointToLayer =  "#! function(feature, latlng){
          return L.circleMarker(latlng, {
          radius: 6,
          fillColor: feature.properties.fillColor,
          weight: 1,
          fillOpacity: 0.8
          })
          }!#"
          )
a$set(height = 300)
a

as.character(tagList(
  tags$h4("Score:", as.integer(selectedZip$centile)),
  tags$strong(HTML(sprintf("%s, %s %s",
                           selectedZip$city.x, selectedZip$state.x, selectedZip$zipcode
  ))), tags$br(),
  sprintf("Median household income: %s", dollar(selectedZip$income * 1000)), tags$br(),
  sprintf("Percent of adults with BA: %s%%", as.integer(selectedZip$college)), tags$br(),
  sprintf("Adult population: %s", selectedZip$adultpop)
