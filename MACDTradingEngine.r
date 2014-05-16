#MACDTradingEngine - Calculates the simulated returns for a buy and hold vs active trading strategy
#Dependencies - ema.r, macd.r, and macdtrading.r


fname<-"MTGOXUSD"

setwd("/Users/usr/Desktop/quandldata/")
mydata<-read.csv(paste0("/Users/usr/Desktop/quandldata/Repaired/",fname,".csv"),header=T)
prices<-mydata$Close
date<-mydata$Date


#Calculate performance of MACD
n<-12
m<-26
k<-9
source("macdtrading.r")
macdsignal<-macdtrading(prices,n,m,k)

start<-min(which(macdsignal!="NA"))
coins<-rep(0,length(prices))
fiat<-rep(0,length(prices))
buys<-0
sells<-0
owning<-F

fiat[start]<-100
i<-start
while(i<=length(prices)){
	if((macdsignal[i]=="B") && (owning==F)){
		coins[i:length(prices)]<-fiat[i]/prices[i]
		owning<-T
		buys<-buys+1
		fiat[i:length(prices)]<-0
	}
	else if ((macdsignal[i]=="S") && (owning==T)){
		fiat[i:length(prices)]<-coins[i]*prices[i]
		owning<-F
		sells<-sells+1
		coins[i:length(prices)]<-0
		
	
	}
	i<-i+1
}
#Calculate bitcoin equivalent of all holdings
btceqv<-coins+fiat/prices
scaled<-100*btceqv/btceqv[min(which(btceqv!=0))]
myout<-data.frame(date,prices,coins,fiat,btceqv,scaled)
setwd("/Users/usr/Documents/")
write.csv(myout,file=paste0(fname,"macd.csv"),row.names=F)

