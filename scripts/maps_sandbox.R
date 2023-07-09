# All the work here is inspired by Christian Burkhart (@ChBurkhart)
# Blog post: https://ggplot2tutor.com/streetmaps/streetmaps/

# Required libraries ------------------------------------------------------
library(tidyverse)
library(osmdata)
library(sf)


# Coordinates of San Juan, Argentina --------------------------------------
# x-value is longitude and y-value is latitude
coord_sj <- getbb("San Juan in Argentina")


# Coordinates of Buenos Aires, Argentina ----------------------------------
coord_bsas <- getbb("Buenos Aires in Argentina")



# Features for San Juan, Argentina ----------------------------------------
# OpenStreetMap represents physical features on the ground (e.g., roads or 
# buildings) using tags attached to its basic data structures. Each tag 
# describes a geographic attribute of the feature being shown.
# https://wiki.openstreetmap.org/wiki/Map_Features

# Streets of San Juan, Argentina
streets <- getbb("San Juan in Argentina") %>%
  opq() %>%
  add_osm_feature(key = "highway", 
                  value = c("motorway", 
                            "primary", 
                            "secondary",
                            "tertiary")) %>%
  osmdata_sf()

# Print streets
streets

# Small streets of San Juan, Argentina
small_streets <- getbb("San Juan in Argentina") %>%
  opq() %>%
  add_osm_feature(key = "highway", 
                  value = c("residential", 
                            "living_street",
                            "unclassified",
                            "service", 
                            "footway")) %>%
  osmdata_sf()


# River in San Juan, Argentina
river <- getbb("San Juan in Argentina") %>%
  opq() %>%
  add_osm_feature(key = "waterway", 
                  value = "river") %>%
  osmdata_sf()


# Public transport
public_transport <- getbb("San Juan in Argentina") %>%
  opq() %>%
  add_osm_feature(key = "public_transport", 
                  value = c("stop_position",
                            "platform",
                            "station", 
                            "stop_area")) %>%
  osmdata_sf()


# Shops
shops <- getbb("San Juan in Argentina") %>%
  opq()%>%
  add_osm_feature(key = "shop", 
                  value = c("supermarket",
                            "kiosk", 
                            "general")) %>%
  osmdata_sf()



# Features for Buenos Aires, Argentina ------------------------------------
# Streets of Buenos Aires, Argentina
streets_bsas <- getbb("Buenos Aires in Argentina") %>%
  opq() %>%
  add_osm_feature(key = "highway", 
                  value = c("motorway", 
                            "primary", 
                            "secondary",
                            "tertiary")) %>%
  osmdata_sf()

# Print street_bsas
streets_bsas


# Electrical power generation and distributions systems for Bs As
electrical_bsas <- getbb("Buenos Aires in Argentina") %>%
  opq() %>%
  add_osm_feature(key = "power", 
                  value = c("lines",
                            "minor_line",
                            "substation", 
                            "cable", 
                            "catenary_mast",
                            "pole")) %>%
  osmdata_sf()


# Public transport for Buenos Aires
public_transport_bsas <- getbb("Buenos Aires in Argentina") %>%
  opq() %>%
  add_osm_feature(key = "public_transport", 
                  value = c("stop_position",
                            "platform",
                            "station", 
                            "stop_area")) %>%
  osmdata_sf()

# Shops in Buenos Aires
shops_bsas <- getbb("Buenos Aires in Argentina") %>%
  opq() %>%
  add_osm_feature(key = "shop", 
                  value = c("supermarket",
                            "kiosk", 
                            "general")) %>%
  osmdata_sf()


# Plots for San Juan, Argentina -------------------------------------------
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


# Main and small streets and river
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


# Main streets and river
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


# Main streets and public transport
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


# Main streets and shops
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



# Plots for Buenos Aires --------------------------------------------------
# Main streets, electrical and public transport for Bs As
bsas_map <- ggplot() +
  geom_sf(data = streets_bsas$osm_lines,
          inherit.aes = FALSE,
          color = "steelblue",
          size = .2,
          alpha = .8) +
  geom_sf(data = electrical_bsas$osm_lines,
          inherit.aes = FALSE,
          color = "yellow",
          size = .4,
          alpha = .6) +
  geom_sf(data = public_transport_bsas$osm_lines,
          inherit.aes = FALSE,
          color = "white",
          size = 1,
          alpha = 1) +
  coord_sf(xlim = c(coord_bsas[1, 1], coord_bsas[1, 2]),
           ylim = c(coord_bsas[2, 1], coord_bsas[2, 2]),
           expand = TRUE) +
  theme_void() +
  theme(plot.background = element_rect(fill = "#282828"))

# Print bsas_map
bsas_map



# Improved plots ----------------------------------------------------------
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


# White map
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

# Print white_map
white_map


# Dark map
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

# Print dark_map
dark_map


# Save maps as png files --------------------------------------------------
# Save maps
ggsave("plots/white_map.png", width = 6, height = 6)
ggsave("plots/dark_map.png", width = 6, height = 6)
ggsave("plots/bsas_map.png", width = 6, height = 6)


# Save and load workspace -------------------------------------------------
# Save this workspace
save.image(file = "data/osm_maps_workspace.RData")

# Load workspace
load("data/osm_maps_workspace.RData")
  