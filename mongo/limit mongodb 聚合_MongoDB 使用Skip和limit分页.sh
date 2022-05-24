使用Skip和limit可以如下做数据分页：

Code:

page1 = db.things.find().limit(20)

page2 = db.things.find().skip(20).limit(20)

page3 = db.things.find().skip(40).limit(20)

#备注：可用于分页，limit是pageSize，skip是第n-1页*pageSize (n-1表示几  第1,2...页)　　　　  skip表示跳过  多少条数据，　　　聚合管道的优化
#
#1.$sort  +  $skip  +  $limit顺序优化
#
#如果在执行管道聚合时，如果$sort、$skip、$limit依次出现的话，例如：

{ $sort: { age : -1 } },

{ $skip: 10 },

{ $limit: 5 }

那么实际执行的顺序为：

{ $sort: { age : -1 } },

{ $limit: 15 },

{ $skip: 10 }

$limit会提前到$skip前面去执行。

此时$limit = 优化前$skip+优化前$limit

这样做的好处有两个:

1.在经过$limit管道后，管道内的文档数量个数会“提前”减小，这样会节省内存，提高内存利用效率。

2.$limit提前后，$sort紧邻$limit这样的话，当进行$sort的时候当得到前“$limit”个文档的时候就会停止。

当数据量很小时，这样做分页完全没有问题。但是当数据量很大时，skip操作会变的很慢，应该避免使用。

(不止是mongoDb会这样，大部分数据库都是。)可以通过改变查询文档的规则来达到分页效果，避免使用skip来跳过大量的数据。


#————————————————
#版权声明：本文为CSDN博主「BPATY」的原创文章，遵循CC 4.0 BY-SA版权协议，转载请附上原文出处链接及本声明。
#原文链接：https://blog.csdn.net/weixin_42623010/article/details/111896923