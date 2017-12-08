#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
shinyUI(fluidPage(
  titlePanel("Plot Franchise Failure"),
  sidebarLayout(
    sidebarPanel(
      selectInput('ycol', 'Y Variable', names(Dat)[1]),
      selectInput('xcol', 'X Variable', names(Dat)[2:5]),
      checkboxInput("show_xlab", "Show/Hide X Axis Label", value=TRUE),
      checkboxInput("show_ylab", "Show/Hide Y Axis Label", value=TRUE),
      checkboxInput("show_title", "Show/Hide Title")
    ),
  mainPanel(
    tabsetPanel(
      type = "tabs",
      tabPanel("Plot", plotOutput("plot1")),
      tabPanel("Summary", verbatimTextOutput("summary"))
  )
  )
)
)
)




