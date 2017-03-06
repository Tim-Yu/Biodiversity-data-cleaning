# Packages which need to be installed

    install.package("rgbif")
    install.package("rgdal")
    install.package("mapr")
    install.package("maps")
    install.package("rgeos")
    install.package("countrycode")
    install.package("maptools")

# Data reading

The working directory need to be setwd to the file which contain those files. Read the input description in the file.

# Methods

The function showing species in the centroid of a country is down by two part.

First is to generate the centroid area with the raw GIS data. How close to the centroid is adjustable.

Below is a graph showing how the centroid was generated. To be noticed that the buffer range, how far the centroid from the border, is in WGS system. 1 degree in buffer range is roughly equal to 118 km.

![Canada centroid](https://github.com/Tim-Yu/Biodiversity-data-cleaning/blob/master/Hard/centroid%20_generation_example.png)

Then, the centroid data was applied to limite the result of search. The result data is ploted like that

![Canada centroid](https://github.com/Tim-Yu/Biodiversity-data-cleaning/blob/master/Hard/Accipiter%20striatus.png)

