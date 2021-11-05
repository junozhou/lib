#MongoDB 日期查询目前可通过Date 和ISODate两种方式：
#
#MongoDB条件对应关系

(>) 大于 - $gt
(<) 小于 - $lt
(>=) 大于等于 - $gte
(<= ) 小于等于 - $lte

#1.Date方式
#例如查询ct>=2012.12.7 且et<=2012.12.7：可翻译为
"ct":{$gte:new Date(2012,11,7)},"et":{$lte:new Date(2012,11,7)}
#如下是查询日期大于等于2016年12月1日的记录条数（注意，中间的月份写11，就是12月）

db.xxx.find({"ct":{$gte:new Date(2016,11,1)}})

#2.ISODate方式
ISODate("2016-01-01T00:00:00Z")

#3.示列
#以ISODate查询：

db.xxxx.find({"ct":{"$gt":ISODate("2017-04-20T01:16:33.303Z")}}) # 大于某个时间
db.xxxx.find({"ct":{"$lt":ISODate("2017-04-20T01:16:33.303Z")}}) # 小于某个时间
db.xxxx.find({"$and":[{"ct":{"$gt":ISODate("2017-04-20T01:16:33.303Z")}},{"ct":{"$lt":ISODate("2018-12-05T01:16:33
.303Z")}}]}) # 某个时间段
db.xxxx.find({"ct":{"$gte":ISODate("2017-04-20T01:16:33.303Z"),"$lte":ISODate("2018-12-05T01:16:33.303Z")}}) #某个时间段

#4.JAVA API操作
DBCollection dbcollection = xxx.getCollection("xxxxxx");
DBObject dbObject = new BasicDBObject();
String startDate = "2017-04-24 21:59:06";
String endDate = "2018-04-24 21:59:06";
SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
dbObject.put("$gte", sdf.parse(startDate));
dbObject.put("$lte",  sdf.parse(endDate));
DBObject ageCompare = new BasicDBObject();
ageCompare.put("ct",dbObject);
#//获取指定字段
DBObject fieldObject = new BasicDBObject();
fieldObject.put("user", true);
fieldObject.put("goods", true);
DBObject returnDB = dbcollection.findOne(ageCompare,fieldObject);
System.out.println(JsonUtil.toJson(returnDB));
#————————————————
#版权声明：本文为CSDN博主「码农致富」的原创文章，遵循CC 4.0 BY-SA版权协议，转载请附上原文出处链接及本声明。
#原文链接：https://blog.csdn.net/u011781521/article/details/81197781