packages <- c("rpart", "rpart.utils","dplyr","readr")
if (length(setdiff(packages, rownames(installed.packages()))) > 0) {
  install.packages(setdiff(packages, rownames(installed.packages())))  
}


library("rpart")
library("rpart.utils")
library("readr")
library("dplyr")

Transactions <- read_csv("D:/Hackathons/Ideathon/Transactions.csv")
Customer <- read_csv("D:/Hackathons/Ideathon/Customer.csv")
Products <- read_csv("D:/Hackathons/Ideathon/Products.csv")

Customer$`City ID`<-NULL
Customer$`Region ID`<-NULL
Customer$`Mobile No`<-NULL
Customer$Email<-NULL

Data<-left_join(Transactions,Customer,by="Customer ID")
Data<-left_join(Data,Products,by="SKU Name")

Data$`Channel ID`<-NULL
Data$`Customer ID`<-NULL
Data$`SKU Name`<-NULL
Data$`SKU ID`<-NULL
Data$`Variant ID`<-NULL
Data$`Product ID`<-NULL
Data$Units<-NULL
Data$Year<-NULL
Data$Day<-NULL
Data$Price<-NULL
Data$`Product Name`<-NULL
Data$`Product ID.x`<-NULL
Data$`Product ID.y`<-NULL
Data$`Variant ID.x`<-NULL
Data$`Variant ID.y`<-NULL
Data$Variant<-Data$Variant.x
Data$Variant.x<-NULL
Data$Variant.y<-NULL
Data<-Data%>%group_by(Month,Channel,Product,Age,Gender,City,State,Region,Variant)%>%summarise(Value=sum(Value))

#


Data1<-filter(Data,Product=="Chilli")



cartchilli <- rpart(Value~ Month+Channel+Age+Gender+City+State+Region+Variant
              ,data=Data1, method="anova" ,control = rpart.control( cp=0.005,maxdepth = 10))

plot(cartchilli)
text(cartchilli)

rpart.lists(cartchilli)
attributes(rpart.lists(cartchilli)[[1]][[1]])

names(attributes(rpart.lists(cartchilli)[[1]][[1]])[[1]])



output<-as.data.frame(matrix( nrow = 0, ncol = 2))
leaf<-which(cartchilli$frame[1]=="<leaf>")
evenlist<-as.numeric(rownames(cartchilli$frame))[which(as.numeric(rownames(cartchilli$frame))%%2==0)]
oddlist<-as.numeric(rownames(cartchilli$frame))[which(as.numeric(rownames(cartchilli$frame))%%2==1)]
l<-1
for(i in leaf){

j<-as.numeric(rownames(cartchilli$frame[i,]))%/%2
k<-as.numeric(rownames(cartchilli$frame[i,]))
text<-""
  repeat{
    if(k%%2==0){
      text<-paste(text,names(attributes(rpart.lists(cartchilli)[[1]][[which(evenlist==k)]])[[1]][1]),attributes(rpart.lists(cartchilli)[[1]][[which(evenlist==k)]])[[1]][1],rpart.lists(cartchilli)[[1]][[which(evenlist==k)]])
    
    }else {
      text<-paste(text,names(attributes(rpart.lists(cartchilli)[[2]][[which(oddlist==k)-1]])[[1]][1]),attributes(rpart.lists(cartchilli)[[1]][[which(oddlist==k)-1]])[[1]][1],rpart.lists(cartchilli)[[1]][[which(oddlist==k)-1]])
      
    }
if(j%/%2 == 0){ 
    break
}
    k<-j
    j<-j%/%2
    }
  output[l,]<-c(do.call(paste,as.list(text)),cartchilli$frame[i,5])
l<-l+1
  }
output$V2<-as.numeric(output$V2)
output<-output%>%arrange(desc(V2))%>%mutate(rank=c(1:nrow(output)),Segment=V1)%>%select(rank,Segment)
write.csv(output,"Chilli.csv")

#


