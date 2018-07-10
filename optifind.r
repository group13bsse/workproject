#load packages
library(EBImage)
library(keras)

#Read Images
setwd('/Users/dell/Desktop/images')
pics<-c('p1.jpg','p2.jpg','p3.jpg','p4.jpg','p5.jpg','p6.jpg',
        'c1.jpg','c2.jpg','c3.jpg','c4.jpg','c5.jpg','c6.jpg')
mypic<-list()
for(i in 1:12){mypic[[i]]<- readImage(pics[i])}

#Explore
print(mypic[[1]])
display(mypic[[1]])
summary(mypic[[1]])
hist(mypic[[12]])
hist(mypic[[2]])
str(mypic)

#Resize
for(i in 1:12){mypic[[i]]<-resize(mypic[[i]], 28, 28)}

#Reshape
for(i in 1:12){mypic[[i]]<-array_reshape(mypic[[i]], c(28,28,3))}

#Row Bind
trainx<-NULL
for(i in 1:5){trainx<- rbind(trainx,mypic[[i]])}
str(trainx)
for(i in 7:11){trainx<- rbind(trainx,mypic[[i]])}
testx<-rbind(mypic[[6]],mypic[[12]])
trainy<-c(0,0,0,0,0,1,1,1,1,1)
testy<-c(0,1)

#One hot Encoding
trainlabels<-to_categorical(trainy)
testlabels<-to_categorical(testy)

#Model
model<-keras_model_sequential()
model %>%
        layer_dense(units=256, activation = 'relu',input_shape = c(2352))%>%
        layer_dense(units=128, activation = 'relu')%>%
        layer_dense(units=2, activation = 'softmax')
summary(model)

install.packages('reticulate')
install.packages('anaconda')
install_keras(method = c("auto", "virtualenv", "conda"), conda = "auto",
              tensorflow = "default", extra_packages = NULL)
install_keras()
install_keras(method = "conda")



