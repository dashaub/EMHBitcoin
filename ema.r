#function ema - calculates the n-period exponential moving average of a series x

ema<-function(x,n){
	emaout<-rep(NA,length(x))
	emaexp<-2/(n+1)
	i<-n
	emaout[i]<-sum(1:n)/n
	while(i<length(x)){
		i<-i+1
		emaout[i]<-(x[i]*emaexp+emaout[i-1]*(1-emaexp))
	}
	
	return(emaout)
}
