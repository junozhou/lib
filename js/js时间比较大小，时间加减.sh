第一种：

//时间类比较

startTime= new Date(Date.parse(starttime));
endTime=new Date(Date.parse(endTime));
//进行比较
startTime>endTime



第二种：
//时间戳比较
startTime=Date.parse(starttime);
endTime=Date.parse(endTime);
//进行比较
startTime>endTime