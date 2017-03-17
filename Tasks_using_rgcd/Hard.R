# Hard task
#
# By Boyu Yu(Tim)

# Install the package 
devtools::install_github("Tim-Yu/rgcd", dependencies = TRUE)

library(rgcd)

# The input country is the country common name eg. united state, china.
# The buff_range is how close the centroid is from the border. One in buff_range
# roughly equals to 118km.
# The input species is a string contains the species name and the country for 
# checking (cannot go without contry!!) separated with ','.

Getcentroidspecies <-function(country, buff_range, species){
        centroid <- Getcentroid(country, buff_range)
        CentroidSpeices(species, centroid)
}

# This function returns the gbif data which inside the centroid.

# Example of get data
library(rgbif)

csd <- Getcentroidspecies('canada', 5, "Pinus contorta,Danaus plexippus,Canada")
gbifmap(csd$`Pinus contorta`$data)
