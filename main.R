#####################################################################################
## REcol Final Project
# Author: Ching-Lin Huang (Andy)
# ID: B05201010
##

## Description:
# These are the applications to simulate the Rubiks cube in R. Users can click the buttons or input the text of formula to rotate the visualized cube. Sometimes, running the applications in Rstudio would shut down due to some unknown reason, but they run quite well on shinyapps.io. The method I used to visualized the cube is intuitive. I plot each grid, i.e. 54 patches, so they run quite slowly.
##

## Note:
# Please run the file "global.R" first. It contains some global variables, packages and functions. In fact, this R code is to build a shiny application, and it contains two, app1 and app2. You can use the function "runApp()" to run one of these applications if you want. I commented "runApp()" here. I upload the application on to shinyapps.io, thus, they can run on the website. The links are below, please see.
##

##
# app1: https://katasuke.shinyapps.io/rubiks_cube/
# app2: https://katasuke.shinyapps.io/rubiks_cube2/
##

## references:
# shiny:
# https://shiny.rstudio.com/articles/shinyapps.html
# https://stackoverflow.com/questions/20333399/are-there-global-variables-in-r-shiny
# https://stackoverflow.com/questions/44445606/using-a-togglewidget-in-rgl-with-shiny
# rgl:
# https://www.rdocumentation.org/packages/rgl/versions/0.100.30
# https://stackoverflow.com/questions/28384999/plot-3d-orography-of-a-grid
# Cube timer:
# http://www.cubetimer.com/
##

### The way to upload shiny application to shinyapps.io:
# setwd()
# library(rsconnect)
# rsconnect::setAccountInfo(name="<ACCOUNT>", token="<TOKEN>", secret="<SECRET>")
# deployApp()
###
####################################################################################

# source("global.R")
plotCube(mat) # Plot the cube. Sometimes, the window wouldn't pop out, it is weird. But, it works in shiny.


# app1:
# Users can click the bottons to rotate the cube.
# Please, run "global.R" first

save <- options(rgl.useNULL = TRUE)
mat <- mat_int

app1 = shinyApp(
  # ui
  ui = bootstrapPage(
    # add buttons
    actionButton(label = "R", inputId = "right"),
    actionButton(label = "R'", inputId = "right_c"),
    actionButton(label = "L", inputId = "left"),
    actionButton(label = "L'", inputId = "left_c"),
    actionButton(label = "U", inputId = "up"),
    actionButton(label = "U'", inputId = "up_c"),
    actionButton(label = "D", inputId = "down"),
    actionButton(label = "D'", inputId = "down_c"),
    actionButton(label = "F", inputId = "front"),
    actionButton(label = "F'", inputId = "front_c"),
    actionButton(label = "B", inputId = "back"),
    actionButton(label = "B'", inputId = "back_c"),
    # 3dplot output
    rglwidgetOutput("rglPlot")
  ),
  
  #server
  server = function(input, output, session) {
    # let cube matrix be reactive
    value <- reactiveVal(mat)
    
    # update cube matrix
    observeEvent(input$right, {
      newValue <- right(value())
      value(newValue)
    })
    
    observeEvent(input$right_c, {
      newValue <- right_c(value())
      value(newValue)
    })
    
    observeEvent(input$left, {
      newValue <- left(value())
      value(newValue)
    })
    
    observeEvent(input$left_c, {
      newValue <- left_c(value())
      value(newValue)
    })
    
    observeEvent(input$up, {
      newValue <- up(value())
      value(newValue)
    })
    
    observeEvent(input$up_c, {
      newValue <- up_c(value())
      value(newValue)
    })
    
    observeEvent(input$down, {
      newValue <- down(value())
      value(newValue)
    })
    
    observeEvent(input$down_c, {
      newValue <- down_c(value())
      value(newValue)
    })
    
    observeEvent(input$front, {
      newValue <- front(value())
      value(newValue)
    })
    
    observeEvent(input$front_c, {
      newValue <- front_c(value())
      value(newValue)
    })
    
    observeEvent(input$back, {
      newValue <- back(value())
      value(newValue)
    })
    
    observeEvent(input$back_c, {
      newValue <- back_c(value())
      value(newValue)
    })
    
    # Honestly, I don't know what this part is doing.
    output$rglPlot <- renderRglwidget({
      if (length(rgl.dev.list())) rgl.close()
      plotCube(value())
      par3d(userMatrix = input$par3d$userMatrix)
      rglwidget()
    })
  })
# runApp is the function to run the application in Rstudio
# runApp(app1)

## app2:
# User can input the formula to rotate the cube
# Please, run "global.R" first

app2 = shinyApp(
  ui = bootstrapPage(
    textInput(inputId = "text", label = "Text input", value = ""),  # text input
    actionButton(inputId = "initial", label = "Initial"), # recover the cube
    submitButton("Submit"), # submit button
    rglwidgetOutput("rglPlot")
  ),
  server = function(input, output, session) {
    value <- reactiveVal(mat)
    
    observeEvent(input$text, {
      newValue <- textRotate(text = input$text, mat = value()) # textRotate function
      value(newValue)
    })
    
    observeEvent(input$initial, {
      newValue <- mat_int
      value(newValue)
    })
    
    output$rglPlot <- renderRglwidget({
      if (length(rgl.dev.list())) rgl.close()
      plotCube(value())
      par3d(userMatrix = input$par3d$userMatrix)
      rglwidget()
    })
  })
# runApp is the function to run the application in Rstudio
# runApp(app2)