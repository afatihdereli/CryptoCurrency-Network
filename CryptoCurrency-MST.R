setwd("C:/Users/fatih.dereli/Desktop/fatih/Personal/YL/IE7027 Financial Analysis")

#install.packages("coinmarketcapr")

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

#Coin list
prices<-get_marketcap_ticker_all_full()


#CryptoCompare

coinlist<-unique(prices$symbol)

fulldata<-data.table(NULL)

for(i in 1:200)
{
  tryCatch({
    coin<-prices$symbol[i]
    
    data<-data.frame(jsonlite::fromJSON(RCurl::getURL(paste0("https://min-api.cryptocompare.com/data/histoday?fsym=", 
                                                             coin,"&tsym=USD&limit=1000"))))
    
    fulldata<-rbind(fulldata,cbind(coin,data))
  }, error=function(e){cat("ERROR :",conditionMessage(e), "\n")})
}


fulldata$Data.time<-as.Date(as.POSIXct(fulldata$Data.time, origin="1970-01-01"))
fulldata$TimeTo<-as.Date(as.POSIXct(fulldata$TimeTo, origin="1970-01-01"))
fulldata$TimeFrom<-as.Date(as.POSIXct(fulldata$TimeFrom, origin="1970-01-01"))

fulldata[fulldata$Data.close>0,][, .N, by = coin]
fulldata[fulldata$Data.close>0,][, .N, by = Data.time]

datecount<-fulldata[fulldata$Data.close>0&fulldata$Data.time>='2018-04-07',][, .N, by = coin]
datecount<-datecount[datecount$N==201,]

setkey(fulldata,coin)
setkey(datecount,coin)
fulldata<-fulldata[datecount,nomatch=0][fulldata$Data.time>='2018-04-07',]

datafiltered<-fulldata[,c(1,5,6)]
filteredcoins<-unique(datafiltered$coin)

mutate(datafiltered[datafiltered$coin=="BTC",],prev=lag(Data.close))

percchange<-data.table(NULL)

for(i in 1:length(filteredcoins))
{

    coin<-filteredcoins[i]
    
    data<-mutate(datafiltered[datafiltered$coin==coin,],prev=lag(Data.close))
    
    data$change<-(data$prev/data$Data.close)-1
    
    percchange<-rbind(percchange,data[2:201,c(1,2,5)])

}


write.csv(percchange,"Coin_Price_Changes_20181024_Full.csv")

