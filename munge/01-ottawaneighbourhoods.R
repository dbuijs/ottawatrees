#Rename the neighbourhoods object and re-project into long/lat
#June 19, 2014
#Daniel Buijs (dbuijs@gmail.com)
#CC BY-NC 2.5 CA (http://creativecommons.org/licenses/by-nc/2.5/ca/)
#Ottawa Tree Inventory is available as Open Data from http://data.ottawa.ca/dataset/tree-inventory-street-trees
#Neighbourhood shapefiles kindly provided by the Ottawa Neighbourhood Study under terms of use available here: http://neighbourhoodstudy.ca/ons-terms-of-use/

ottn <- ONSNeighbourhoods2012_SmallFile; rm(ONSNeighbourhoods2012_SmallFile)
ottn <-spTransform(ottn, CRS("+proj=longlat +ellps=WGS84 +towgs84=0,0,0,0,0,0,0 +no_defs"))
cache(ottn)