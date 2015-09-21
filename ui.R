library(shiny)

shinyUI(fluidPage(

  # Application title
  titlePanel("Guess the slope"),
  p('This is a game where you have to guess the slope of the line where the total distances to the 
        points are the least. Use the slider on the left to adjust the red line, and click Submit
    if you think it is the best fit. You can then click Retry to have a new puzzle. You can also track your
    statistics at the bottom (correct / total). Have fun!'),
  br(''),
  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
      sliderInput("guess",
                  "Guess",
                  min = .2,
                  max = 2.5,
                  value = 1,
                  step = .1),
      htmlOutput("submitButton"),
      textOutput('result')
    ),

    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("distPlot"),
      p('Your statistics:'),
      textOutput('correct', inline = TRUE),
      span('/'),
      textOutput('total', inline = TRUE)
    )
  )
))
