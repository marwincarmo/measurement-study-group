library(googledrive)
library(dplyr)
library(hms)
library(lubridate)
library(ggplot2)
library(scales)

drive_find(n_max = 30)

drive_download("inscritos", type = "csv", overwrite = TRUE)
raw_data <- readr::read_csv('inscritos.csv') %>% 
    janitor::clean_names()
glimpse(raw_data)

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
    
    # subtract 3600 seconds to transform the end time into start time (subtract 1 hour)
    original <- strptime(time, format = "%I%p",tz="UTC") - 3600
    
    offset <- stringr::str_extract(timezone, "\\d{2}:\\d{2}")
    
    if (is.na(offset)) {
        offset <- "00:00"
    }
    
    converted <- as.POSIXct(original + hm(offset),tz="UTC")
    format(converted, "%H:%M")
    
}

clean_data <- data %>% 
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
    dplyr::mutate(utc_start_time = parse_hm(to_utc(time_value, timezone))) %>% 
    dplyr::mutate(start_time_br = parse_hm(format(lubridate::with_tz(utc_start_time, tz = "America/Sao_Paulo"), "%H:%M")))


# time
clean_data %>% 
    with_groups(c(id, start_time_br), slice_head) %>% 
    filter(!is.na(start_time_br)) %>% 
    count(start_time_br) %>% 
    arrange(desc(n))

clean_data %>% 
    with_groups(c(id, utc_start_time), slice_head) %>% 
    filter(!is.na(utc_start_time)) %>% 
    count(utc_start_time) %>% 
    arrange(desc(n))

# date
clean_data %>% 
    with_groups(c(id, day_value), slice_head) %>% 
    filter(!is.na(day_value)) %>% 
    count(day_value) %>% 
    arrange(desc(n))

# general
clean_data %>% 
    with_groups(c(id, time_value), slice_head) %>% 
    filter(!is.na(time_value)) %>% 
    count(time_value) %>% 
    arrange(desc(n))

# Visualizing the results -------------------------------------------------

my_pretty_theme <- theme_minimal(base_family = "Roboto Condensed", base_size = 14) +
    theme(panel.grid.minor = element_blank(),
          # Bold, bigger title
          plot.title = element_text(face = "bold", size = rel(1.7)),
          # Plain, slightly bigger subtitle that is grey
          plot.subtitle = element_text(face = "plain", size = rel(1.3), color = "grey70"),
          # Italic, smaller, grey caption that is left-aligned
          plot.caption = element_text(face = "italic", size = rel(0.7), 
                                      color = "grey70", hjust = 0),
          legend.position = c("top"),
          legend.text = element_text(size=12),
          # Bold legend titles
          legend.title = element_text(face = "bold"),
          # Bold, slightly larger facet titles that are left-aligned for the sake of repetition
          strip.text = element_text(face = "bold", size = rel(1.1), hjust = 0),
          # Bold axis titles
          axis.title = element_text(face = "bold"),
          # Add some space above the x-axis title and make it left-aligned
          axis.title.x = element_text(margin = margin(t = 10), hjust = 0),
          axis.text.x = element_text(color = "grey70"),
          # Add some space to the right of the y-axis title and make it top-aligned
          axis.title.y = element_text(margin = margin(r = 10), hjust = 1),
          axis.text.y = element_text(color = "grey70"),
          # Add a light grey background to the facet titles, with no borders
          strip.background = element_rect(fill = "grey90", color = NA))

# time
start_time_plot <- clean_data %>% 
    with_groups(c(id, utc_start_time), slice_head) %>% 
    filter(!is.na(utc_start_time)) %>% 
    count(utc_start_time) %>% 
    ggplot(aes(x = utc_start_time, y = n)) +
    geom_col(fill="#F27256") +
    scale_x_time(breaks = as_hms(c('00:00:00',
                                   '04:00:00',
                                   '08:00:00',
                                   '12:00:00',
                                   '18:00:00',
                                   '22:00:00')),
                 labels = label_time(format = '%H:%M')) +
    labs(x = "Start time (UTC +0)", y = "Count") +
    my_pretty_theme

# day
week_day_plot <- clean_data %>% 
    with_groups(c(id, day_value), slice_head) %>% 
    filter(!is.na(day_value)) %>% 
    count(day_value) %>% 
    dplyr::mutate(day_value = factor(day_value, levels = c("Monday", "Tuesday",
                                                           "Wednesday", "Thursday",
                                                           "Friday"))) %>% 
    ggplot(aes(x = day_value, y = n)) +
    geom_col(color = "black", fill = "white") +
    labs(x = "Week Day", y = "Count") +
    my_pretty_theme
