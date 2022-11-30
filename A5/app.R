##################
##### A5 APP #####
##################

# set-up packages
library("shiny")
library("shinythemes")
library("tidyverse")
library("data.table")
library("ggplot2")
library("plotly")

# source ui and server
source("ui.R")
source("server.R")

# run application
shinyApp(ui = ui, server = server)

