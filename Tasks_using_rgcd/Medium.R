# Medium task
#
# By Boyu Yu(Tim)

# Install the package 
devtools::install_github("Tim-Yu/rgcd", dependences = TRUE)

library(rgcd)

# Get the occurrences data and check the date records
# The input is a string contains the species name and the country for checking 
# (can go without contry) separated with ','.
#
# Due to the low download speed, it is recommended that query one species at one
# time

Checkdate("Pinus contorta,Canada", number = 20000)

# This function returns the gbif data with a new column indicating which date is
# missing.


