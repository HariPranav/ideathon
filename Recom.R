library("recommenderlab")
library("reshape2")
library("data.table")

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



Data<-Data%>%group_by(`Customer ID`,Product)%>%summarise(Value=sum(Value))

Data1<-Data %>%group_by(`Customer ID`) %>%mutate(rank = order(order(Value, Product, decreasing=TRUE)))
output<-Data1%>%filter(rank==1)%>%select(`Customer ID`,Product)
output<-Data1%>%filter(rank==2)%>%select(`Customer ID`,Product)%>%right_join(output,by="Customer ID")
output$V1<-output$Product.x
output$V2<-output$Product.y
output$Product.x<-NULL
output$Product.y<-NULL
output<-Data1%>%filter(rank==3)%>%select(`Customer ID`,Product)%>%right_join(output,by="Customer ID")
output$V3<-output$Product
output$Product<-NULL

output$`Customer ID`<-as.character(output$`Customer ID`)

Data$rating<-1
      
g<-acast(Data, `Customer ID`~Product,value.var = "rating")
      
      R <- as.matrix(g)
      
      r <- as(R, "realRatingMatrix")
      
      r_m <- normalize(r)
      
      rec=HybridRecommender(Recommender(r, method = "UBCF"),Recommender(r, method = "POPULAR"),weights=c(.4,.6))
      
      recom1 <- predict(rec, r, type="topNList", n=15)
      
      recom1<-as(recom1, "list")
      
      
      result_cs1<-as.data.frame(do.call(rbind,recom1))
      

result_cs1$`Customer ID`<-setdiff(rownames(g),rownames(g)[which(sapply(recom1,function(x) identical(x,character(0))))])

result_cs1$V3<-NULL
result_cs1$V4<-result_cs1$V1
result_cs1$V5<-result_cs1$V2
result_cs1$V2<-NULL
result_cs1$V1<-NULL

output<-left_join(output,result_cs1,by="Customer ID")
write.csv(output,"Recom.csv")
      