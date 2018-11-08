#Setting working directory
setwd("C:/Users/fatih.dereli/Desktop/fatih/Personal/YL/IE7027 Financial Analysis")

#install.packages("coinmarketcapr")

#Calling libraries
library("coinmarketcapr")
library("data.table")
library("dplyr")

#Creating function
get_marketcap_ticker_all_full <-function (currency = "USD") 
{
  #stopifnot(currency %in% currencies_list)
  data.frame(jsonlite::fromJSON(RCurl::getURL(paste0("https://api.coinmarketcap.com/v1/ticker/?limit=10000&convert=", 
                                                     currency))))
}

#Coin list from CoinMarketCap
prices<-get_marketcap_ticker_all_full()


#CryptoCompare Price History Loop

coinlist<-unique(prices$symbol)

fulldata<-data.table(NULL)

ObservationQuantity<-500

for(i in 1:200)
{
  tryCatch({
    coin<-prices$symbol[i]
    
    data<-data.frame(jsonlite::fromJSON(RCurl::getURL(paste0("https://min-api.cryptocompare.com/data/histoday?fsym=", 
                                                             coin,"&tsym=USD&limit=1000"))))
    
    fulldata<-rbind(fulldata,cbind(coin,data))
  }, error=function(e){cat("ERROR :",conditionMessage(e), "\n")})
}

#Formatting colums()
fulldata$Data.time<-as.Date(as.POSIXct(fulldata$Data.time, origin="1970-01-01"))
fulldata$TimeTo<-as.Date(as.POSIXct(fulldata$TimeTo, origin="1970-01-01"))
fulldata$TimeFrom<-as.Date(as.POSIXct(fulldata$TimeFrom, origin="1970-01-01"))

fulldata[fulldata$Data.close>0,][, .N, by = coin]
fulldata[fulldata$Data.close>0,][, .N, by = Data.time]

#fulldata[fulldata$Data.close>0,][, .N, by = coin]

filterdate<-Sys.Date()-(ObservationQuantity+1)

#Filtering coins having last 200 days of observations
datecount<-fulldata[fulldata$Data.close>0&fulldata$Data.time>filterdate,][, .N, by = coin]
datecount<-datecount[datecount$N==(ObservationQuantity+1),]

setkey(fulldata,coin)
setkey(datecount,coin)
fulldata<-fulldata[fulldata$Data.time>filterdate,][datecount,nomatch=0]

datafiltered<-fulldata[,c(1,5,6)]
filteredcoins<-unique(datafiltered$coin)

#Percent change created for each day
#mutate(datafiltered[datafiltered$coin=="BTC",],prev=lag(Data.close))

percchange<-data.table(NULL)

datafiltered$coin<-as.character(datafiltered$coin)

#Percent change loop
for(i in 1:length(filteredcoins))
{

    #coin<-as.character(datecount$coin)
    
    data<-mutate(datafiltered[datafiltered$coin==filteredcoins[i],],prev=lag(Data.close))
    
    data$change<-(data$prev/data$Data.close)-1
    
    percchange<-rbind(percchange,data[2:(ObservationQuantity+1),c(1,2,5)])

}


#write.csv(percchange,"Coin_Price_Changes_20181106_Full.csv")

# #Cross correlations are calculated
# crosscorr<-data.table(NULL)
# 
# for(i in 1:length(filteredcoins))
# {
#   for(j in 1:length(filteredcoins))
#   {
# var_1<-percchange[percchange$coin==filteredcoins[i],3]
# var_2<-percchange[percchange$coin==filteredcoins[j],3]
# 
# corr<-gtools::running(var_1, var_2, fun=cor, width=5, by=1, allow.fewer=TRUE, align=c("right"), simplify=TRUE)
# crosscorr<-rbind(crosscorr,cbind(Coin1=as.character(filteredcoins[i]),Coin2=as.character(filteredcoins[j]),corr))
#   }
# }
# 
# #Distances are calculated (d(i,j)=sqrt(2*(1-c(i,j))))
# distances<-cbind(crosscorr[,1:2],distance=sqrt(2*(1-as.numeric(crosscorr[,3]$corr))))
# 
# distance<-dist(crosscorr)
# 
# tree<-vegan::spantree(distance)

#melt(percchange, coin)

mstcoinqty<-50

#Filtering out Tether and TrueUSD
cast<-dcast(percchange[!(percchange$coin %in% c("USDT","TUSD")),][1:ObservationQuantity*mstcoinqty,],Data.time~coin,value.var="change")

cor.distance <- cor(cast[,-1])
corrplot::corrplot(cor.distance)

distance<-sqrt(2*(1-cor.distance))

library(igraph)
g1 <- graph.adjacency(distance, weighted = T, mode = "undirected", add.colnames = "label")
mst <- minimum.spanning.tree(g1)
plot(mst)

library(visNetwork)
mst_df <- get.data.frame( mst, what = "both" )
visNetwork( 
  data.frame(
    id = 1:nrow(mst_df$vertices) 
    ,label = mst_df$vertices
  )
  , mst_df$edges
) %>%
  visOptions( highlightNearest = TRUE)



nodes <- data.frame(id = 1:nrow(mst_df$vertices), 
                    label=mst_df$vertices
                    #color.background = c("red", "blue", "green"),
                    #color.highlight.background = c("red", NA, "red"), 
                    #shadow.size = c(5, 10, 15)
                    )

edges <- data.frame(from=mst_df$from,  to=mst_df$to,
  size=mst_df$weight
                    #from = c(1,2), to = c(1,3),
                    #label = LETTERS[1:2], 
                    #font.color =c ("red", "blue"), 
                    #font.size = c(10,20)
  )

visNetwork(nodes, mst_df$edges)  
%>%
  visOptions( highlightNearest = TRUE, nodesIdSelection = TRUE)
