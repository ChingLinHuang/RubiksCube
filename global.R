### global.R
### collecting the global variables, packages and functions using in shiny

library(rgl)
library(shiny)


## Create a 5x5 matrix
mat_int <- array(dim = c(5,5,5)) # 5x5x5 matrix
initialCube <- read.delim("https://raw.githubusercontent.com/Katasuke/RubiksCube/master/initialCube.txt")
mat_int[ , ,1] <- matrix(initialCube$L1, nrow = 5, ncol = 5)
mat_int[ , ,2] <- matrix(initialCube$L2, nrow = 5, ncol = 5)
mat_int[ , ,3] <- matrix(initialCube$L3, nrow = 5, ncol = 5)
mat_int[ , ,4] <- matrix(initialCube$L4, nrow = 5, ncol = 5)
mat_int[ , ,5] <- matrix(initialCube$L5, nrow = 5, ncol = 5)

## Function to plot the cube
plotCube <- function(mat)
{
  plot3d(c(0,0,0), axes = FALSE)
  #decorate3d(axes = FALSE)
  Col <- c('yellow','green','red','blue','orange','white')
  position <- matrix(nrow = 4, ncol = 3)
  ind1 <- c(-6,-6,-2,-2)
  ind2 <- c(-6,-2,-2,-6)
  ind3 <- rep(-6,4)
  for(i in c(0,1,2)){
    for(j in c(0,1,2)){
      for(k in c(1,-1)){
        # (x,y,z) <- c(ind1+i*4, ind2+j*4, ind3*k)
        position[] <- c(ind1+i*4, ind2+j*4, ind3*k)
        rgl.lines(position, col = 'black') # plot boundary of each square
        rgl.lines(position[ ,c(2,1,3)], col = 'black')
        rgl.quads(position, col = Col[mat[i+2,j+2,-2*k+3]]) # mat[2~4,2~4,1or5]
        # (x,z,y) <- c(ind1+i*4, ind2+j*4, ind3*k)
        position[] <- c(ind1+i*4, ind3*k, ind2+j*4)
        rgl.lines(position, col = 'black')
        rgl.lines(position[ ,c(3,2,1)], col = 'black')
        rgl.quads(position, col = Col[mat[i+2,-2*k+3,j+2]]) # mat[2~4,1or5,2~4]
        # (z,y,x) <- c(ind1+i*4, ind2+j*4, ind3*k)
        position[] <- c(ind3*k, ind1+i*4, ind2+j*4)
        rgl.lines(position, col = 'black')
        rgl.lines(position[ ,c(1,3,2)], col = 'black')
        rgl.quads(position, col = Col[mat[-2*k+3,i+2,j+2]]) # mat[1or5,2~4,2~4]
      }
    }
  }
  # for finish
}
# Rotation function

# basic rotation function, to rotate 2d matrix
# clockwise
rotate <- function(m){ 
  m <- t(apply(m, MARGIN = 2, FUN = rev))
  return(m)
}
# counter-clockwise
rotate_c <- function(m){
  m <- apply(t(m), MARGIN = 2, FUN = rev)
  return(m)
}

# right
right <- function(mat){
  mat[4, , ] <- rotate(mat[4, , ]) 
  mat[5, , ] <- rotate(mat[5, , ]) 
  return(mat)
}

right_c <- function(mat){
  mat[4, , ] <- rotate_c(mat[4, , ]) 
  mat[5, , ] <- rotate_c(mat[5, , ]) 
  return(mat)
}

# left
left <- function(mat){
  mat[2, , ] <- rotate_c(mat[2, , ]) 
  mat[1, , ] <- rotate_c(mat[1, , ]) 
  return(mat)
}

left_c <- function(mat){
  mat[2, , ] <- rotate(mat[2, , ]) 
  mat[1, , ] <- rotate(mat[1, , ]) 
  return(mat)
}

# up
up <- function(mat){
  mat[ , ,4] <- rotate(mat[ , ,4]) 
  mat[ , ,5] <- rotate(mat[ , ,5]) 
  return(mat)
}

up_c <- function(mat){
  mat[ , ,4] <- rotate_c(mat[ , ,4]) 
  mat[ , ,5] <- rotate_c(mat[ , ,5]) 
  return(mat)
}

# down
down <- function(mat){
  mat[ , ,2] <- rotate_c(mat[ , ,2]) 
  mat[ , ,1] <- rotate_c(mat[ , ,1]) 
  return(mat)
}

down_c <- function(mat){
  mat[ , ,2] <- rotate(mat[ , ,2]) 
  mat[ , ,1] <- rotate(mat[ , ,1]) 
  return(mat)
}

# front
front <- function(mat){
  mat[ ,1, ] <- rotate(mat[ ,1, ]) 
  mat[ ,2, ] <- rotate(mat[ ,2, ]) 
  return(mat)
}

front_c <- function(mat){
  mat[ ,1, ] <- rotate_c(mat[ ,1, ]) 
  mat[ ,2, ] <- rotate_c(mat[ ,2, ]) 
  return(mat)
}

# back
back <- function(mat){
  mat[ ,4, ] <- rotate_c(mat[ ,4, ]) 
  mat[ ,5, ] <- rotate_c(mat[ ,5, ]) 
  return(mat)
}

back_c <- function(mat){
  mat[ ,4, ] <- rotate(mat[ ,4, ]) 
  mat[ ,5, ] <- rotate(mat[ ,5, ]) 
  return(mat)
}

# Create a 5x5 matrix
mat_int <- array(dim = c(5,5,5))
initialCube <- read.delim("https://raw.githubusercontent.com/Katasuke/RubiksCube/master/initialCube.txt")
mat_int[ , ,1] <- matrix(initialCube$L1, nrow = 5, ncol = 5)
mat_int[ , ,2] <- matrix(initialCube$L2, nrow = 5, ncol = 5)
mat_int[ , ,3] <- matrix(initialCube$L3, nrow = 5, ncol = 5)
mat_int[ , ,4] <- matrix(initialCube$L4, nrow = 5, ncol = 5)
mat_int[ , ,5] <- matrix(initialCube$L5, nrow = 5, ncol = 5)
# plotCube(mat_int)


# function text2fun
# text <- "R  R'  L  L'  U  U'  D  D'  F  F'  B  B'  R2  L2  U2  D2  F2  B2"
textRotate <- function(text = text, mat = mat){
  text <- gsub("R2", "right  right", text) %>%
    gsub("L2", "left  left", .) %>% 
    gsub("U2", "up  up", .) %>% 
    gsub("D2", "down  down", .) %>% 
    gsub("F2", "front  front", .) %>% 
    gsub("B2", "back  back", .) %>% 
    gsub("R", "right", .) %>% 
    gsub("L", "left", .) %>% 
    gsub("U", "up", .) %>% 
    gsub("D", "down", .) %>% 
    gsub("F", "front", .) %>% 
    gsub("B", "back", .) %>% 
    gsub("'", "_c", .) %>%
    strsplit(split = "  ")
  text <- text[[1]]
  if(length(text) > 0){
    for (i in 1:length(text)) {
      mat <- get(text[i])(mat)
    }
  }
  return(mat)
}


# shiny

save <- options(rgl.useNULL = TRUE)

mat <- mat_int