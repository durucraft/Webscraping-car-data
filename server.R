#create datframe to add user input
responses<- data.frame(Miles=numeric(0),Year=numeric(0),City=numeric(0),Highway=numeric(0),
                       Curbwieght=numeric(0),HP=numeric(0),RPM=numeric(0),Brand=character(0),Drivetype=character(0),
                       Turbo=character(0),Color=character(0),Style=character(0))
#creating table to ouput basic stats of the models
basic_stats <- matrix(c(92.3,2481.95,90.5,1451.94,86.5,2265.77,85.4,1753.15),ncol=2,byrow=TRUE)
colnames(basic_stats) <- c("Cor","RSME")
rownames(basic_stats) <- c("SUV","Sedan","Wagon","Hactback")
basic_stats<-as.table(basic_stats)
library(shiny)
 shinyServer(function(input,output){
   counter <- reactiveValues(i = 0)
   observeEvent( input$submit,{ # check if the action button is clicked
       counter$i <- counter$i + 1
     })
   
   rv <- reactiveValues(newdf=responses)
   #when page load if submit is seen create dataframe
   observeEvent(input$submit,{
     rv$newdf <- data.frame(Miles=input$Miles,Year=input$Year,City=input$City,Highway=input$Highway,
                            Curbwieght=input$Curbwieght,HP=input$HP,RPM=input$RPM,Brand=input$Brand,Drivetype=input$Drivetype,
                            Turbo=input$Turbo,Color=input$Color,Style=input$Style)
   })
   #when button is press it open model and calculate price
  price<-eventReactive(input$submit,{
    tryCatch({
    source("Regression model.R")
    as.double(as.character(
      unlist((Analysis(rv$newdf[-13]))[2])))
    }, error=function(err){
    error_message<-"Sorry model was sleeping please click submit button again"
  })
    })
  model<-eventReactive(input$submit,{
    source("Regression model.R")
      (Analysis(rv$newdf[-13]))[1]
  })
  Sums<-eventReactive(input$submit,{
    source("Summary.R")
    Sum(rv$newdf[-13])
  })
  tab<-eventReactive(input$submit,{
    source("Dataframe.R")
    data_frames(rv$newdf[-13])
  })
  not_bran<-eventReactive(input$submit,{
    source("not_brand.R")
    car_brands(input$Style,input$Brand)
  })
  #ouputs the prices and render it as a text 
  output$Car_price<-renderText({
    price()
  })
  output$sum<-renderPrint({
    Sums()
  })
  output$frame<-renderTable({
    tab()
    })
  output$stats<-renderTable(
    {
      basic_stats
    }
  )
  output$models<-renderPrint({
    model()
  })
  output$Not_Car<-renderPrint({
    not_bran()
  })
  })
 