Data1<-filter(Data,Product=="Chana Dal")



cartChanaDal <- rpart(Value~ Month+Channel+Age+Gender+City+State+Region+Variant
                    ,data=Data1, method="anova" ,control = rpart.control( cp=0.005,maxdepth = 10))

plot(cartChanaDal)
text(cartChanaDal)


output<-as.data.frame(matrix(, nrow = 0, ncol = 2))
leaf<-which(cartChanaDal$frame[1]=="<leaf>")
evenlist<-as.numeric(rownames(cartChanaDal$frame))[which(as.numeric(rownames(cartChanaDal$frame))%%2==0)]
oddlist<-as.numeric(rownames(cartChanaDal$frame))[which(as.numeric(rownames(cartChanaDal$frame))%%2==1)]
l<-1
for(i in leaf){
  
  j<-as.numeric(rownames(cartChanaDal$frame[i,]))%/%2
  k<-as.numeric(rownames(cartChanaDal$frame[i,]))
  text<-""
  repeat{
    if(k%%2==0){
      text<-paste(text,names(attributes(rpart.lists(cartChanaDal)[[1]][[which(evenlist==k)]])[[1]][1]),attributes(rpart.lists(cartChanaDal)[[1]][[which(evenlist==k)]])[[1]][1],rpart.lists(cartChanaDal)[[1]][[which(evenlist==k)]])
      
    }else {
      text<-paste(text,names(attributes(rpart.lists(cartChanaDal)[[2]][[which(oddlist==k)-1]])[[1]][1]),attributes(rpart.lists(cartChanaDal)[[1]][[which(oddlist==k)-1]])[[1]][1],rpart.lists(cartChanaDal)[[1]][[which(oddlist==k)-1]])
      
    }
    if(j%/%2 == 0){ 
      break
    }
    k<-j
    j<-j%/%2
  }
  output[l,]<-c(do.call(paste,as.list(text)),cartChanaDal$frame[i,5])
  l<-l+1
}

output$V2<-as.numeric(output$V2)
output<-output%>%arrange(desc(V2))%>%mutate(rank=c(1:nrow(output)),Segment=V1)%>%select(rank,Segment)
write.csv(output,"ChanaDal.csv")


#


Data1<-filter(Data,Product=="Garam Masala")



cartGaramMasala <- rpart(Value~ Month+Channel+Age+Gender+City+State+Region+Variant
                      ,data=Data1, method="anova" ,control = rpart.control( cp=0.005,maxdepth = 10))

plot(cartGaramMasala)
text(cartGaramMasala)


output<-as.data.frame(matrix(, nrow = 0, ncol = 2))
leaf<-which(cartGaramMasala$frame[1]=="<leaf>")
evenlist<-as.numeric(rownames(cartGaramMasala$frame))[which(as.numeric(rownames(cartGaramMasala$frame))%%2==0)]
oddlist<-as.numeric(rownames(cartGaramMasala$frame))[which(as.numeric(rownames(cartGaramMasala$frame))%%2==1)]
l<-1
for(i in leaf){
  
  j<-as.numeric(rownames(cartGaramMasala$frame[i,]))%/%2
  k<-as.numeric(rownames(cartGaramMasala$frame[i,]))
  text<-""
  repeat{
    if(k%%2==0){
      text<-paste(text,names(attributes(rpart.lists(cartGaramMasala)[[1]][[which(evenlist==k)]])[[1]][1]),attributes(rpart.lists(cartGaramMasala)[[1]][[which(evenlist==k)]])[[1]][1],rpart.lists(cartGaramMasala)[[1]][[which(evenlist==k)]])
      
    }else {
      text<-paste(text,names(attributes(rpart.lists(cartGaramMasala)[[2]][[which(oddlist==k)-1]])[[1]][1]),attributes(rpart.lists(cartGaramMasala)[[1]][[which(oddlist==k)-1]])[[1]][1],rpart.lists(cartGaramMasala)[[1]][[which(oddlist==k)-1]])
      
    }
    if(j%/%2 == 0){ 
      break
    }
    k<-j
    j<-j%/%2
  }
  output[l,]<-c(do.call(paste,as.list(text)),cartGaramMasala$frame[i,5])
  l<-l+1
}

