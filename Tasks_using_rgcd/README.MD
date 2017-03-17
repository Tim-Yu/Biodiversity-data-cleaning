# Biodiversity-data-cleaning tasks by rgcd package
All the tasks need to be run under the latest R version (3.3.2) and with the latest Rstudio (1.0.136)

## Pre-install package

Package'devtools' is needed to install the rgcd package from github.

## Easy task

This program can show one to ten species occurrence data in the map. Moreover, user can choose different country to show the date.

![result](https://github.com/Tim-Yu/Biodiversity-data-cleaning/blob/master/Easy/result%20example.PNG)

## Medium task

This function can get occurrences data of a set of species from GBIF and check if there is any missing event date (eg. missing event month or day). Then it will add a column tothe gbif data indicates which date information is missing, meanwhile, it can output a matrix showing the eventdate, month and day missing rates.

Below is an example output.


    >Checkdate("Pinus contorta,Homo sapiens,Danaus plexippus,Canada", number = 10000)
         
         Species names No eventdate rate No month rate No day rate
    1   Pinus contorta        0.17983651    0.22343324   0.2343324
    2     Homo sapiens        0.23529412    0.94117647   1.0000000
    3 Danaus plexippus        0.04353933    0.06226592   0.0664794

## Hard task

This function can generate a certriod area and then use this data to limit the search result.

![certriod](https://github.com/Tim-Yu/Biodiversity-data-cleaning/blob/master/Hard/centroid%20_generation_example.png)

![result](https://github.com/Tim-Yu/Biodiversity-data-cleaning/blob/master/Hard/Accipiter%20striatus.png)
