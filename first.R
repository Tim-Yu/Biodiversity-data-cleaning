# Test_Easy 1
# By Boyu YU
#
# Library packages

library(rgbif)
library(mapr)
library(spocc)
library(leaflet)
library(countrycode)

#Read the species names
species <- read.table(sep = ",", file = "species.txt")
species_c <- as.character(species)
species_n <- length(species_c)
for(i in seq_along(species)){
        species_c[i] <- as.character( species[[i]])
}
species_c <- as.character(species_c)

#Check if user want see the occurrence data in specific country
countryname <- species_c[species_n]
country_code <- countrycode(countryname, 'country.name', 'iso2c')
checkcountry <- !is.na(country_code)
if(checkcountry == TRUE){
        species_n <- species_n - 1
}


#Searching for the occurrence data
if(checkcountry == TRUE){
        species_c <- species_c[1:species_n]
        dat <- occ(query = species_c, from = 'gbif', limit = 300, has_coords = TRUE, gbifopts = list(country = country_code))
        #Checking if some species are missing in this area
        s_exist <- logical(length = species_n)
        for(i in seq_along(species_c)){
                s_exist[i] <- if(length(dat$gbif$data[i][[1]]) == 0){FALSE}else{TRUE}
        }
        species_ce <- species_c[s_exist]
        species_ne <- length(species_ce)
}else{
        dat <- occ(query = species_c, from = 'gbif', limit = 300, has_coords = TRUE)
}

#If no specie is in that area, programme will return the species occurrance data in whole world
if(species_ne == 0){
        dat <- occ(query = species_c, from = 'gbif', limit = 300, has_coords = TRUE)
}

#Checking if some species are missing in this area
#s_exist <- logical(length = species_n)
#for(i in seq_along(species_c)){
#        s_exist[i] <- if(length(dat$gbif$data[i][[1]]) == 0){FALSE}else{TRUE}
#}
#species_c <- species_c[s_exist]
#species_n <- length(species_c)

#Record the used colors
colorslist <- c('#FE2E2E', '#64FE2E', '#2E9AFE', '#FE2EC8', '#FACC2E', '#2EFE9A', '#642EFE', '#FE642E', '#2EFE64', '#2E64FE', '#FE2E9A')
if(species_ne == 0){
        colors_used <- colorslist[1:species_n]
}else {colors_used <- colorslist[1:species_ne]}

#Mapping
maps <- map_leaflet(dat, size = 2, color = colors_used)

maps

#Adding legend to the map
if(checkcountry == TRUE & species_ne != 0){
        addLegend(maps, position = 'bottomright', colors = colors_used, labels = species_ce, opacity = 2, title = paste('Species in', countryname, sep = " "))

}else if(species_ne == 0){
        addLegend(maps, position = 'bottomright', colors = colors_used, labels = species_c, opacity = 2, title = paste('No species in', countryname,"Here are species over world", sep = " "))
        
}else{
        addLegend(maps, position = 'bottomright', colors = colors_used, labels = species_c, opacity = 2, title = 'Species')

}

##End of the code
