#data-overide.R
#download Ottawa Tree Dataset from data.ottawa.ca if not already present
#Assumes ONS neighbourhood files are in raw-data. 
#Contact ONS directly at http://neighbourhoodstudy.ca/ if necessary.
#import all kml and shp layers in raw-data with rgdal.
#libraries loaded separately because this script runs before ProjectTempalte loads other libraries.
if(config$data_loading == "on"){
  library(rgdal)
  library(sp)
treeurl <- "http://data.ottawa.ca/en/storage/f/2013-04-22T134822/Tree-Inventory-Apr162013.kml"
if(!"Tree-Inventory-Apr162013.kml" %in% list.files("raw-data", pattern = "*.kml")) {
      print("Downloading tree file")
      download.file(treeurl, "raw-data/Tree-Inventory-Apr162013.kml", mode = "wb")
} else print("Tree file already downloaded")

kmlfiles <- list.files("raw-data", pattern = "*.kml")
print(paste(length(kmlfiles), "kml files to parse", sep = " "))
for(k in kmlfiles){
  kfile <- file.path("raw-data/", k)
  klayers <- ogrListLayers(kfile)
  print(paste(length(klayers), "layers in", k, sep = " "))
  for(l in klayers){print(paste("Reading KML layer", l, sep = " "))
                    assign(l, readOGR(kfile, layer = l))
  }
}

shpdirs <- dirname(list.files("raw-data", pattern = "*.shp", recursive = TRUE))
print(paste(length(shpdirs), "shp files to parse", sep = " "))
for(s in shpdirs){
  dsn <- file.path("raw-data/", s)
  slayers <- ogrListLayers(dsn)
  print(paste(length(slayers), "layers in", s, sep = " "))
  for(l in slayers){
    print(paste("Reading SHP layer", l, sep = " "))
    assign(l, readOGR(dsn, layer = l))
  }
}

rm(k, l, kfile, klayers, dsn, s, slayers, shpdirs)
}