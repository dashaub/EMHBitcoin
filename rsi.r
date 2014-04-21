#function rsi - calculate the n period relative strength index for a series x
#Dependencies - ema.r

rsi<-function(x,n){
	ups<-rep(NA,length(x))
	downs<-rep(NA,length(x))
	i<-2
	while(i<=length(x)){
		if(x[i]>x[i-1]){
			ups[i]<-x[i]-x[i-1]
			downs[i]<-0
		}
		else if(x[i]<x[i-1]){
			downs[i]<-x[i-1]-x[i]
			ups[i]<-0
		}
		else{
			ups[i]<-0
			downs[i]<-0
		}
		i<-i+1
	}
	
	#Calculate RSI
	emaups<-ema(ups,n)
	emadowns<-ema(downs,n)
	rs<-ema(ups,n)/ema(downs,n)
	return(100-(100/(1+rs)))
}
