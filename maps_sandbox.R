# required libraries ------------------------------------------------------
library(tidyverse)
library(osmdata)


# coordinates of San Juan, Argentina --------------------------------------
# x-value is longitude and y-value is latitude
coord_sj <- getbb("San Juan in Argentina")


# coordinates of Buenos Aires, Argentina ----------------------------------
coord_bsas <- getbb("Buenos Aires in Argentina")



# features for San Juan, Argentina ----------------------------------------
# OpenStreetMap represents physical features on the ground (e.g., roads or 
# buildings) using tags attached to its basic data structures. Each tag 
# describes a geographic attribute of the feature being shown.
# https://wiki.openstreetmap.org/wiki/Map_Features

# streets of San Juan, Argentina
streets <- getbb("San Juan in Argentina") %>%
  opq() %>%
  add_osm_feature(key = "highway", 
                  value = c("motorway", 
                            "primary", 
                            "secondary",
                            "tertiary")) %>%
  osmdata_sf()
streets

# small streets of San Juan, Argentina
small_streets <- getbb("San Juan in Argentina") %>%
  opq() %>%
  add_osm_feature(key = "highway", 
                  value = c("residential", 
                            "living_street",
                            "unclassified",
                            "service", 
                            "footway")) %>%
  osmdata_sf()


# river in San Juan, Argentina
river <- getbb("San Juan in Argentina")%>%
  opq()%>%
  add_osm_feature(key = "waterway", 
                  value = "river") %>%
  osmdata_sf()


# public transport
public_transport <- getbb("San Juan in Argentina")%>%
  opq()%>%
  add_osm_feature(key = "public_transport", 
                  value = c("stop_position",
                            "platform",
                            "station", 
                            "stop_area")) %>%
  osmdata_sf()


# shops
shops <- getbb("San Juan in Argentina")%>%
  opq()%>%
  add_osm_feature(key = "shop", 
                  value = c("supermarket",
                            "kiosk", 
                            "general")) %>%
  osmdata_sf()


# features for Buenos Aires, Argentina ------------------------------------
# streets of Buenos Aires, Argentina
streets_bsas <- getbb("Buenos Aires in Argentina") %>%
  opq() %>%
  add_osm_feature(key = "highway", 
                  value = c("motorway", 
                            "primary", 
                            "secondary",
                            "tertiary")) %>%
  osmdata_sf()
streets_bsas


# electrical power generation and distributions systems for Bs As
electrical_bsas <- getbb("Buenos Aires in Argentina")%>%
  opq()%>%
  add_osm_feature(key = "power", 
                  value = c("lines",
                            "minor_line",
                            "substation", 
                            "cable", 
                            "catenary_mast",
                            "pole")) %>%
  osmdata_sf()


# public transport for Buenos Aires
public_transport_bsas <- getbb("Buenos Aires in Argentina")%>%
  opq()%>%
  add_osm_feature(key = "public_transport", 
                  value = c("stop_position",
                            "platform",
                            "station", 
                            "stop_area")) %>%
  osmdata_sf()



# plots for San Juan, Argentina -------------------------------------------
# main street map
ggplot() +
  geom_sf(data = streets$osm_lines,
          inherit.aes = FALSE,
          color = "black",
          size = .4,
          alpha = .8) +
coord_sf(xlim = c(-68.575, -68.48), 
         ylim = c(-31.59, -31.5),
         expand = FALSE) 


# main and small streets and river
ggplot() +
  geom_sf(data = streets$osm_lines,
          inherit.aes = FALSE,
          color = "black",
          size = .4,
          alpha = .8) +
  geom_sf(data = small_streets$osm_lines,
          inherit.aes = FALSE,
          color = "black",
          size = .4,
          alpha = .6) + 
  coord_sf(xlim = c(-68.575, -68.48), 
           ylim = c(-31.59, -31.5),
           expand = FALSE) 


