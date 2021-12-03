library(htmltools)

# From Malcolm Barrett
# https://github.com/laRusers/socalr.org
# https://socalr.org/

as_card <- function(event_name, group_name, link, ...) {
    tags$div(
        class = "card",
        tags$a(
            href = link,
            class = "action_link",
            div(
                class = "container",
                tags$div(group_name, class = "card-group"),
                tags$div(event_name, class = "card-header"),
                #tags$div(event_time, class = "card-time")
            )
        )
    )
}