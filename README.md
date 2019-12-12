# RubiksCube
Description:
These are the applications to simulate the Rubiks cube in R. Users can click the buttons or input the text of formula to rotate the visualized cube. Sometimes, running the applications in Rstudio would shut down due to some unknown reason, but they run quite well on shinyapps.io. The method I used to visualized the cube is intuitive. I plot each grid, i.e. 54 patches, so they run quite slowly.

 Note:
 Please run the file "global.R" first. It contains some global variables, packages and functions. In fact, this R code is to build a shiny application, and it contains two, app1 and app2. You can use the function "runApp()" to run one of these applications if you want. I commented "runApp()" here. I upload the application on to shinyapps.io, thus, they can run on the website. The links are below, please see.

 app1: https://katasuke.shinyapps.io/rubiks_cube/ 
 
 app2: https://katasuke.shinyapps.io/rubiks_cube2/
 
 github: https://github.com/Katasuke/RubiksCube
 
 -

 references:
 
 shiny:
 
 https://shiny.rstudio.com/articles/shinyapps.html
 
https://stackoverflow.com/questions/20333399/are-there-global-variables-in-r-shiny

https://stackoverflow.com/questions/44445606/using-a-togglewidget-in-rgl-with-shiny

rgl:

https://www.rdocumentation.org/packages/rgl/versions/0.100.30

https://stackoverflow.com/questions/28384999/plot-3d-orography-of-a-grid

Cube timer:

http://www.cubetimer.com/
