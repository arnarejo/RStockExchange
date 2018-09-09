# load libraries
library(shiny)
library(ggplot2)
library(tidyquant)
library(shinydashboard)

# load data
load("filteredData.RData")

stocks <- unique(filteredData$Symbol)

ui <- dashboardPage(
    dashboardHeader(title="PSX stock app",
                    titleWidth = 350
                    ),
    dashboardSidebar(
        width = 350,
        sidebarMenu(
            selectInput(inputId="stockSelector", label="Select The stock", choices=stocks))
        ),
    dashboardBody(
        tags$head(
            tags$link(rel = "stylesheet", type = "text/css", href = "style.css")
        ),
        fluidRow(
            br(),
            column(width = 12,  box(title = "Stock Graph", width = NULL, solidHeader = FALSE, plotOutput("stockPlot")))
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {

   output$stockPlot <- renderPlot({

       data <- filteredData[filteredData$Symbol == input$stockSelector,]

       ggplot(data, aes(x = Date, y = Close)) +
           geom_line() +

           labs(y = "Closing Price", x = "Time") +
           theme_tq() +
           theme(text = element_text(size=17),
                 plot.background = element_rect(fill = "#F6F4E8"),
                 panel.background = element_rect(fill = "#F6F4E8"))

   })
}

# Run the application
shinyApp(ui = ui, server = server)
