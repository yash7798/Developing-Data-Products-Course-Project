# This is the user interface for the shiny app to determine diamond price based on 
# factors such as carat, cut, color, and clarity a Shiny web application. One can decide the 
# price of diamond for a varying range of carat based on set of carat, cut and color.

library(shiny)
library(ggplot2)

# load data
data("diamonds")

# Define UI for the application
shinyUI(fluidPage
        (titlePanel("Diamonds - Cost based on Carat, Cut, Color, and Clarity"),
          sidebarLayout(
            sidebarPanel(h4("Choose Diamond Factors"),
                         selectInput("cut", "Cut", (sort(unique(diamonds$cut), decreasing = T))),
                         selectInput("color", "Color", (sort(unique(diamonds$color)))),
                         selectInput("clarity", "Clarity", (sort(unique(diamonds$clarity), decreasing = T))),
                         sliderInput("Carat","Give the Caret Value here !",min = min(diamonds$carat), 
                                     max = max(diamonds$carat),
                                     value = (max(diamonds$carat)) / 2, step = 0.1)),
                                
                        # Show a plot of the carat/price relationship
                        mainPanel("Price ~ Carat Relationship",
                                  plotOutput("Plot"),
                                  h4("Predicted Price for the Diamond based on the chosen factors and carat value: "), 
                                  verbatimTextOutput("predict")
                  ))
          ))