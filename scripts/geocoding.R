# required libraries ------------------------------------------------------
library(leaflet)
library(jsonlite)


# geocoding function using OSM Nominatim API ------------------------------
# details: http://wiki.openstreetmap.org/wiki/Nominatim
# made by: D.Kisler 

nominatim_osm <- function(address = NULL)
{
  if(suppressWarnings(is.null(address)))
    return(data.frame())
  tryCatch(
    d <- jsonlite::fromJSON( 
      gsub('\\@addr\\@', gsub('\\s+', '\\%20', address), 
           'http://nominatim.openstreetmap.org/search/@addr@?format=json&addressdetails=0&limit=1')
    ), error = function(c) return(data.frame())
  )
  if(length(d) == 0) return(data.frame())
  return(data.frame(lon = as.numeric(d$lon), lat = as.numeric(d$lat)))
}


# dplyr will be used to stack lists together into a data.frame and to get the pipe operator '%>%'
suppressPackageStartupMessages(library(dplyr))




# input addresses ---------------------------------------------------------
addresses <-c("Manzanares 2131, Nuñez, Buenos Aires",
              "Crisologo Larralde 1935, Nuñez, Buenos Aires",
              "Cabildo 3600, Nuñez, Buenos Aires")



# function usage ----------------------------------------------------------
d <- suppressWarnings(lapply(addresses, function(address) {
  # set the elapsed time counter to 0
  t <- Sys.time()
  # calling the nominatim OSM API
  api_output <- nominatim_osm(address)
  # get the elapsed time
  t <- difftime(Sys.time(), t, 'secs')
  # return data.frame with the input address, output of the nominatim_osm function and elapsed time
  return(data.frame(address = address, api_output, elapsed_time = t))
}) %>%
  # stack the list output into data.frame
  bind_rows() %>% data.frame())

# output the data.frame content into console
d 



# plot points on a map ----------------------------------------------------
d %>% select(lon, lat) %>% leaflet() %>% addTiles() %>% addMarkers()