#Python将字符串转换成ObjectId类型
#MongoDB自动生成的_id是ObjectId类型的。
#我需要将MongoDB的_id存到ElasticSearch中，而ElasticSearch又只能存String类型的_id，所以就涉及到两种类型的转换。

#ObjectId类型 —→ String类型
#这个非常简单，直接强制类型转换就可以了


_id = str(ObjectId('类型'))

#String类型 —→ ObjectId类型
#这个难就难在不知道ObjectId类型从哪里找

from bson.objectid import ObjectId
_id = ObjectId("字符串")

#————————————————
#版权声明：本文为CSDN博主「鬼义II虎神」的原创文章，遵循CC 4.0 BY-SA版权协议，转载请附上原文出处链接及本声明。
#原文链接：https://blog.csdn.net/u013487601/article/details/104836724