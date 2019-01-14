library(quantmod)
# #get currency data from the FED FRED data series
# Korea <- getSymbols("DEXKOUS",src="FRED",auto.assign=FALSE) #load Korea
# Malaysia <- getSymbols("DEXMAUS",src="FRED",auto.assign=FALSE) #load Malaysia
# Singapore <- getSymbols("DEXSIUS",src="FRED",auto.assign=FALSE) #load Singapore
# Taiwan <- getSymbols("DEXTAUS",src="FRED",auto.assign=FALSE) #load Taiwan
# China <- getSymbols("DEXCHUS",src="FRED",auto.assign=FALSE) #load China
# Japan <- getSymbols("DEXJPUS",src="FRED",auto.assign=FALSE) #load Japan
# Thailand <- getSymbols("DEXTHUS",src="FRED",auto.assign=FALSE) #load Thailand
# Brazil <- getSymbols("DEXBZUS",src="FRED",auto.assign=FALSE) #load Brazil
# Mexico <- getSymbols("DEXMXUS",src="FRED",auto.assign=FALSE) #load Mexico
# India <- getSymbols("DEXINUS",src="FRED",auto.assign=FALSE) #load India
# USDOther <- getSymbols("DTWEXO",src="FRED",auto.assign=FALSE) #load US Dollar Other Trading Partners
#USDBroad <- getSymbols("DTWEXB",src="FRED",auto.assign=FALSE) #load US Dollar Broad
#Euro <- getSymbols("DEXUSEU",src="FRED",auto.assign=FALSE) #load US Dollar Broad
BTC <- getSymbols("BTCUSD=X",src="yahoo",auto.assign=FALSE)$"BTCUSD=X.Close" #load Korea
#ETH <- getSymbols("ETHUSD=X",src="yahoo",auto.assign=FALSE)$"ETHUSD=X.Close" #load Korea
Korea <- getSymbols("KRW=X",src="yahoo",auto.assign=FALSE)$"KRW=X.Close" #load Korea
Malaysia <- getSymbols("MYR=X",src="yahoo",auto.assign=FALSE)$"MYR=X.Close" #load Malaysia
Singapore <- getSymbols("SGD=X",src="yahoo",auto.assign=FALSE)$"SGD=X.Close" #load Singapore
Taiwan <- getSymbols("TWD=X",src="yahoo",auto.assign=FALSE)$"TWD=X.Close" #load Taiwan
China <- getSymbols("CNY=X",src="yahoo",auto.assign=FALSE)$"CNY=X.Close" #load China
Japan <- getSymbols("JPY=X",src="yahoo",auto.assign=FALSE)$"JPY=X.Close" #load Japan
Thailand <- getSymbols("THB=X",src="yahoo",auto.assign=FALSE)$"THB=X.Close" #load Thailand
Brazil <- getSymbols("BRL=X",src="yahoo",auto.assign=FALSE)$"BRL=X.Close" #load Brazil
Mexico <- getSymbols("MXN=X",src="yahoo",auto.assign=FALSE)$"MXN=X.Close" #load Mexico
India <- getSymbols("INR=X",src="yahoo",auto.assign=FALSE)$"INR=X.Close" #load India
USDOther <- getSymbols("DTWEXO",src="FRED",auto.assign=FALSE)#$"EUR=X.Close" #load US Dollar Other Trading Partners
Euro <- getSymbols("EUR=X",src="yahoo",auto.assign=FALSE)$"EUR=X.Close" #load US Dollar Broad
Turkish<-getSymbols("TRY=X",src="yahoo",auto.assign=FALSE)$"TRY=X.Close"
Pound<-getSymbols("GBP=X",src="yahoo",auto.assign=FALSE)$"GBP=X.Close"
Swiss<-getSymbols("CHF=X",src="yahoo",auto.assign=FALSE)$"CHF=X.Close"
Russian<-getSymbols("RUB=X",src="yahoo",auto.assign=FALSE)$"RUB=X.Close"
HongKong<-getSymbols("HKD=X",src="yahoo",auto.assign=FALSE)$"HKD=X.Close"
Australia<-getSymbols("AUD=X",src="yahoo",auto.assign=FALSE)$"AUD=X.Close"
Canada<-getSymbols("CAD=X",src="yahoo",auto.assign=FALSE)$"CAD=X.Close"
NewZealand<-getSymbols("NZD=X",src="yahoo",auto.assign=FALSE)$"NZD=X.Close"
Swedish<-getSymbols("SEK=X",src="yahoo",auto.assign=FALSE)$"SEK=X.Close"
Chile<-getSymbols("CLP=X",src="yahoo",auto.assign=FALSE)$"CLP=X.Close"
Czech<-getSymbols("CZK=X",src="yahoo",auto.assign=FALSE)$"CZK=X.Close"
Danish<-getSymbols("DKK=X",src="yahoo",auto.assign=FALSE)$"DKK=X.Close"
Hungarian<-getSymbols("HUF=X",src="yahoo",auto.assign=FALSE)$"HUF=X.Close"
Indonesian<-getSymbols("IDR=X",src="yahoo",auto.assign=FALSE)$"IDR=X.Close"
Israeli<-getSymbols("ILS=X",src="yahoo",auto.assign=FALSE)$"ILS=X.Close"
Pakistani<-getSymbols("PKR=X",src="yahoo",auto.assign=FALSE)$"PKR=X.Close"
Philippine<-getSymbols("PHP=X",src="yahoo",auto.assign=FALSE)$"PHP=X.Close"
Polish<-getSymbols("PLN=X",src="yahoo",auto.assign=FALSE)$"PLN=X.Close"
SouthAfrican<-getSymbols("ZAR=X",src="yahoo",auto.assign=FALSE)$"ZAR=X.Close"
Saudi<-getSymbols("SAR=X",src="yahoo",auto.assign=FALSE)$"SAR=X.Close"
Argentina<-getSymbols("ARS=X",src="yahoo",auto.assign=FALSE)$"ARS=X.Close"
Venezuela<-getSymbols("VEF=X",src="yahoo",auto.assign=FALSE)$"VEF=X.Close"
Iran<-getSymbols("IRR=X",src="yahoo",auto.assign=FALSE)$"IRR=X.Close"
Norway<-getSymbols("NOK=X",src="yahoo",auto.assign=FALSE)$"NOK=X.Close"
UAE<-getSymbols("AED=X",src="yahoo",auto.assign=FALSE)$"AED=X.Close"
Nigeria<-getSymbols("NGN=X",src="yahoo",auto.assign=FALSE)$"NGN=X.Close"
Colombia<-getSymbols("COP=X",src="yahoo",auto.assign=FALSE)$"COP=X.Close"
Bangladesh<-getSymbols("BDT=X",src="yahoo",auto.assign=FALSE)$"BDT=X.Close"
Egypt<-getSymbols("EGP=X",src="yahoo",auto.assign=FALSE)$"EGP=X.Close"
Vietnam<-getSymbols("VND=X",src="yahoo",auto.assign=FALSE)$"VND=X.Close"
Romania<-getSymbols("RON=X",src="yahoo",auto.assign=FALSE)$"RON=X.Close"
Peru<-getSymbols("PEN=X",src="yahoo",auto.assign=FALSE)$"PEN=X.Close"
Iraq<-getSymbols("IQD=X",src="yahoo",auto.assign=FALSE)$"IQD=X.Close"
Algeria<-getSymbols("DZD=X",src="yahoo",auto.assign=FALSE)$"DZD=X.Close"
Qatar<-getSymbols("QAR=X",src="yahoo",auto.assign=FALSE)$"QAR=X.Close"
Kazakhstan<-getSymbols("KZT=X",src="yahoo",auto.assign=FALSE)$"KZT=X.Close"
Angola<-getSymbols("AOA=X",src="yahoo",auto.assign=FALSE)$"AOA=X.Close"
Kuwait<-getSymbols("KWD=X",src="yahoo",auto.assign=FALSE)$"KWD=X.Close"
Sudan<-getSymbols("SDG=X",src="yahoo",auto.assign=FALSE)$"SDG=X.Close"

