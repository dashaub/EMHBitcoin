#FilterTradingEngine - Calculates the simulated returns for a buy and hold vs active trading strategy


fname<-"MTGOXPLN"

setwd("/Users/usr/Desktop/quandldata/")
mydata<-read.csv(paste0("/Users/usr/Desktop/quandldata/Repaired/",fname,".csv"),header=T)
prices<-mydata$Close
date<-mydata$Date


#Calculate performance of MACD
n<- -10
source("filtertrading.r")
filtersignal<-filtertrading(prices,n)

start<-min(which(filtersignal!="NA"))
coins<-rep(0,length(prices))
fiat<-rep(0,length(prices))
buys<-0
sells<-0
owning<-F

fiat[start]<-100
i<-start
while(i<=length(prices)){
	if((filtersignal[i]=="B") && (owning==F)){
		coins[i:length(prices)]<-fiat[i]/prices[i]
		owning<-T
		buys<-buys+1
		fiat[i:length(prices)]<-0
	}
	else if ((filtersignal[i]=="S") && (owning==T)){
		fiat[i:length(prices)]<-coins[i]*prices[i]
		owning<-F
		sells<-sells+1
		coins[i:length(prices)]<-0
		
	
	}
	i<-i+1
}
#Calculate bitcoin equivalent of all holdings
btceqv<-coins+fiat/prices
myout<-data.frame(date,prices,coins,fiat,btceqv)
setwd("/Users/usr/Documents/")
write.csv(myout,file=paste0(fname,"filter.csv"),row.names=F)

