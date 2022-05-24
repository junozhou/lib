#将applicationCaller为null的数据替换为all
db.mockStub.update({'applicationCaller':null},{$set:{'applicationCaller':'all'}},{multi:true});



db.mockStub.update({'type':'mongodb'},{$set:{'applicationCaller':'all'}},{multi:true});