#USDOther<-1/USDOther


#combine all the currencies into one big currency xts
currencies<-merge(BTC,
                  #ETH,
                  Korea, Malaysia, Singapore, Taiwan,
                  China, Japan, Thailand, Brazil, Mexico, India,
                  USDOther, 
                  #USDBroad,
                  Euro,
                  Turkish,
                  Pound,
                  Swiss,
                  Russian,
                  HongKong,
                  Australia,
                  Canada,
                  NewZealand,
                  Swedish,
                  Chile,
                  Czech,
                  Danish,
                  Hungarian,
                  Indonesian,
                  Israeli,
                  Pakistani,
                  Philippine,
                  Polish,
                  #SouthAfrican,
                  Saudi,
                  Argentina,
                  Venezuela,
                  Iran,
                  Norway,
                  UAE,
                  Nigeria,
                  Colombia,
                  Bangladesh,
                  Egypt,
                  Vietnam,
                  Romania,
                  Peru,
                  Iraq,
                  Algeria,
                  Qatar,
                  Kazakhstan,
                  #Angola,
                  Kuwait,
                  Sudan)

currencies<-na.omit(currencies)

colnames(currencies)<-c("BTC",
                        #"ETH",
                        "KRW", "MYR", "SGD", "TWD",
                        "CNY", "JPY", "THB", "BRL", "MXN", "INR",
                        "USD",
                        # "USDBroad",
                        "EUR",
                        "TRY",
                        "GBP",
                        "CHF",
                        "RUB",
                        "HKD",
                        "AUD",
                        "CAD",
                        "NZD",
                        "SEK",
                        "CLP",
                        "CZK",
                        "DKK",
                        "HUF",
                        "IDR",
                        "ILS",
                        "PKR",
                        "PHP",
                        "PLN",
                        #"ZAR",
                        "SAR",
                        "ARS",
                        "VEF",
                        "IRR",
                        "NOK",
                        "AED",
                        "NGN",
                        "COP",
                        "BDT",
                        "EGP",
                        "VND",
                        "RON",
                        "PEN",
                        "IQD",
                        "DZD",
                        "QAR",
                        "KZT",
                        #"AOA",
                        "KWD",
                        "SDG")
