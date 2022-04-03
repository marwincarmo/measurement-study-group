titles <- c("Measurement in the Human Sciences w/ Dr. Derek Briggs", "Measuring Psychology #2 - Measurement in Science",
            "Measuring Psychology #3 - Representational measurement theory: Is its number up?",
            "Measuring Psychology #4 - Scaling theory and the nature of measurement",
            "Measuring Psychology #5 - Talk w/ Dr. Laura Bringmann & Dr. Markus I. Eronen",
            "Measuring Psychology #6 - Measurement: The theory of numerical assignments",
            "Measuring Psychology #7 - Psychological measurement between physics and statistics",
            "Measuring Psychology #8 - The ongoing dialog between empirical science and measurement theory",
            "Measuring Psychology #9 - Dr. Elina Vessonen: Representation in measurement",
            "Measuring Psychology #10 -  Measurement Theory, Psychology and the Revolution That Cannot Happen",
            "Measuring Psychology #11 - Dr. Stefanie Morris: Scale imposition as quantitative alchemy: Studies on the transitivity of neuroticism ratings",
            "Measuring Psychology #12 - Measurement Without Theory",
            "Measuring Psychology #13 - Dr. Derek Briggs pt. 2")

start_time <- c(format(Sys.Date(), "%Y-02-25 13:00:00"), format(Sys.Date(), "%Y-03-11 13:00:00"),
                format(Sys.Date(), "%Y-03-25 13:00:00"), format(Sys.Date(), "%Y-04-08 13:00:00"),
                format(Sys.Date(), "%Y-04-22 13:00:00"), format(Sys.Date(), "%Y-05-06 13:00:00"),
                format(Sys.Date(), "%Y-05-20 13:00:00"), format(Sys.Date(), "%Y-06-03 13:00:00"),
                format(Sys.Date(), "%Y-06-17 13:00:00"), format(Sys.Date(), "%Y-07-01 13:00:00"),
                format(Sys.Date(), "%Y-07-15 13:00:00"), format(Sys.Date(), "%Y-07-29 13:00:00"),
                format(Sys.Date(), "%Y-08-12 13:00:00"))

end_time <- c(format(Sys.Date(), "%Y-02-25 14:00:00"), format(Sys.Date(), "%Y-03-11 14:00:00"),
              format(Sys.Date(), "%Y-03-25 14:00:00"), format(Sys.Date(), "%Y-04-08 14:00:00"),
              format(Sys.Date(), "%Y-04-22 14:00:00"), format(Sys.Date(), "%Y-05-06 14:00:00"),
              format(Sys.Date(), "%Y-05-20 14:00:00"), format(Sys.Date(), "%Y-06-03 14:00:00"),
              format(Sys.Date(), "%Y-06-17 14:00:00"), format(Sys.Date(), "%Y-07-01 14:00:00"),
              format(Sys.Date(), "%Y-07-15 14:00:00"), format(Sys.Date(), "%Y-07-29 14:00:00"),
              format(Sys.Date(), "%Y-08-12 14:00:00"))

mp_calendar <- data.frame(
    title = titles,
    body = "EST timezone",
    start = start_time,
    end = end_time,
    category = "time",
    location = "Register for Zoom link",
    borderColor = "red"
)
