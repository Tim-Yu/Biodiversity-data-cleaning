# Easy task
#
# By Boyu Yu(Tim)

# Install the package 
devtools::install_github("Tim-Yu/rgcd", dependences = TRUE)

library(rgcd)

# Get the occurrences data
# The input is a string contains the species name and the country for checking 
# (can go without contry) separated with ','.

dat <- Getoccdat("Pinus contorta,Danaus plexippus,Canada")

# Plot the data

leaflet_occdat(dat)