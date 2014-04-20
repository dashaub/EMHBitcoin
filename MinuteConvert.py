import datetime
import time
import csv
#Requires pandas and its dependencies dateutil and numpy
import pandas as pd
import numpy as np
#Uses accelerated library numexpr and bottleneck
import dateutil


tick=time.clock()
fpath="E:/Data/"
fname=".btceRUR.csv"
filename=fpath+fname
d=pd.read_csv(filename,header=None)

unixtime=d[0]
price=d[1]
volume=d[2]
timecounter=min(d[0])
mintime=min(d[0])
endtime=max(d[0])
length=endtime-timecounter
#remainsec=[0]*length
qcount=0
weightedsum=0
wsum=d[1]*d[2]
count=1
outcount=0
volumecount=0

startsec=int(datetime.datetime.fromtimestamp(min(d[0])).strftime('%S'))
offset=60-startsec
endsec=int(datetime.datetime.fromtimestamp(max(d[0])).strftime('%S'))
eoffset=60-endsec
processedtime=list(range(mintime+offset,endtime+eoffset+1,60))
count=-offset
processedprice=[0,]*len(processedtime)
processedvolume=[0,]*len(processedtime)

for i in range(mintime,endtime+1):
    if(d[0][qcount]==i):
        weightedsum+=wsum[qcount]
        volumecount+=d[2][qcount]
        if(d[0][qcount]==d[0][qcount+1]):
            i-=1
        qcount+=1
    if(count%60==0):
        if(volumecount==0):
            processedprice[outcount]=processedprice[outcount-1]
            processedvolume[outcount]=0
        else:
            processedprice[outcount]=weightedsum/volumecount
            processedvolume[outcount]=volumecount
        volumecount=0
        weightedsum=0
        outcount+=1
    count+=1

#write to file

import csv
print("Finished processing "+fname+". Now writing to file")

opath="E:/Data/pminute/"
my_output = open(opath+fname,'w')
mywriter=csv.writer(my_output)

data = [processedtime,processedprice,processedvolume]

for i in range(len(data[0])):
    row = [data[j][i] for j in range(len(data))]
    mywriter.writerow(row)
my_output.close()

tock=time.clock()
print(tock-tick)
#for i in range(1,length):
   #remainsec[i]=datetime.datetime.fromtimestamp(d[0][i]).strftime('%S')
#count=1
#while(count<5000000):
#    if(count%100000==0):
#        print(count)
#    count+=1
#df=DataFrame(d)
#DataFrame(d,columns=['unixtime','price','volume'])
#DataFrame(df,index=["unixtime","price","volume"]
#saved_column=df.column_name
#names=df.name