output$V2<-as.numeric(output$V2)
output<-output%>%arrange(desc(V2))%>%mutate(rank=c(1:nrow(output)),Segment=V1)%>%select(rank,Segment)
write.csv(output,"GaramMasala.csv")

#


Data1<-filter(Data,Product=="Besan")



cartBesan <- rpart(Value~ Month+Channel+Age+Gender+City+State+Region+Variant
                         ,data=Data1, method="anova" ,control = rpart.control( cp=0.005,maxdepth = 10))

plot(cartBesan)
text(cartBesan)


output<-as.data.frame(matrix(, nrow = 0, ncol = 2))
leaf<-which(cartBesan$frame[1]=="<leaf>")
evenlist<-as.numeric(rownames(cartBesan$frame))[which(as.numeric(rownames(cartBesan$frame))%%2==0)]
oddlist<-as.numeric(rownames(cartBesan$frame))[which(as.numeric(rownames(cartBesan$frame))%%2==1)]
l<-1
for(i in leaf){
  
  j<-as.numeric(rownames(cartBesan$frame[i,]))%/%2
  k<-as.numeric(rownames(cartBesan$frame[i,]))
  text<-""
  repeat{
    if(k%%2==0){
      text<-paste(text,names(attributes(rpart.lists(cartBesan)[[1]][[which(evenlist==k)]])[[1]][1]),attributes(rpart.lists(cartBesan)[[1]][[which(evenlist==k)]])[[1]][1],rpart.lists(cartBesan)[[1]][[which(evenlist==k)]])
      
    }else {
      text<-paste(text,names(attributes(rpart.lists(cartBesan)[[2]][[which(oddlist==k)-1]])[[1]][1]),attributes(rpart.lists(cartBesan)[[1]][[which(oddlist==k)-1]])[[1]][1],rpart.lists(cartBesan)[[1]][[which(oddlist==k)-1]])
      
    }
    if(j%/%2 == 0){ 
      break
    }
    k<-j
    j<-j%/%2
  }
  output[l,]<-c(do.call(paste,as.list(text)),cartBesan$frame[i,5])
  l<-l+1
}

output$V2<-as.numeric(output$V2)
output<-output%>%arrange(desc(V2))%>%mutate(rank=c(1:nrow(output)),Segment=V1)%>%select(rank,Segment)
write.csv(output,"Besan.csv")

#


Data1<-filter(Data,Product=="Coriander")



cartCoriander <- rpart(Value~ Month+Channel+Age+Gender+City+State+Region+Variant
                   ,data=Data1, method="anova" ,control = rpart.control( cp=0.005,maxdepth = 10))

plot(cartCoriander)
text(cartCoriander)


output<-as.data.frame(matrix( nrow = 0, ncol = 2))
leaf<-which(cartCoriander$frame[1]=="<leaf>")
evenlist<-as.numeric(rownames(cartCoriander$frame))[which(as.numeric(rownames(cartCoriander$frame))%%2==0)]
oddlist<-as.numeric(rownames(cartCoriander$frame))[which(as.numeric(rownames(cartCoriander$frame))%%2==1)]
l<-1
for(i in leaf){
  
  j<-as.numeric(rownames(cartCoriander$frame[i,]))%/%2
  k<-as.numeric(rownames(cartCoriander$frame[i,]))
  text<-""
  repeat{
    if(k%%2==0){
      text<-paste(text,names(attributes(rpart.lists(cartCoriander)[[1]][[which(evenlist==k)]])[[1]][1]),attributes(rpart.lists(cartCoriander)[[1]][[which(evenlist==k)]])[[1]][1],rpart.lists(cartCoriander)[[1]][[which(evenlist==k)]])
      
    }else {
      text<-paste(text,names(attributes(rpart.lists(cartCoriander)[[2]][[which(oddlist==k)-1]])[[1]][1]),attributes(rpart.lists(cartCoriander)[[1]][[which(oddlist==k)-1]])[[1]][1],rpart.lists(cartCoriander)[[1]][[which(oddlist==k)-1]])
      
    }
    if(j%/%2 == 0){ 
      break
    }
    k<-j
    j<-j%/%2
  }
  output[l,]<-c(do.call(paste,as.list(text)),cartCoriander$frame[i,5])
  l<-l+1
}

