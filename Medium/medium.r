# Test_medium 3
#
# By Boyu YU

library(countrycode)
library(rgbif)

#The input of this function is the file pathway and how many records do the user want
#to check

checkdate <- function(filename = 'species.txt', number = 100){
        #Read the species names
        species <- read.table(sep = ",", file = filename)
        species_c <- as.character(species)
        species_n <- length(species_c)
        for(i in seq_along(species)){
                species_c[i] <- as.character(species[[i]])
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
                dat <- occ_search(scientificName = species_c, limit = number,country = country_code)
                #Checking if some species are missing in this area
                s_exist <- logical(length = species_n)
                for(i in seq_along(species_c)){
                        if(species_n == 1){
                                s_exist[i] <- if(length(dat$data) == 0){FALSE}else{TRUE}
                        }else{
                                s_exist[i] <- if(length(dat[[i]]$data) == 0){FALSE}else{TRUE}
                        }
                }
                species_ce <- species_c[s_exist]
                species_ne <- length(species_ce)
        }else{
                dat <- occ_search(scientificName = species_c, limit = number)
        }
        
        #If no specie is in that area, programme will return the species occurrance data in whole world
        if(species_ne == 0){
                dat <- occ_search(scientificName = species_c, limit = number)
        }
        #Searching for the missing value
        if(species_n == 1){ # Only one species
                dat$data$datequality <- NULL
                dat$data <- cbind(dat$data, datequality = c(""))
                dat$data$datequality <- as.character(dat$data$datequality)
                for(j in seq_along(dat$data$name)){
                        if(is.na(dat$data$lastCrawled[j])) {
                                dat$data$datequality[j] <- c("Last crawled date missing ")}
                        if(is.na(dat$data$lastParsed[j])) {
                                dat$data$datequality[j] <- paste(dat$data$datequality[j], "Last parsed date missing", sep = ',')}
                        if(is.na(dat$data$lastInterpreted[j])) {
                                dat$data$datequality[j] <- paste(dat$data$datequality[j], "Last interpreted date missing", sep = ',')}
                        if(is.na(dat$data$eventDate[j])) {
                                dat$data$datequality[j] <- paste(dat$data$datequality[j], "Event date missing", sep = ',')}
                        if(is.na(dat$data$dateIdentified[j])) {
                                dat$data$datequality[j] <- paste(dat$data$datequality[j], "Identified date missing", sep = ',')}
                        if(is.na(dat$data$modified[j])) {
                                dat$data$datequality[j] <- paste(dat$data$datequality[j], "Modified date missing", sep = ',') }
                        if(dat$data$datequality[j] == c("")) {
                                dat$data$datequality[j] <- c("Full record")} 
                        if(substring(dat$data$datequality[j], 1, 1) == "," ) {dat$data$datequality[j] <- substring(dat$data$datequality[j], 2)}
                }
        }else{ #Multipel species
                for(i in seq_along(species_ce)){
                        dat[[i]]$data$datequality <- NULL
                        dat[[i]]$data <- cbind(dat[[i]]$data, datequality = c(""))
                        dat[[i]]$data$datequality <- as.character(dat[[i]]$data$datequality)
                        for(j in seq_along(dat[[i]]$data$name)){
                                if(is.na(dat[[i]]$data$lastCrawled[j])) {
                                        dat[[i]]$data$datequality[j] <- c("Last crawled date missing ")}
                                if(is.na(dat[[i]]$data$lastParsed[j])) {
                                        dat[[i]]$data$datequality[j] <- paste(dat[[i]]$data$datequality[j], "Last parsed date missing", sep = ',')}
                                if(is.na(dat[[i]]$data$lastInterpreted[j])) {
                                        dat[[i]]$data$datequality[j] <- paste(dat[[i]]$data$datequality[j], "Last interpreted date missing", sep = ',')}
                                if(is.na(dat[[i]]$data$eventDate[j])) {
                                        dat[[i]]$data$datequality[j] <- paste(dat[[i]]$data$datequality[j], "Event date missing", sep = ',')}
                                if(is.na(dat[[i]]$data$dateIdentified[j])) {
                                        dat[[i]]$data$datequality[j] <- paste(dat[[i]]$data$datequality[j], "Identified date missing", sep = ',')}
                                if(is.na(dat[[i]]$data$modified[j])) {
                                        dat[[i]]$data$datequality[j] <- paste(dat[[i]]$data$datequality[j], "Modified date missing", sep = ',') }
                                if(dat[[i]]$data$datequality[j] == c("")) {
                                        dat[[i]]$data$datequality[j] <- c("Full record")} 
                                if(substring(dat[[i]]$data$datequality[j], 1, 1) == "," ) {dat[[i]]$data$datequality[j] <- substring(dat[[i]]$data$datequality[j], 2)}
                        }
                }
        }
                return(dat)
}
