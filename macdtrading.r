#function macdtrading - Takes an input price series x with short-period ema n, long-period ema n, and k signal period and returns a buy, sell, or no change signal using the macd rule
#Dependencies - ema.r

macdtrading<-function(x,n,m,k){
	source("ema.r")
	source("macd.r")
	emaout<-macd(x,n,m,k)
	start<-min(which(emaout!="NA"))
	signal<-rep(NA,length(x))
	signal[start]<-"B"
	i<-start+1
	while(i<=length(x)){
		if(emaout[i]<0){
			signal[i]<-"B"
		}
		else if(emaout[i]>0){
			signal[i]<-"S"
		}
		else{
			signal[i]<-"H"
		}	
		i<-i+1
	}
	
	return(signal)
}