# main streets and river
ggplot() +
  geom_sf(data = streets$osm_lines,
          inherit.aes = FALSE,
          color = "black",
          size = .2,
          alpha = .8) +
  geom_sf(data = river$osm_lines,
          inherit.aes = FALSE,
          color = "blue",
          size = .5,
          alpha = .8) +
  coord_sf(xlim = c(coord_sj[1, 1], coord_sj[1, 2]),
           ylim = c(coord_sj[2, 1], coord_sj[2, 2]),
           expand = TRUE) 


# main streets and public transport
ggplot() +
  geom_sf(data = streets$osm_lines,
          inherit.aes = FALSE,
          color = "black",
          size = .2,
          alpha = .8) +
  geom_sf(data = public_transport$osm_lines,
          inherit.aes = FALSE,
          color = "red",
          size = .5,
          alpha = .8) +
  coord_sf(xlim = c(coord_sj[1, 1], coord_sj[1, 2]),
           ylim = c(coord_sj[2, 1], coord_sj[2, 2]),
           expand = TRUE) 


# main streets and shops
ggplot() +
  geom_sf(data = streets$osm_lines,
          inherit.aes = FALSE,
          color = "black",
          size = .2,
          alpha = .8) +
  geom_sf(data = shops$osm_lines,
          inherit.aes = FALSE,
          color = "red",
          size = .5,
          alpha = .8) +
  coord_sf(xlim = c(-68.575, -68.48), 
           ylim = c(-31.59, -31.5),
           expand = FALSE) 



# plots for Buenos Aires --------------------------------------------------
# main streets and electrical for Bs As
ggplot() +
  geom_sf(data = streets_bsas$osm_lines,
          inherit.aes = FALSE,
          color = "black",
          size = .2,
          alpha = .8) +
  geom_sf(data = electrical_bsas$osm_lines,
          inherit.aes = FALSE,
          color = "red",
          size = .4,
          alpha = .6) +
  geom_sf(data = public_transport_bsas$osm_lines,
          inherit.aes = FALSE,
          color = "darkgreen",
          size = 1,
          alpha = 1) +
  coord_sf(xlim = c(coord_bsas[1, 1], coord_bsas[1, 2]),
           ylim = c(coord_bsas[2, 1], coord_bsas[2, 2]),
           expand = TRUE) +
  theme_void() +
  theme(plot.background = element_rect(fill = "#282828"))




# improved plots ----------------------------------------------------------
# highlight main streets in color
ggplot() +
  geom_sf(data = streets$osm_lines,
          inherit.aes = FALSE,
          color = "steelblue",
          size = .4,
          alpha = .8) +
  geom_sf(data = small_streets$osm_lines,
          inherit.aes = FALSE,
          color = "black",
          size = .4,
          alpha = .6) +
  coord_sf(xlim = c(-68.575, -68.48), 
           ylim = c(-31.59, -31.5),
           expand = FALSE) 


# white map
white_map <- ggplot() +
  geom_sf(data = streets$osm_lines,
          inherit.aes = FALSE,
          color = "steelblue",
          size = .6,
          alpha = 1) +
  geom_sf(data = small_streets$osm_lines,
          inherit.aes = FALSE,
          color = "black",
          size = .4,
          alpha = .6) +
  coord_sf(xlim = c(-68.575, -68.48), 
           ylim = c(-31.59, -31.5),
           expand = FALSE) +
  theme_void()

white_map


# dark map
dark_map <- ggplot() +
  geom_sf(data = streets$osm_lines,
          inherit.aes = FALSE,
          color = "#7fc0ff",
          size = .4,
          alpha = .8) +
  geom_sf(data = small_streets$osm_lines,
          inherit.aes = FALSE,
          color = "#ffbe7f",
          size = .2,
          alpha = .6) +
  coord_sf(xlim = c(-68.575, -68.48), 
           ylim = c(-31.59, -31.5),
           expand = FALSE) +
  theme_void() +
  theme(plot.background = element_rect(fill = "#282828"))

dark_map


# save maps as png files --------------------------------------------------
# save maps
ggsave("white_map.png", width = 6, height = 6)
ggsave("dark_map.png", width = 6, height = 6)



# save and load workspace -------------------------------------------------
# save this workspace
save.image(file = "sj_arg_map_workspace.RData")

# load workspace
load("sj_arg_map_workspace.RData")
  