output$V2<-as.numeric(output$V2)
output<-output%>%arrange(desc(V2))%>%mutate(rank=c(1:nrow(output)),Segment=V1)%>%select(rank,Segment)
write.csv(output,"Coriander.csv")

#



Data1<-filter(Data,Product=="Toor Dal")



cartToorDal <- rpart(Value~ Month+Channel+Age+Gender+City+State+Region+Variant
                       ,data=Data1, method="anova" ,control = rpart.control( cp=0.005,maxdepth = 10))

plot(cartToorDal)
text(cartToorDal)


output<-as.data.frame(matrix( nrow = 0, ncol = 2))
leaf<-which(cartToorDal$frame[1]=="<leaf>")
evenlist<-as.numeric(rownames(cartToorDal$frame))[which(as.numeric(rownames(cartToorDal$frame))%%2==0)]
oddlist<-as.numeric(rownames(cartToorDal$frame))[which(as.numeric(rownames(cartToorDal$frame))%%2==1)]
l<-1
for(i in leaf){
  
  j<-as.numeric(rownames(cartToorDal$frame[i,]))%/%2
  k<-as.numeric(rownames(cartToorDal$frame[i,]))
  text<-""
  repeat{
    if(k%%2==0){
      text<-paste(text,names(attributes(rpart.lists(cartToorDal)[[1]][[which(evenlist==k)]])[[1]][1]),attributes(rpart.lists(cartToorDal)[[1]][[which(evenlist==k)]])[[1]][1],rpart.lists(cartToorDal)[[1]][[which(evenlist==k)]])
      
    }else {
      text<-paste(text,names(attributes(rpart.lists(cartToorDal)[[2]][[which(oddlist==k)-1]])[[1]][1]),attributes(rpart.lists(cartToorDal)[[1]][[which(oddlist==k)-1]])[[1]][1],rpart.lists(cartToorDal)[[1]][[which(oddlist==k)-1]])
      
    }
    if(j%/%2 == 0){ 
      break
    }
    k<-j
    j<-j%/%2
  }
  output[l,]<-c(do.call(paste,as.list(text)),cartToorDal$frame[i,5])
  l<-l+1
}

output$V2<-as.numeric(output$V2)
output<-output%>%arrange(desc(V2))%>%mutate(rank=c(1:nrow(output)),Segment=V1)%>%select(rank,Segment)
write.csv(output,"ToorDal.csv")

#



Data1<-filter(Data,Product=="Turmeric")



cartTurmeric <- rpart(Value~ Month+Channel+Age+Gender+City+State+Region+Variant
                     ,data=Data1, method="anova" ,control = rpart.control( cp=0.005,maxdepth = 10))

plot(cartTurmeric)
text(cartTurmeric)


