#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(data.table)
library(randomForest)
library(shinythemes)
library(kableExtra)

model <- readRDS("model.rds")

# Define UI for application that draws a histogram
shinyUI(fluidPage(theme = shinytheme("journal"),

    # Application title
    titlePanel("Diabetes Predictor"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            numericInput("Pregnancies",
                        "Number of Pregnancies",
                        value = 0),
       
           numericInput("Glucose",
                     "Glucose(mg/dL)",
                     value = 80),
     
            numericInput("BloodPressure",
                 "Blood Pressure(mmHg)",
                 value = 80),
           numericInput("SkinThickness",
                        "Skin Thickness(mm)",
                        value = 20),
           numericInput("Insulin",
                        "Insulin Level(IU/mL)",
                        value = 80),
           numericInput("BMI",
                        "Body Mass Index(kg/m2)",
                        value =23.3 ),
           numericInput("DPF",
                        "Diabetes Pedigree Function",
                        value = 0.51),
           numericInput("Age",
                        "Age(years)",
                        value = 30),
           actionButton("submitbutton", "Submit", 
                        class = "btn btn-primary")
        ),

  
    
    
        # Show a plot of the generated distribution
        mainPanel(
            tags$label(h1('Prediction')),
            verbatimTextOutput('contents'),
            h3(textOutput('out'))
        )
    )
))
