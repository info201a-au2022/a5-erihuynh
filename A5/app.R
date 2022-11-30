##################
##### A5 APP #####
##################

# set-up
library(shiny)

# source ui and server
source("ui.R")
source("server.R")

# run application
shinyApp(ui = ui, server = server)

