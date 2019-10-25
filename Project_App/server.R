# This is a shiny app to determine diamond price based on carat, cut, color, and clarity

library(shiny)
library(ggplot2)



# Define server logic
shinyServer(function(input, output) {
  
  # Load data
  data("diamonds")
  
  # Subsetting data based on the user's input
  diamonds_sub <- reactive({
    subset(diamonds, cut == input$cut &
          color == input$color &
          clarity == input$clarity)
  })
  
  # Fitting a linear model 
  fit <- reactive({
    lm(price~carat,data=diamonds_sub())
  }) 
  
  # predicting the price of diamond based on caret input given by user for given set of cut, color and clarity
  prediction <- reactive({
    caretinp <- input$Carat
    predict(fit(),newdata=data.frame(carat = caretinp))
  })
  
  # Plotting the data 
  
  output$Plot <- renderPlot({
    # plot the diamond data with carat and price
    g <- ggplot(data = diamonds_sub(), aes(x = carat, y = price)) + geom_point()
    g <- g + geom_smooth(method = "lm") + xlab("Carat") + ylab("Price")
    g <- g + xlim(0, 6) + ylim (0, 20000)
    g
  })
  
  output$predict <- renderText({
    prediction()
  })
  
  })
  