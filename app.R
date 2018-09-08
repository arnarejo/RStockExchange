# load libraries
library(shiny)
library(ggplot2)
library(tidyquant)
library(shinydashboard)

# load data
load("filteredData.RData")

stocks <- unique(filteredData$Symbol)

ui <- dashboardPage(skin = "green",
    dashboardHeader(title="Stock App",
                    titleWidth = 350
                    ),
    dashboardSidebar(
        width = 350,
        sidebarMenu(
            selectInput(inputId="stockSelector", label="Select The stock", choices=stocks))
        ),
    dashboardBody(
        fluidRow(
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
           labs(title = "Stock Price Chart", y = "Closing Price", x = "") + 
           theme_tq() +
           theme(text = element_text(size=17))
       
   })
}

# Run the application 
shinyApp(ui = ui, server = server)

