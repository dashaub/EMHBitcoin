#Tests for Week-day Effect
library("tseries")

setwd("/Users/usr/Documents/")
fpath<-"/Users/usr/Desktop/quandldata/Repaired/"
aname<-"MTGOXUSD"
fname<-paste0(aname,".csv")
mydata<-read.csv(file=paste0(fpath,fname),header=T)
price<-mydata$Close
returns<-diff(price)/price[-length(price)]
sink(paste0(aname,".txt"),split=T)
print(paste0("Testing week-day effect for ",fname))
wday<-weekdays(as.Date(mydata$Date))

#initialize dummy variables for weekdays
su<-rep(0,length(returns))
mo<-rep(0,length(returns))
tu<-rep(0,length(returns))
we<-rep(0,length(returns))
th<-rep(0,length(returns))
fr<-rep(0,length(returns))
sa<-rep(0,length(returns))

i<-2
while(i<=length(wday))
	{
	if(wday[i]=="Sunday")
		{
		su[i-1]<-1
		}
	else if(wday[i]=="Monday")
		{
		mo[i-1]<-1
		}
	else if(wday[i]=="Tuesday")
		{
		tu[i-1]<-1
		}
	else if(wday[i]=="Wednesday")
		{
		we[i-1]<-1
		}
	else if(wday[i]=="Thursday")
		{
		th[i-1]<-i
		}
	else if(wday[i]=="Friday")
		{
		fr[i-1]<-1
		}
	else
		{
		sa[i-1]<-1
		}
	i<-i+1
	}

#Test for week-day effect
library(robustbase)
#Uses the robustbase package for robust analysis with HAC standard errors
mo<-lmrob(returns~su+mo+tu+we+th+fr)
print(summary(mo))

#Test for weekend effect
sasu<-sa+su
weffect<-lmrob(returns~sasu+0)
print(summary(weffect))
sink()

