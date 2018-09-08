# load libraries
library(shiny)
library(ggplot2)

# load data
#load("filteredData.RData")

# Define UI for application that draws a histogram
ui <- fluidPage(
   
   # Application title
   titlePanel("PSX - Stocks Visualization"),
   
   # Sidebar with a slider input for number of bins 
   sidebarLayout(
      sidebarPanel(
    ## stock input selection
          selectInput(inputId="stockSelector", label="Select The stock", choices=unique(filteredData$Symbol), selected = "OGDC")
          
          
      ),
      
      # Show a plot of the generated distribution
      mainPanel(
          # plot the stock price
         plotOutput("stockPlot")
      )
   )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
   
   output$stockPlot <- renderPlot({
       
       data <- filteredData[filteredData$Symbol == input$stockSelector,]
       
       ggplot(data, aes(x = Date, y = Close, color = Symbol)) + geom_line()
   })
}

# Run the application 
shinyApp(ui = ui, server = server)

