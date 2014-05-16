#function rsitrading - Takes an input price series x, rsi period n, and symmmetric buy boundary k and returns a buy, sell, or no change signal
#Dependencies - rsi.r and ema.r

rsitrading<-function(x,n,k){
	source("ema.r")
	source("rsi.r")
	rsiout<-rsi(x,n)
	signal<-rep(NA,length(x))
	signal[n]<-"B"
	i<-n+1
	while(i<length(x)){
		if(rsiout[i]<=k){
			signal[i]<-"B"
		}
		else if(rsiout[i]>=(100-k)){
			signal[i]<-"S"
		}
		else{
			signal[i]<-"H"
		}
		i<-i+1
	}
	
	return(signal[1:length(x)-1])
}
