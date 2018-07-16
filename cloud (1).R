# Libraries
library(tidyverse)
library(leaflet)
# devtools::install_github("flovv/RoogleVision)
library(RoogleVision)
library(jsonlite)
# source("http://bioconductor.org/biocLite.R")
# biocLite("EBImage")
library(EBImage)

# Google Cloud
c <- fromJSON(file.choose())
options("googleAuthR.client_id" = c$installed$client_id)
options("googleAuthR.client_secret" = c$installed$client_secret)
options("googleAuthR.scopes.selected" =
                 c("https://www.googleapis.com/auth/cloud-platform"))
googleAuthR::gar_auth()

# Lable Detection
pic <- readImage(file.choose())
plot(pic)
p <- getGoogleVisionResponse(file.choose(),
                             feature = "LABEL_DETECTION")

# Landmark Detection
pic <- readImage(file.choose())
plot(pic)
p <- getGoogleVisionResponse(file.choose(),
                             feature = "LANDMARK_DETECTION")
for(i in 1:length(p$boundingPoly$vertices)){
         a = p$boundingPoly$vertices[[i]]$x
         b = p$boundingPoly$vertices[[i]]$y
         polygon(x=a, y=b, border = "green", lwd=20)}

# Map
la <- p$locations[[1]][[1]][[1]]
lo <- p$locations[[1]][[1]][[2]]
map <- leaflet() %>%
         addProviderTiles(providers$CartoDB.Positron) %>%
         setView(lng = lo, lat = la, zoom = 30) %>%
         addMarkers(lng = lo, lat = la)
map

# Face Detection
pic <- readImage(file.choose())
plot(pic)
p <- getGoogleVisionResponse(file.choose(),
                             feature = "FACE_DETECTION")
for(i in 1:length(p$boundingPoly$vertices)){
         a = p$boundingPoly$vertices[[i]]$x
         b = p$boundingPoly$vertices[[i]]$y
         polygon(x=a, y=b, border = "green", lwd=5)}
a <- p$landmarks[[1]][[2]][[1]]
b <- p$landmarks[[1]][[2]][[2]]
points(x=a, y=b, lwd = 2, col = "red")

# Logo Detection
pic <- readImage(file.choose())
plot(pic)
p <- getGoogleVisionResponse(file.choose(),
                             feature = "LOGO_DETECTION")
a <- p$boundingPoly$vertices[[1]][[1]]
b <- p$boundingPoly$vertices[[1]][[2]]
polygon(x=a, y=b, border="green", lwd=20)

# Text Detection
pic <- readImage(file.choose())
plot(pic)
p <- getGoogleVisionResponse(file.choose(),
                             feature = "TEXT_DETECTION")
for(i in 1:length(p$boundingPoly$vertices)){
         a = p$boundingPoly$vertices[[i]]$x
         b = p$boundingPoly$vertices[[i]]$y
         polygon(x=a, y=b, border = "red", lwd=5)}
