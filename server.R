#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/

Dat<-read.csv("A:\\home\\Documents\\Franchise_Failureby_Brand2011.csv", sep=';')
names(Dat)[1]<-paste("Brand")
names(Dat)[2]<-paste("Failure")
names(Dat)[3]<-paste("Disbursement")
names(Dat)[4]<-paste("Disb$X$1000")
names(Dat)[5]<-paste("Chgoff")
Dat1<-Dat[is.na(Dat)==FALSE,]
df<-sapply(Dat1, gsub, pattern='%', replacement='')
Dat<-as.data.frame(df)
Dat<-Dat[1:578,]

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
         main=paste('Histogram of ',input$ycol, sep=''))
   
  })
  
  # Generate summary of data
  
  output$summary<-renderPrint({
    summary(Dat)
  }) 
  
})