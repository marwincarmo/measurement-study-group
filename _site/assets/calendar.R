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
            "Measuring Psychology #13 - Dr. Derek Briggs: The Next Chapter of Educational Measurement",
            "Measuring Psychology #14 - The attack of the psychometricians",
            "Measuring Psychology #15 - Values in Psychometrics + Latent Variable Theory",
            "Measuring Psychology #16 - The theoretical status of latent variables",
            "Measuring Psychology #17 - Dr. Vithor Franco: How to Think Straight About Psychometrics",
            "Measuring Psychology #18 - Measurement schmeasurement: Questionable measurement practices and how to avoid them")

start_time <- c(format(Sys.Date(), "2022-02-25 18:00:00"), format(Sys.Date(), "%Y-03-11 18:00:00"),
                format(Sys.Date(), "2022-03-25 18:00:00"), format(Sys.Date(), "2022-04-08 18:00:00"),
                format(Sys.Date(), "2022-04-22 18:00:00"), format(Sys.Date(), "2022-05-06 18:00:00"),
                format(Sys.Date(), "2022-05-20 18:00:00"), format(Sys.Date(), "2022-06-03 18:00:00"),
                format(Sys.Date(), "2022-06-17 18:00:00"), format(Sys.Date(), "2022-07-01 18:00:00"),
                format(Sys.Date(), "2022-07-15 18:00:00"), format(Sys.Date(), "2022-07-29 18:00:00"),
                format(Sys.Date(), "2022-08-12 18:00:00"), format(Sys.Date(), "2022-10-10 17:00:00"), 
                format(Sys.Date(), "2022-11-07 17:00:00"), format(Sys.Date(), "2022-11-21 17:00:00"), 
                format(Sys.Date(), "2022-12-05 17:00:00"), format(Sys.Date(), "2022-12-19 17:00:00"))

end_time <- c(format(Sys.Date(), "2022-02-25 19:00:00"), format(Sys.Date(), "2022-03-11 19:00:00"),
              format(Sys.Date(), "2022-03-25 19:00:00"), format(Sys.Date(), "2022-04-08 19:00:00"),
              format(Sys.Date(), "2022-04-22 19:00:00"), format(Sys.Date(), "2022-05-06 19:00:00"),
              format(Sys.Date(), "2022-05-20 19:00:00"), format(Sys.Date(), "2022-06-03 19:00:00"),
              format(Sys.Date(), "2022-06-17 19:00:00"), format(Sys.Date(), "2022-07-01 19:00:00"),
              format(Sys.Date(), "2022-07-15 19:00:00"), format(Sys.Date(), "2022-07-29 19:00:00"),
              format(Sys.Date(), "2022-08-12 19:00:00"), format(Sys.Date(), "2022-10-10 18:00:00"), 
              format(Sys.Date(), "2022-11-07 18:00:00"), format(Sys.Date(), "2022-11-21 18:00:00"), 
              format(Sys.Date(), "2022-12-05 18:00:00"), format(Sys.Date(), "2022-12-19 18:00:00"))

mp_calendar <- data.frame(
    title = titles,
    body = "GMT +0 timezone",
    start = start_time,
    end = end_time,
    category = "time",
    location = "Register for Zoom link",
    borderColor = "red"
)
