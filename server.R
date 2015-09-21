
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

shinyServer(function(input, output) {
  
  total <- 0
  correct <- 0
  
  num <- 100
  solution <- 0
  
  data <- 0
  
  reset <- function(){
    solution <<- round(runif(1, .5, 2), digits = 1)
    
    data <<- data.frame(x = runif(num, 0, 50))
    
    data$y <<- lapply(data$x, function(x) {
      x * solution + rnorm(1, sd = 10)
    })
    
    output$guess <- renderText({input$guess})
    output$solution <- renderText({solution})
    output$result <- renderText({""})
    output$correct <- renderText({correct})
    output$total <- renderText({total})
    output$submitButton <- renderUI({
      list(
        actionButton("submit", "Submit guess"),
        actionButton("retry", "Retry")
      )
    })
    
    output$distPlot <- renderPlot({
      plot(data$x, data$y, pch = 19, xlab = "x", ylab = "y")
      lines(c(0, 50), c(0, 50 * input$guess), col = "red")
    })
  }
  
  reset()
  
  observeEvent(input$submit, {
    output$solution <- renderText({solution})
    total <<- total + 1
    if(input$guess == solution) {
      correct <<- correct + 1
      output$result = renderText({"Perfect!"})
    } else {
      output$result = renderText({"Not exactly"})
    }
    
    output$correct <- renderText({correct})
    output$total <- renderText({total})
    
    output$submitButton <- renderUI({
      list(
        actionButton("submit", "Submit guess", disabled=TRUE),
        actionButton("retry", "Next game")
      )
    })
  })
  
  observeEvent(input$retry, {
    reset()
  })

})
