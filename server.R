#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/

install.packages(c('shiny', 'ggplot2'))
library("shiny")

Dat<-read.csv("Franchise_Failureby_Brand2011.csv", sep=';')
names(Dat)[1]<-paste("Brand")
names(Dat)[2]<-paste("Failure")
names(Dat)[3]<-paste("Disbursement")
names(Dat)[4]<-paste("Disb$X$1000")
names(Dat)[5]<-paste("Chgoff")
Dat1<-Dat[is.na(Dat)==FALSE,]
df<-sapply(Dat1, gsub, pattern='%', replacement='')
Dat<-as.data.frame(df)

Dat$Failure<-as.numeric(Dat$Failure)
Dat$Disbursement<-as.numeric(Dat$Disbursement)
Dat$Chgoff<-as.numeric(Dat$Chgoff)
Dat$`Disb$X$1000`<-as.numeric(Dat$`Disb$X$1000`)


# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  DatSv <- reactive({
    Dat[, c(input$xcol, input$ycol)]
  })
  
  # Generate plot 

  output$plot1 <- renderPlot({
    library("ggplot2")

   plot(DatSv(), col="red",
         main=paste('Plot of ',input$ycol, sep=''))
   
  })
  
  output$info <- renderText({
    xy_str <- function(e) {
      if(is.null(e)) return("NULL\n")
      paste0("x=", round(e$x, 1), " y=", round(e$y, 1), "\n")
    }
    xy_range_str <- function(e) {
      if(is.null(e)) return("NULL\n")
      paste0("xmin=", round(e$xmin, 1), " xmax=", round(e$xmax, 1), 
             " ymin=", round(e$ymin, 1), " ymax=", round(e$ymax, 1))
    }
    
    paste0(
      "click: ", xy_str(input$plot_click),
      "dblclick: ", xy_str(input$plot_dblclick),
      "hover: ", xy_str(input$plot_hover),
      "brush: ", xy_range_str(input$plot_brush)
    )
  })
  
  # Generate summary of data
  
  output$summary<-renderPrint({
    summary(Dat)
  }) 
  
})


