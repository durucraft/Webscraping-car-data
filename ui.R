#install.packages("shiny")
#install.packages("shinythemes")
Car_brand <-
  read.csv('newbrand.csv',
           header = FALSE)
Colors <-
  read.csv('Colors.csv',
           header = FALSE)
library(shiny)
library(shinythemes)
shinyUI(fluidPage(
  theme=shinytheme("lumen"),
  titlePanel("Used Car Price Calculator"),
  sidebarLayout(
    sidebarPanel(("Car Information"),
                 numericInput("Miles", "Mileage on Car", ""),
                 numericInput("Year", "Year of Car", ""),
                 numericInput("City", "City gas Milage", ""),
                 numericInput("Highway", "Highway gas Milage", ""),
                 numericInput("Curbwieght", "Curbwieght of Car", ""),
                 numericInput("HP", "HorsePower of Car", ""),
                 numericInput("RPM", "RPM of Car", ""),
                 selectInput("Style", "Style of car",c("Sedan","SUV","Wagon","Hatchback"),selectize = TRUE),
                 selectInput("Brand", "Select the Brand", c(Car_brand), selectize = TRUE),
                 selectInput(
                   "Drivetype",
                   "Select the DriveType",
                   c("AWD", "RWD", "4WD", "FWD"),
                   selectize = TRUE
                 ),
                 selectInput(
                   "Turbo",
                   "Select the Turbo type",
                   c("None", "Supercharged", "Turbocharged"),
                   selectize = TRUE
                 ),
                 selectInput("Color", "Select the Color", c(Colors), selectize = TRUE),
                 actionButton("submit", "Submit")
    ),
    mainPanel(tabsetPanel(
      type = "tab",
      tabPanel("Brands",h4(textOutput("Not_Car"))),
      tabPanel("Price", h3(textOutput("Car_price"), align = "center")),
      tabPanel("Basic stat",tableOutput("stats")),
      tabPanel("Summary", column(10, offset=0, verbatimTextOutput("sum"))),
      tabPanel("Data",tableOutput("frame")),
      tabPanel("Model",h4(textOutput("models"),align="center"))
    ))
  )
))

