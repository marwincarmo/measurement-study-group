library(shiny)
library(toastui)

mp_calendar <- data.frame(
    title = "Measurement in the Human Sciences w/ Dr. Derek Briggs",
    body = "EST timezone",
    start = format(Sys.Date(), "%Y-%m-25 13:00:00"),
    end = format(Sys.Date(), "%Y-%m-25 14:00:00"),
    category = "time"
)

ui <- fluidPage(
    #tags$h2("Navigate in calendar with actionButtons"),
    actionButton(
        inputId = "prev_date",
        label = "Previous",
        icon = icon("chevron-left")
    ),
    actionButton(
        inputId = "next_date",
        label = "Next",
        icon = icon("chevron-right")
    ),
    actionButton(
        inputId = "today",
        label = "Today"
    ),
    fluidRow(
        column(
            width = 9,
            calendarOutput(outputId = "my_calendar")
        ),
        column(
            width = 3,
            verbatimTextOutput("result")
        )
    )
)

server <- function(input, output, session) {
    
    output$my_calendar <- renderCalendar({
        calendar(view = "month", 
                 useDetailPopup = TRUE,
                 defaultDate = Sys.Date(),
                 useNavigation = TRUE) %>%
            cal_schedules(mp_calendar)
    })
    
    output$result <- renderPrint({
        input$my_calendar_dates
    })
    
    observeEvent(input$prev_date, cal_proxy_prev("my_calendar"))
    observeEvent(input$next_date, cal_proxy_next("my_calendar"))
    observeEvent(input$today, cal_proxy_today("my_calendar"))
    
}


if (interactive())
    shinyApp(ui, server)