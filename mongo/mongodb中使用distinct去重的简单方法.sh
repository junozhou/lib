无条件排重

db.getCollection("表名").distinct("字段名");

2.query为去重的筛选条件，为可选字段。

有条件排重

db.getCollection("表名").distinct('字段名',{筛选条件})

3.options 为其他选项一般应用较少

db.getCollection("表名").distinct('字段名',{筛选条件}，{

collation: {

locale: ,

caseLevel: ,

caseFirst: ,

strength: ,

numericOrdering: ,

alternate: ,

maxVariable: ,

backwards:

}})

去除重复的表名

db.collection.distinct()

distinct 有去重上限

Error: distinct too big, 16mb cap


 MongoDB的destinct命令是获取特定字段中不同值列表。该命令适用于普通字段，数组字段和数组内嵌文档.

 mongodb的distinct的语句：

 复制代码代码如下:

 db.users.distinct('last_name'）
 等同于 SQL 语句：

 复制代码代码如下:

 select DISTINCT last_name from users