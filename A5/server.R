#####################
##### A5 SERVER #####
#####################
library("shiny")
library("ggplot2")


server <- function(input, output) {
  wrangle <- reactive({
    req(input$country)
    
    country_filter <- data %>% 
      summarize(total_ghg, co2, coal_co2, gas_co2, oil_co2, country, year) %>% 
      arrange(-year) %>% 
      filter(country %in% input$country) %>%
      na.omit %>% 
      head(25)
  })
  
  output$plot <- renderPlotly({
    g <- ggplot(wrangle(), aes(x = year, y = .data[[input$VarY]])) +
      geom_bar(stat = "sum")
    
    ggplotly(g)
    
  })
  
}