output<-as.data.frame(matrix(, nrow = 0, ncol = 2))
leaf<-which(cartTurmeric$frame[1]=="<leaf>")
evenlist<-as.numeric(rownames(cartTurmeric$frame))[which(as.numeric(rownames(cartTurmeric$frame))%%2==0)]
oddlist<-as.numeric(rownames(cartTurmeric$frame))[which(as.numeric(rownames(cartTurmeric$frame))%%2==1)]
l<-1
for(i in leaf){
  
  j<-as.numeric(rownames(cartTurmeric$frame[i,]))%/%2
  k<-as.numeric(rownames(cartTurmeric$frame[i,]))
  text<-""
  repeat{
    if(k%%2==0){
      text<-paste(text,names(attributes(rpart.lists(cartTurmeric)[[1]][[which(evenlist==k)]])[[1]][1]),attributes(rpart.lists(cartTurmeric)[[1]][[which(evenlist==k)]])[[1]][1],rpart.lists(cartTurmeric)[[1]][[which(evenlist==k)]])
      
    }else {
      text<-paste(text,names(attributes(rpart.lists(cartTurmeric)[[2]][[which(oddlist==k)-1]])[[1]][1]),attributes(rpart.lists(cartTurmeric)[[1]][[which(oddlist==k)-1]])[[1]][1],rpart.lists(cartTurmeric)[[1]][[which(oddlist==k)-1]])
      
    }
    if(j%/%2 == 0){ 
      break
    }
    k<-j
    j<-j%/%2
  }
  output[l,]<-c(do.call(paste,as.list(text)),cartTurmeric$frame[i,5])
  l<-l+1
}

output$V2<-as.numeric(output$V2)
output<-output%>%arrange(desc(V2))%>%mutate(rank=c(1:nrow(output)),Segment=V1)%>%select(rank,Segment)
write.csv(output,"Turmeric.csv")

#



Data1<-filter(Data,Product=="Urad Dal")



cartUradDal <- rpart(Value~ Month+Channel+Age+Gender+City+State+Region+Variant
                      ,data=Data1, method="anova" ,control = rpart.control( cp=0.005,maxdepth = 10))

plot(cartUradDal)
text(cartUradDal)


output<-as.data.frame(matrix(, nrow = 0, ncol = 2))
leaf<-which(cartUradDal$frame[1]=="<leaf>")
evenlist<-as.numeric(rownames(cartUradDal$frame))[which(as.numeric(rownames(cartUradDal$frame))%%2==0)]
oddlist<-as.numeric(rownames(cartUradDal$frame))[which(as.numeric(rownames(cartUradDal$frame))%%2==1)]
l<-1
for(i in leaf){
  
  j<-as.numeric(rownames(cartUradDal$frame[i,]))%/%2
  k<-as.numeric(rownames(cartUradDal$frame[i,]))
  text<-""
  repeat{
    if(k%%2==0){
      text<-paste(text,names(attributes(rpart.lists(cartUradDal)[[1]][[which(evenlist==k)]])[[1]][1]),attributes(rpart.lists(cartUradDal)[[1]][[which(evenlist==k)]])[[1]][1],rpart.lists(cartUradDal)[[1]][[which(evenlist==k)]])
      
    }else {
      text<-paste(text,names(attributes(rpart.lists(cartUradDal)[[2]][[which(oddlist==k)-1]])[[1]][1]),attributes(rpart.lists(cartUradDal)[[1]][[which(oddlist==k)-1]])[[1]][1],rpart.lists(cartUradDal)[[1]][[which(oddlist==k)-1]])
      
    }
    if(j%/%2 == 0){ 
      break
    }
    k<-j
    j<-j%/%2
  }
  output[l,]<-c(do.call(paste,as.list(text)),cartUradDal$frame[i,5])
  l<-l+1
}

output$V2<-as.numeric(output$V2)
output<-output%>%arrange(desc(V2))%>%mutate(rank=c(1:nrow(output)),Segment=V1)%>%select(rank,Segment)
write.csv(output,"UradDal.csv")


#


Data1<-filter(Data,Product=="Moong Dala")



cartMoongDal <- rpart(Value~ Month+Channel+Age+Gender+City+State+Region+Variant
                     ,data=Data1, method="anova" ,control = rpart.control( cp=0.005,maxdepth = 10))

plot(cartMoongDal)
text(cartMoongDal)


