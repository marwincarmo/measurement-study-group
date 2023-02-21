library(dplyr)
library(readr)
library(tidygeocoder)
library(leaflet)

form_atual <- read_csv("~/Measuring Psychology/data/MP registration form new (respostas) - Respostas ao formulário 1.csv") |> 
  janitor::clean_names() |> 
  dplyr::filter(country_of_residence != "Afghanistan") |> 
  dplyr::select(c(email_address, affilliation, country_of_residence)) |> 
  dplyr::filter(email_address != "mmcarmo@ucdavis.edu")

# form1 <- read_csv("~/Measuring Psychology/data/inscritos - Form Responses 1.csv") |> 
#   janitor::clean_names()|> 
#   dplyr::select(c(email_address, country_of_residence))

form2 <- read_csv("~/Measuring Psychology/data/MP registration form (answers) - Form Responses 2.csv") |> 
  janitor::clean_names() |> 
  dplyr::filter(country_of_residence != "Afghanistan")|> 
  dplyr::select(c(email_address, affilliation, country_of_residence))


forms <- dplyr::bind_rows(form2, form_atual) |> 
  dplyr::distinct(email_address, .keep_all = TRUE) |> 
  tibble::rowid_to_column("id") |> 
  dplyr::select(-email_address)


# Institution address -----------------------------------------------------

participants_address <- forms |> 
  dplyr::filter(!is.na(affilliation)) |> 
  mutate(addr = paste0(affilliation, ", ", country_of_residence)) |>  
  geocode(address = addr, method = 'bing', lat = latitude , long = longitude) |> 
  janitor::clean_names()

map_data <- participants_address |> 
  with_groups(c(affilliation:longitude), mutate, n = n(),
              prop = n/nrow(participants_address)*100)
  
readr::write_csv(map_data, "assets/map_data_2023.csv")
