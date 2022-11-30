#################
##### A5 UI #####
#################

# loading packages
library("shiny")
library("shinythemes")
library("tidyverse")
library("data.table")
library("ggplot2")
library("plotly")

# reading data set
data <- read.csv("https://raw.githubusercontent.com/owid/co2-data/master/owid-co2-data.csv")
write.csv(data, file = "owid-co2-data.csv")

#####################
##### VARIABLES #####
#####################

  # This pulls the average of annual production-based carbon dioxide emissions
  # from coal in the year 1995, in million tonnes.
  avg_coal_co2_1995 <- data %>% 
    filter(year == "1995") %>% 
    summarize(round(mean(coal_co2, na.rm = TRUE), digits = 2)) %>%
    pull()
  
  # This pulls the year with the highest annual total of carbon dioxide 
  # production-based emissions.
  avg_coal_co2_2021 <- data %>% 
    filter(year == "2021") %>% 
    summarize(round(mean(coal_co2, na.rm = TRUE), digits = 2)) %>%
    pull()
  
  # This pulls the population of the world when the highest total greenhouse 
  # gas emissions occurred. 
  population_max_total_ghg <- data %>% 
    filter(total_ghg == max(total_ghg, na.rm = TRUE)) %>% 
    pull(population)

# defining UI for application
ui <- fluidPage(theme = shinytheme("cerulean"),
    navbarPage(title = "Changing Carbon Emissions Over Time",
               tabPanel("Overview",
                        h1("Overview"),
                        p("Throughout this assignment, I chose to highlight the 
                          impact of carbon emissions released overtime from different 
                          forms. This included coal, oil, gas, and overall total 
                          emissions in several different countries. Within my 
                          calculations to show these comparisons, it was found 
                          that in 1995, an average of", strong("173.05 million tonnes"),
                          "of carbon dioxide emissions came from coal while 2021 had 
                          an average of", strong("273.98 million tonnes."), "Additionally,
                          during the time period of the highest total greenhouse gas 
                          emissions, the population of the world rested at", 
                          strong("7,764,951,040 people.")),
                        p("These values show a near 100 million
                          tonnes carbon emissions increase across the world with 
                          an emphasis upon the increasing population. They are 
                          directly correlated together, proving how fossil fuels 
                          have likely resulted from a rapidly evolving population, 
                          further strengthening the need for action against the 
                          use of nonrenewable resources for everyday production.")
                        ),
               
               tabPanel("Interactive Visualization",
                        h1("Interactive Visualization"),
                        selectInput(inputId = "country",
                                    label = "Please select a country.",
                                    list("Africa",
                                         "Australia",
                                         "Canada",
                                         "China",
                                         "France",
                                         "India",
                                         "Mexico",
                                         "Russia",
                                         "Vietnam")),
                        selectInput(inputId = "VarY",
                                    label = "Please select a variable to view.",
                                    choices = list("Total Greenhouse Gas Emissions" = "total_ghg", 
                                                   "Total Carbon Dioxide Emissions" = "co2",
                                                   "Carbon Dioxide Emissions from Coal" = "coal_co2",
                                                   "Carbon Dioxide Emissions from Gas" = "gas_co2",
                                                   "Carbon Dioxide Emissions from Oil" = "oil_co2")),
                        plotlyOutput("plot"),
                        h2("Analysis"),
                        p("By adjusting through different countries and numerous 
                          variations of greenhouse gas emissions, we are able to 
                          conclude that these rates have continuously increased. 
                          This visualization is therefore important in promoting
                          issues of climate change given these dangerous emissions
                          levels.")
                        
               )
    )
)
  
