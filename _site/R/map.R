library(dplyr)
library(tidygeocoder)
library(leaflet)


participants <- readr::read_csv2("assets/participants.csv")

participants_address <- participants %>% 
    mutate(addr = paste0(University, ", ", Country)) %>% 
    geocode(address = addr, method = 'bing', lat = latitude , long = longitude) %>% 
    janitor::clean_names()


para_mapa <- participants_address %>%
    select(id, country) %>% 
    with_groups(country, summarise, n = n()) %>% 
    with_groups(country, mutate, prop = n/nrow(participants_address)*100)

para_mapa_unis <- participants %>% 
    select(id, university, country) %>% 
    geocode(address = university, method = 'geocodio', lat = latitude , long = longitude)

para_mapa_unis_pais <- para_mapa_unis %>% 
    left_join(participants_address, by = c("country", "university", "id"), suffix = c("_uni", "_country")) %>% 
    mutate(latitude_uni = ifelse(is.na(latitude_uni), latitude_country, latitude_uni),
           longitude_uni = ifelse(is.na(longitude_uni), longitude_country, latitude_uni))

readr::write_csv(para_mapa_unis_pais, "assets/participants_lat_lon.csv")

map_data <- participants_address %>% 
    with_groups(c(university:longitude), mutate, n = n(),
                prop = n/nrow(participants)*100)

color_palett <- leaflet::colorNumeric(palette = 'viridis', domain = NULL, na.color = '#FFFFFF')

map_data %>% 
    leaflet() %>% 
    addTiles() %>% 
    addMarkers(lng = ~longitude, lat = ~latitude, 
        popup = paste0(
            '<b>Country:</b> ',map_data$university, '<br>',
            '<b>Participants:</b> ', map_data$n, '<br>'
        ),
        clusterOptions = markerClusterOptions()
    )

readr::write_csv(map_data, "assets/map_data.csv")


# Fixing addresses --------------------------------------------------------

usf_addr <- tibble::tibble(university = c("São Francisco University","Uni7"),
                           addr = c("Av. Carlos de Campos, 550 - Jardim Sao Jose, Bragança Paulista - SP, 12916-220",
                                    "Av. Almirante Maximiniano da Fonseca, 1395 - Luciano Cavalcante, Fortaleza - CE")) %>% 
    tidygeocoder::geocode(addr, method = "bing", lat = latitude , long = longitude)

map_data_fixed <- map_data %>% 
    dplyr::mutate(latitude = dplyr::case_when(
        university == "Uni7" ~ dplyr::pull(dplyr::select(dplyr::filter(usf_addr, university == "Uni7"), latitude)),
        university == "São Francisco University"  ~ dplyr::pull(dplyr::select(dplyr::filter(usf_addr, university == "São Francisco University"), latitude)),
        TRUE ~ latitude
    ),
    longitude = dplyr::case_when(
        university == "Uni7" ~ dplyr::pull(dplyr::select(dplyr::filter(usf_addr, university == "Uni7"), longitude)),
        university == "São Francisco University"  ~ dplyr::pull(dplyr::select(dplyr::filter(usf_addr, university == "São Francisco University"), longitude)),
        TRUE ~ longitude
    ))

readr::write_csv(map_data_fixed, "assets/map_data_fixed.csv")


# New members -------------------------------------------------------------

old_map <- readr::read_csv("assets/map_data_fixed.csv")
new_map <- readr::read_csv("assets/map_data_2023.csv") |> # From participants_database.R
  dplyr::rename(c(university = affilliation, 
                  country = country_of_residence))
  
dplyr::bind_rows(old_map, new_map)
  