 MongoDB的destinct命令是获取特定字段中不同值列表。该命令适用于普通字段，数组字段和数组内嵌文档.

 mongodb的distinct的语句：

 复制代码代码如下:

 db.users.distinct('last_name'）
 等同于 SQL 语句：

 复制代码代码如下:

 select DISTINCT last_name from users