#get daily percent changes
currencies <- currencies/lag(currencies)-1  
currencies[1,] <- 0
#currencies<-data.frame(currencies)

#currencies<-data.frame(date=index(currencies), coredata(currencies))

filtered<-currencies[(nrow(currencies)-365):nrow(currencies),]
#filtered<-currencies

cor.distance <- cor(filtered)
corrplot::corrplot(cor.distance)
distance<-sqrt(2*(1-cor.distance))

library(igraph)
g1 <- graph.adjacency(distance, weighted = T, mode = "undirected", add.colnames = "label")
mst <- minimum.spanning.tree(g1)
plot(mst)

library(visNetwork)
mst_df <- get.data.frame( mst, what = "both" )


colors<-cbind(mst_df$vertices,color=NA)
colors[colors$label=='BTC',]$color<-"orange"
colors[colors$label=='USD',]$color<-"red"
colors[colors$label=='EUR',]$color<-"yellow"
colors[colors$label=='GBP',]$color<-"green"
colors[colors$label=='RUB',]$color<-"black"
colors[colors$label=='TRY',]$color<-"brown"

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

# visNetwork( 
#   data.frame(
#     id = 1:nrow(mst_df$vertices) 
#     ,label = mst_df$vertices
#   )
#   , mst_df$edges
# ) %>%
#   visOptions( highlightNearest = TRUE)

clus<-as.hclust(vegan::spantree(distance))
plot(clus)
#plot(clus,vis)


source("http://addictedtor.free.fr/packages/A2R/lastVersion/R/code.R")
# colored dendrogram
op = par(bg = "#EFEFEF")
A2Rplot(clus, k = 9, boxes = FALSE, col.up = "gray50")
