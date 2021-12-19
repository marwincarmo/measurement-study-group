library(googledrive)
library(dplyr)
library(hms)
library(lubridate)

drive_find(n_max = 30)

drive_download("inscritos", type = "csv")
raw_data <- readr::read_csv('inscritos.csv') %>% 
    janitor::clean_names()
glimpse(data)

# Selecting columns with useful info for analysis
data <- raw_data %>% 
    dplyr::select(4,8:10) %>% 
    tidyr::drop_na() %>% 
    dplyr::mutate(id = row_number(), .before = everything())

# Renaming columns
names(data) <- c("id","country", "hour", "timezone", "day")

# Getting the maximum number of available time blocks selected by users.
# This will be useful tu determine how many new columns we need to create when
# we apply a function to separate each time block
max_block <- max(unlist(lapply(strsplit(as.character(data$hour),','), length)))

# we'll use this function to convert the chosen time to UTC+0 timezone
to_utc <- function(time, timezone) {
    
    original <- strptime(time, format = "%I%p",tz="UTC")
    
    offset <- stringr::str_extract(timezone, "\\d{2}:\\d{2}")
    
    if (is.na(offset)) {
        offset <- "00:00"
    }
    
    converted <- as.POSIXct(original + hm(offset),tz="UTC")
    format(converted, "%H:%M")
    
}

data %>% 
    # first lets work with the time data. we need to unify all options in a unique column
    tidyr::separate(hour, into = paste0("time_", 1:max_block), sep = ",") %>% 
    tidyr::pivot_longer(dplyr::starts_with('time_'), names_to = "time_label", values_to = "time_value") %>% 
    dplyr::mutate(time_value = stringr::str_squish(time_value)) %>% 
    # to simplify we can work with only the ending time
    dplyr::mutate(time_value = stringr::str_remove(time_value, "\\d{2}.*-")) %>%
    # next, we do a similar procedure to day column
    tidyr::separate(day, into = paste0("day_", 1:5), sep = ",") %>% 
    tidyr::pivot_longer(dplyr::starts_with('day_'), names_to = "day_label", values_to = "day_value") %>% 
    dplyr::mutate(day_value = stringr::str_squish(day_value)) %>% 
    dplyr::mutate(utc_time = parse_hm(to_utc(time_value, timezone))) %>% 
    dplyr::mutate(start_time_br = as.POSIXct(utc_time, tz = "America/Sao_Paulo", usetz = TRUE))

data %>% 
    pull(timezone)


tz(Sys.time())


format(to_utc("12PM", "(UTC+01:00) Amsterdam, Berlin, Bern, Rome, Stockholm, Vienna"), "%H:%M")



