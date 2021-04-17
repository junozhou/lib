#将applicationCaller为null的数据替换为all
db.mockStub.update({'applicationCaller':null},{$set:{'applicationCaller':'all'}},{multi:true});
