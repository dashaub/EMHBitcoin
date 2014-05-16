#function filtertrading - Uses a filter rule to signal a buy on a n% rise and sell on a -n% fall for a price series x

filtertrading<-function(x,n){
	i<-2
	returns<-rep(NA,length(x))
	while(i<=length(x)){
		returns[i]<-(prices[i]-prices[i-1])/prices[i-1]
		i<-i+1
	}
	signal<-rep(NA,length(x))
	signal[2]<-"B"
	a<-3
	while(a<=length(x)){
		if(returns[a]>=n/100){
			signal[a]<-"B"
		}
		else if (returns[a]<=n/-100){
			signal[a]<-"S"
		}
		else{
			signal[a]<-"H"
		}
		a<-a+1
	}
	return(signal)
}
