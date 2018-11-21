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

write.csv(prices,"CoinMarketCap_20181120.csv")

#CryptoCompare Price History Loop

coinlist<-unique(prices$symbol)

fulldata<-data.table(NULL)

for(i in 1:200)
{
  tryCatch({
    coin<-prices$symbol[i]
    
    data<-data.frame(jsonlite::fromJSON(RCurl::getURL(paste0("https://min-api.cryptocompare.com/data/histoday?fsym=", 
                                                             coin,"&tsym=USD&limit=1000")))$Data)
    
    fulldata<-rbind(fulldata,cbind(coin,data))
  }, error=function(e){cat("ERROR :",conditionMessage(e), "\n")})
}

#Formatting colums()
fulldata$Data.time<-as.Date(as.POSIXct(fulldata$time, origin="1970-01-01"))
#fulldata$TimeTo<-as.Date(as.POSIXct(fulldata$TimeTo, origin="1970-01-01"))
#fulldata$TimeFrom<-as.Date(as.POSIXct(fulldata$TimeFrom, origin="1970-01-01"))

fulldata[fulldata$close>0,][, .N, by = coin]
fulldata[fulldata$close>0,][, .N, by = Data.time]

#fulldata[fulldata$Data.close>0,][, .N, by = coin]

ObservationQuantity<-500

shiftbackperiod<-1

mindate<-Sys.Date()-(ObservationQuantity+1)-shiftbackperiod
maxdate<-Sys.Date()-1-shiftbackperiod

#Filtering coins having last 200 days of observations
datecount<-fulldata[fulldata$close>0&fulldata$Data.time>=mindate&fulldata$Data.time<=maxdate,][, .N, by = coin]
datecount<-datecount[datecount$N==(ObservationQuantity+1),]

setkey(fulldata,coin)
setkey(datecount,coin)
datafiltered<-fulldata[fulldata$Data.time>=mindate&fulldata$Data.time<=maxdate,][datecount,nomatch=0]

#???datafiltered<-fulldata[,c(1,5,6)]
datafiltered<-datafiltered[,c(1,3,9)]
filteredcoins<-unique(datafiltered$coin)

#Percent change created for each day
#mutate(datafiltered[datafiltered$coin=="BTC",],prev=lag(Data.close))

percchange<-data.table(NULL)

datafiltered$coin<-as.character(datafiltered$coin)

#Percent change loop
for(i in 1:length(filteredcoins))
{

    #coin<-as.character(datecount$coin)
    
    data<-mutate(datafiltered[datafiltered$coin==filteredcoins[i],],prev=lag(close))
    
    data$change<-(data$close/data$prev)-1
    
    #percchange<-rbind(percchange,data[2:(ObservationQuantity+1),c(1,2,5)])
    
    percchange<-rbind(percchange,data[2:(ObservationQuantity+1),c(1,3,5)])

}


#write.csv(percchange,"Coin_Price_Changes_20181115_Full.csv")

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
#cast<-dcast(percchange[1:ObservationQuantity*mstcoinqty,],Data.time~coin,value.var="change")


cor.distance <- cor(cast[,-1])
corrplot::corrplot(cor.distance)

###Partial cross correlation ekleyelim

distance<-sqrt(2*(1-cor.distance))

library(igraph)
#directed/undirected
g1 <- graph.adjacency(distance, weighted = T, mode = "undirected", add.colnames = "label")
mst <- minimum.spanning.tree(g1)
plot(mst)

library(visNetwork)
mst_df <- get.data.frame( mst, what = "both" )
# visNetwork( 
#   data.frame(
#     id = 1:nrow(mst_df$vertices) 
#     ,label = mst_df$vertices
#   )
#   , mst_df$edges
# ) %>%
#   visOptions( highlightNearest = TRUE)

colors<-cbind(mst_df$vertices,color=NA)
colors[colors$label=='BTC',]$color<-"orange"
colors[colors$label=='LTC',]$color<-"red"
colors[colors$label=='ETH',]$color<-"yellow"
colors[colors$label=='XRP',]$color<-"green"
colors[colors$label=='XLM',]$color<-"black"
colors[colors$label=='EOS',]$color<-"brown"

nodes <- data.frame(id = 1:nrow(mst_df$vertices), 
                    label=mst_df$vertices
                    ,color.background=colors$color
                    #,color.background=c(rep(NA,6),"orange",rep(NA,43))
                    #color.background = c("red", "blue", "green"),
                    #color.highlight.background = c("red", NA, "red"), 
                    #shadow.size = c(5, 10, 15)
                    )

edges <- data.frame(from=mst_df$edges$from,  to=mst_df$edges$to,
  size=mst_df$edges$weight
                    #from = c(1,2), to = c(1,3),
                    #label = LETTERS[1:2],
                    #font.color =c ("red", "blue"),
                    #font.size = c(10,20)
  )

vis<-visOptions(visNetwork(nodes, edges), highlightNearest = TRUE, nodesIdSelection = TRUE)


clus<-as.hclust(vegan::spantree(distance))
plot(clus)
plot(clus,vis)


dendrogram <- cluster_edge_betweenness(g1)
plot(dendrogram,vis)



# vector of colors labelColors = c('red', 'blue', 'darkgreen', 'darkgrey',
# 'purple')
labelColors = c("#CDB380", "#036564", "#EB6841", "#EDC951")
# cut dendrogram in 4 clusters
clusMember = cutree(clus, 4)
# function to get color labels
colLab <- function(n) {
  if (is.leaf(n)) {
    a <- attributes(n)
    labCol <- labelColors[clusMember[which(names(clusMember) == a$label)]]
    attr(n, "nodePar") <- c(a$nodePar, lab.col = labCol)
  }
  n
}
# using dendrapply
clusDendro = dendrapply(dendrogram, colLab)
# make plot
plot(clusDendro, main = "Cool Dendrogram", type = "triangle")




# load code of A2R function
source("http://addictedtor.free.fr/packages/A2R/lastVersion/R/code.R")
# colored dendrogram
op = par(bg = "#EFEFEF")
A2Rplot(clus, k = 9, boxes = FALSE, col.up = "gray50")
        #, col.down = c("#FF6B6B", "#4ECDC4", "#556270"))


install.packages("ape")
plot(ape::as.phylo(clus), type = "fan")



# add colors randomly(clustera göre renk atanabilir)
plot(ape::as.phylo(clus), type = "fan", tip.color = hsv(runif(15, 0.65, 
                                                       0.95), 1, 1, 0.7), edge.color = hsv(runif(10, 0.65, 0.75), 1, 1, 0.7), edge.width = runif(20, 
                                                                                                                                                 0.5, 3), use.edge.length = TRUE, col = "gray80")


install.packages("ggdendro")
# another option
ggdendro::ggdendrogram(clus, rotate = TRUE, size = 4, theme_dendro = FALSE)
