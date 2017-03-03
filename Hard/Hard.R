# Test_Hard 2
# 
#By Boyu YU



#Library
library(sp)
library(rgdal)
#library(maptools)
library(rgeos)

#Library package
library(rgbif)
#library(mapr)
#library(spocc)
#library(leaflet)
library(countrycode)
library(maps)

CentroidSpices <- function(filename, buffer_range = 8){
        
        
        
        #Read the species names
        species <- read.table(sep = ",", file = filename)
        species_c <- as.character(species)
        species_n <- length(species_c)
        for(i in seq_along(species)){
                species_c[i] <- as.character( species[[i]])
        }
        species_c <- as.character(species_c)

        #get country
        countryname <- species_c[species_n]
        country_code <- countrycode(countryname, 'country.name', 'iso2c')
        species_n <- species_n - 1
        
        #get adjustable centroid WKT data function
        getcountry <- function(country,buffer_range){
                #read shap
                map_total <- readOGR(dsn = file.path(getwd(),'TM_WORLD_BORDERS-0.3', fsep = .Platform$file.sep), layer = 'TM_WORLD_BORDERS-0.3')
                country_map <- map(database = map_total, regions = country)
                #from map to SP
                IDs <- sapply(strsplit(country_map$names, ":"), function(x) x[1])
                country_map_sp <- map2SpatialPolygons(country_map, IDs=IDs, proj4string=CRS("+proj=longlat +datum=WGS84"))
                #forming the adjustable centroid rigion 
                centroid <- gBuffer(country_map_sp, width = -buffer_range)
                centroid_WKT <- writeWKT(centroid)
        }
        
        #Searching for the occurrence data
        species_c <- species_c[1:species_n]
        dat <- occ_search(scientificName = species_c, limit = 300, country = country_code, geometry = getcountry(countryname, buffer_range), geom_big = "bbox")
        
        #rest part may ubdate later for the mapping
        #Checking if some species are missing in this area
        #s_exist <- logical(length = species_n)
        #for(i in seq_along(species_c)){
        #        s_exist[i] <- if(length(dat$gbif$data[i][[1]]) == 0){FALSE}else{TRUE}
        #}
        #species_ce <- species_c[s_exist]
        #species_ne <- length(species_ce)
}
