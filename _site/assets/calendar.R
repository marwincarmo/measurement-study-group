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

start_time <- c(format(Sys.Date(), "%Y-02-25 18:00:00"), format(Sys.Date(), "%Y-03-11 18:00:00"),
                format(Sys.Date(), "%Y-03-25 18:00:00"), format(Sys.Date(), "%Y-04-08 18:00:00"),
                format(Sys.Date(), "%Y-04-22 18:00:00"), format(Sys.Date(), "%Y-05-06 18:00:00"),
                format(Sys.Date(), "%Y-05-20 18:00:00"), format(Sys.Date(), "%Y-06-03 18:00:00"),
                format(Sys.Date(), "%Y-06-17 18:00:00"), format(Sys.Date(), "%Y-07-01 18:00:00"),
                format(Sys.Date(), "%Y-07-15 18:00:00"), format(Sys.Date(), "%Y-07-29 18:00:00"),
                format(Sys.Date(), "%Y-08-12 18:00:00"))

end_time <- c(format(Sys.Date(), "%Y-02-25 19:00:00"), format(Sys.Date(), "%Y-03-11 19:00:00"),
              format(Sys.Date(), "%Y-03-25 19:00:00"), format(Sys.Date(), "%Y-04-08 19:00:00"),
              format(Sys.Date(), "%Y-04-22 19:00:00"), format(Sys.Date(), "%Y-05-06 19:00:00"),
              format(Sys.Date(), "%Y-05-20 19:00:00"), format(Sys.Date(), "%Y-06-03 19:00:00"),
              format(Sys.Date(), "%Y-06-17 19:00:00"), format(Sys.Date(), "%Y-07-01 19:00:00"),
              format(Sys.Date(), "%Y-07-15 19:00:00"), format(Sys.Date(), "%Y-07-29 19:00:00"),
              format(Sys.Date(), "%Y-08-12 19:00:00"))

mp_calendar <- data.frame(
    title = titles,
    body = "GMT +0 timezone",
    start = start_time,
    end = end_time,
    category = "time",
    location = "Register for Zoom link",
    borderColor = "red"
)