output<-as.data.frame(matrix(, nrow = 0, ncol = 2))
leaf<-which(cartMoongDal$frame[1]=="<leaf>")
evenlist<-as.numeric(rownames(cartMoongDal$frame))[which(as.numeric(rownames(cartMoongDal$frame))%%2==0)]
oddlist<-as.numeric(rownames(cartMoongDal$frame))[which(as.numeric(rownames(cartMoongDal$frame))%%2==1)]
l<-1
for(i in leaf){
  
  j<-as.numeric(rownames(cartMoongDal$frame[i,]))%/%2
  k<-as.numeric(rownames(cartMoongDal$frame[i,]))
  text<-""
  repeat{
    if(k%%2==0){
      text<-paste(text,names(attributes(rpart.lists(cartMoongDal)[[1]][[which(evenlist==k)]])[[1]][1]),attributes(rpart.lists(cartMoongDal)[[1]][[which(evenlist==k)]])[[1]][1],rpart.lists(cartMoongDal)[[1]][[which(evenlist==k)]])
      
    }else {
      text<-paste(text,names(attributes(rpart.lists(cartMoongDal)[[2]][[which(oddlist==k)-1]])[[1]][1]),attributes(rpart.lists(cartMoongDal)[[1]][[which(oddlist==k)-1]])[[1]][1],rpart.lists(cartMoongDal)[[1]][[which(oddlist==k)-1]])
      
    }
    if(j%/%2 == 0){ 
      break
    }
    k<-j
    j<-j%/%2
  }
  output[l,]<-c(do.call(paste,as.list(text)),cartMoongDal$frame[i,5])
  l<-l+1
}

output$V2<-as.numeric(output$V2)
output<-output%>%arrange(desc(V2))%>%mutate(rank=c(1:nrow(output)),Segment=V1)%>%select(rank,Segment)
write.csv(output,"MoongDal.csv")

#


Data1<-filter(Data,Product=="Dal Masoor")



cartMasoor <- rpart(Value~ Month+Channel+Age+Gender+City+State+Region+Variant
                      ,data=Data1, method="anova" ,control = rpart.control( cp=0.005,maxdepth = 10))

plot(cartMasoor)
text(cartMasoor)


output<-as.data.frame(matrix(, nrow = 0, ncol = 2))
leaf<-which(cartMasoor$frame[1]=="<leaf>")
evenlist<-as.numeric(rownames(cartMasoor$frame))[which(as.numeric(rownames(cartMasoor$frame))%%2==0)]
oddlist<-as.numeric(rownames(cartMasoor$frame))[which(as.numeric(rownames(cartMasoor$frame))%%2==1)]
l<-1
for(i in leaf){
  
  j<-as.numeric(rownames(cartMasoor$frame[i,]))%/%2
  k<-as.numeric(rownames(cartMasoor$frame[i,]))
  text<-""
  repeat{
    if(k%%2==0){
      text<-paste(text,names(attributes(rpart.lists(cartMasoor)[[1]][[which(evenlist==k)]])[[1]][1]),attributes(rpart.lists(cartMasoor)[[1]][[which(evenlist==k)]])[[1]][1],rpart.lists(cartMasoor)[[1]][[which(evenlist==k)]])
      
    }else {
      text<-paste(text,names(attributes(rpart.lists(cartMasoor)[[2]][[which(oddlist==k)-1]])[[1]][1]),attributes(rpart.lists(cartMasoor)[[1]][[which(oddlist==k)-1]])[[1]][1],rpart.lists(cartMasoor)[[1]][[which(oddlist==k)-1]])
      
    }
    if(j%/%2 == 0){ 
      break
    }
    k<-j
    j<-j%/%2
  }
  output[l,]<-c(do.call(paste,as.list(text)),cartMasoor$frame[i,5])
  l<-l+1
}

output$V2<-as.numeric(output$V2)
output<-output%>%arrange(desc(V2))%>%mutate(rank=c(1:nrow(output)),Segment=V1)%>%select(rank,Segment)
write.csv(output,"Masoor.csv")

unique(Data$Product)


